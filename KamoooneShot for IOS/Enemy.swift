//
//  Enemy.swift
//  KamoooneShot for IOS
//
//  Created by Kazusa Kondo on 2022/01/23.
//

import Foundation
import SpriteKit

class Enemy {
    private final var ENEMYMAX: Int = 20
    private var _enemy: [SKSpriteNode] = []
    //private var _enemyBullet: [SKSpriteNode] = []
    private var rotateAction :SKAction!
    
    func Init(){
        // 指定した回転値まで回転させるアクションを作る.
        rotateAction = SKAction.rotate( toAngle: DegreeToRadian(Degree: 180.0) , duration: 1)
        
        // エネミーの生成
        for i in 0..<ENEMYMAX {
            _enemy.append(SKSpriteNode(imageNamed: "enemy.png"))
            _enemy[i].position = CGPoint(x: CGFloat.random(in: GameManager.scene!.frame.minX+25..<GameManager.scene!.frame.maxX-25), y: CGFloat.random(in: GameManager.scene!.frame.minY+150..<GameManager.scene!.frame.maxY))
            _enemy[i].zRotation = DegreeToRadian(Degree: 180)
            GameManager.scene!.addChild(_enemy[i])
        }
    }
    
    func Move(){
    
    }
    
    func Update(){
        // エネミー移動処理
        //for i in 0..<ENEMYMAX {
            //_enemy[i].position.y -= 1
        //}
    }
    
    func DegreeToRadian(Degree : Double!)-> CGFloat{
        return CGFloat(Degree) / CGFloat(180.0 * M_1_PI)
    }
}



