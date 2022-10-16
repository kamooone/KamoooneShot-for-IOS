//
//  EnemyView.swift
//  KamoooneShot for IOS
//
//  Created by Kazusa Kondo on 2022/01/23.
//

import Foundation
import SpriteKit

class EnemyView {
    public static let ENEMYMAX: Int = 20
    private static var enemy: [SKSpriteNode] = []
    private static var bullet: [BulletView] = []
    //private var EnemyView.enemyBullet: [SKSpriteNode] = []
    private var rotateAction :SKAction!
    private var explosion = ExplosionView()
    
    func Init(){
        // 指定した回転値まで回転させるアクションを作る.
        //rotateAction = SKAction.rotate( toAngle: DegreeToRadian(Degree: 180.0) , duration: 1)
        
        // エネミーの生成
        for i in 0..<EnemyView.ENEMYMAX {
            EnemyView.enemy.append(SKSpriteNode(imageNamed: "enemy.png"))
            EnemyView.enemy[i].position = CGPoint(x: CGFloat.random(in: (GameManager.shared.scene?.frame.minX)! + 25..<(GameManager.shared.scene?.frame.maxX)! - 25), y: CGFloat.random(in: (GameManager.shared.scene?.frame.maxY)! + 150..<(GameManager.shared.scene?.frame.maxY)! + 600))
            EnemyView.enemy[i].zRotation = DegreeToRadian(Degree: 180)
            GameManager.shared.scene?.addChild(EnemyView.enemy[i])
            EnemyView.bullet.append(BulletView())
            EnemyView.bullet[i].Init()
        }
        explosion.Init()
    }
    
    func Move(){
    
    }
    
    func Update(){
        // エネミー移動処理
        for i in 0..<EnemyView.ENEMYMAX {
            EnemyView.enemy[i].position.y -= 1
        }
        
        // エネミー弾
        for i in 0..<EnemyView.ENEMYMAX {
            if EnemyView.enemy[i].position.y <= (GameManager.shared.scene?.frame.maxY)! - 50 {
                EnemyView.bullet[i].UpdateForEnemy(x: EnemyView.enemy[i].position.x, y: EnemyView.enemy[i].position.y)
            }
        }
        explosion.Update()
    }
    
    func DegreeToRadian(Degree : Double!)-> CGFloat{
        return CGFloat(Degree) / CGFloat(180.0 * M_1_PI)
    }
    
    public static func GetEnemyPos() -> [SKSpriteNode] {
        return EnemyView.enemy
    }
    
    public static func GetEnemyBulletPos() -> [BulletView] {
        return EnemyView.bullet
    }
    
}



