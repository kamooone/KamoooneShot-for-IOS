//
//  Explosion.swift
//  KamoooneShot for IOS
//
//  Created by Kazusa Kondo on 2022/01/30.
//

import Foundation
import SpriteKit

class ExplosionView {
    var explosion: [SKTexture] = []
    var sprite: [SKSpriteNode] = []
    var isExplosion: [Bool] = []

    init(_MAX: Int, _width: CGFloat, _height: CGFloat) {
        // テクスチャアトラスのフォルダ名を指定
        let atlas = SKTextureAtlas(named: "explosion")
        // 爆発のテクスチャのスプライト数分
        for i in 0...15{
            explosion.append(atlas.textureNamed("explosion" + String(i+1)))
        }
        for i in 0..._MAX {
            isExplosion.append(false)
            sprite.append(SKSpriteNode(texture: explosion[15]))
            sprite[i].size = CGSize(width: _width, height: _height)
        }
    }
    
    func StartExplosion(x:CGFloat, y:CGFloat, cnt:Int) {
        sprite[cnt].position = CGPoint(x: x, y: y)
        GameManager.shared.scene?.addChild(sprite[cnt])

        /** Creates an action that repeats another action a specified number of times
         @param action The action to execute
         @param count The number of times to execute the action
         */
        let animation = SKAction.animate(with: explosion, timePerFrame: 0.125)
        sprite[cnt].run(SKAction.repeat(animation, count: 1))
    }
    
    func Update(_num: Int) {
        // 表示する必要がなくなったスプライトを削除する処理
        if !(sprite[_num].hasActions() && isExplosion[_num] ) {
            sprite[_num].position.x = GameManager.shared.OUT_OF_SCREEN_AREA
            sprite[_num].position.y = GameManager.shared.OUT_OF_SCREEN_AREA
            isExplosion[_num] = false
            sprite[_num].removeFromParent()
        }
    }
}

