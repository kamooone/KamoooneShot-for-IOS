//
//  Explosion.swift
//  KamoooneShot for IOS
//
//  Created by Kazusa Kondo on 2022/01/30.
//

import Foundation
import SpriteKit

class ExplosionView {
    private var explosion: [SKTexture] = []
    private var sprite: [SKSpriteNode] = []
    public var isExplosion: [Bool] = []
    
    func Init(){
        // テクスチャアトラスのフォルダ名を指定
        let atlas = SKTextureAtlas(named: "explosion")
        // 爆発のテクスチャのスプライト数分
        for i in 0...15{
            explosion.append(atlas.textureNamed("explosion" + String(i+1)))
        }
        for _ in 0...EnemyView.ENEMYMAX{
            isExplosion.append(false)
            sprite.append(SKSpriteNode(texture: explosion[15]))
        }
    }
    
    func StartExplosion(x:CGFloat, y:CGFloat, cnt:Int){
        sprite[cnt].position = CGPoint(x: x, y: y)
        GameManager.shared.scene?.addChild(sprite[cnt])
        
        /** Creates an action that repeats another action a specified number of times
         @param action The action to execute
         @param count The number of times to execute the action
         */
        let animation = SKAction.animate(with: explosion, timePerFrame: 0.125)
        sprite[cnt].run(SKAction.repeat(animation, count: 1))
    }
    
    func Update(){
        for i in 0...EnemyView.ENEMYMAX{
            if !(sprite[i].hasActions() && isExplosion[i] ) {
                sprite[i].removeFromParent()
            }
        }
    }
}

