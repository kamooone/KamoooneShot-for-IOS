//
//  EnemyBulettView.swift
//  KamoooneShot for IOS
//
//  Created by Kazusa Kondo on 2022/10/23.
//

import Foundation
import SpriteKit

class EnemyBulletView {
    let ZIKIMAXBULLET: Int = 20
    var isBulletTrigger: [Bool] = []
    var body: [SKSpriteNode] = []
    var bulletDurationForEnemy: Int = 50
    var bulletStartTime: Int = 0
    var bulletStartTimeForEnemy: [Int] = []
    
    init() {
        Init()
    }
    func Init(){
        // 自機弾の生成
        for _ in 0..<EnemyView.ENEMYMAX {
            for _ in 0..<ZIKIMAXBULLET {
                isBulletTrigger.append(false)
                body.append(SKSpriteNode(imageNamed: "pink.png"))
                bulletStartTimeForEnemy.append(0)
            }
        }
    }
    
    func Update(x: CGFloat, y: CGFloat){
        // 弾発射前処理
        for i in 0..<ZIKIMAXBULLET {
            if !isBulletTrigger[i] && bulletStartTimeForEnemy[i] > bulletDurationForEnemy {
                isBulletTrigger[i] = true
                // ToDo 画面ごとのサイズ
                body[i].size = CGSize(width: 10, height: 10)
                body[i].position = CGPoint(x: x, y: y)
                GameManager.shared.scene?.addChild(body[i])
                bulletStartTimeForEnemy[i] = 0
            }
        }
        
        // 弾移動処理
        for i in 0..<ZIKIMAXBULLET {
            if isBulletTrigger[i] {
                // 弾発射処理
                body[i].position.y -= 2
                body[i].run(SKAction.moveTo(y: body[i].position.y, duration: 0))
                
                if body[i].position.y <= (GameManager.shared.scene?.frame.minY)! {
                    isBulletTrigger[i] = false
                    body[i].removeFromParent()
                }
                break
            }
            // 弾発射インタバル
            else if bulletStartTimeForEnemy[i] <= bulletDurationForEnemy{
                bulletStartTimeForEnemy[i] += 1
            }
        }
    }
}
