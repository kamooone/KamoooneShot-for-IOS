//
//  Enemy.swift
//  KamoooneShot for IOS
//
//  Created by Kazusa Kondo on 2022/01/23.
//

import Foundation
import SpriteKit

class Enemy {
    public static let ENEMYMAX: Int = 20
    private static var enemy: [SKSpriteNode] = []
    //private var Enemy.enemyBullet: [SKSpriteNode] = []
    private var rotateAction :SKAction!
    private var explosion = Explosion()
    
    func Init(){
        // 指定した回転値まで回転させるアクションを作る.
        //rotateAction = SKAction.rotate( toAngle: DegreeToRadian(Degree: 180.0) , duration: 1)
        
        // エネミーの生成
        for i in 0..<Enemy.ENEMYMAX {
            Enemy.enemy.append(SKSpriteNode(imageNamed: "enemy.png"))
            Enemy.enemy[i].position = CGPoint(x: CGFloat.random(in: GameManager.scene!.frame.minX+25..<GameManager.scene!.frame.maxX-25), y: CGFloat.random(in: GameManager.scene!.frame.minY+150..<GameManager.scene!.frame.maxY))
            Enemy.enemy[i].zRotation = DegreeToRadian(Degree: 180)
            GameManager.scene!.addChild(Enemy.enemy[i])
        }
        explosion.Init()
    }
    
    func Move(){
    
    }
    
    func Update(){
        // エネミー移動処理
        //for i in 0..<ENEMYMAX {
            //Enemy.enemy[i].position.y -= 1
        //}
        
        explosion.Update()
    }
    
    func DegreeToRadian(Degree : Double!)-> CGFloat{
        return CGFloat(Degree) / CGFloat(180.0 * M_1_PI)
    }
    
    public static func GetEnemyPos() -> [SKSpriteNode] {
        return Enemy.enemy
    }
    
}



