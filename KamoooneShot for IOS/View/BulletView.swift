//
//  BulletView.swift
//  KamoooneShot for IOS
//
//  Created by Kazusa Kondo on 2022/01/23.
//

import Foundation
import SpriteKit

class BulletView {
    // 他のクラスで使用できるようにstaticなインスタンスを生成しておく
    static let shared = BulletView()
    
    let ZIKIMAXBULLET: Int = 20
    var isBulletTrigger: [Bool] = []
    var zikiBullet: [SKSpriteNode] = []
    var bulletDuration: Int = 10
    var bulletDurationForEnemy: Int = 50
    var bulletStartTime: Int = 0
    var bulletStartTimeForEnemy: Int = 0
    
    
    func Init(){
        // 自機弾の生成
        for _ in 0..<ZIKIMAXBULLET {
            isBulletTrigger.append(false)
            zikiBullet.append(SKSpriteNode(imageNamed: "orange.png"))
        }
    }
    func Update(x: CGFloat, y: CGFloat){
        // 弾発射前処理
        for i in 0..<ZIKIMAXBULLET {
            if !isBulletTrigger[i] && bulletStartTime > bulletDuration {
                isBulletTrigger[i] = true
                // ToDo 画面ごとのサイズ
                zikiBullet[i].size = CGSize(width: 10, height: 10)
                zikiBullet[i].position = CGPoint(x: x, y: y)
                GameManager.shared.scene?.addChild(zikiBullet[i])
                bulletStartTime = 0
                break
            }
        }
        
        // 弾移動処理
        for i in 0..<ZIKIMAXBULLET {
            if isBulletTrigger[i] {
                // 弾発射処理
                zikiBullet[i].position.y += 3
                zikiBullet[i].run(SKAction.moveTo(y: zikiBullet[i].position.y, duration: 0))
                
                if zikiBullet[i].position.y >= (GameManager.shared.scene?.frame.maxY)! {
                    isBulletTrigger[i] = false
                    zikiBullet[i].removeFromParent()
                }
            }
        }
        // 弾発射インタバル
        if bulletStartTime <= 10{
            bulletStartTime+=1
        }
    }
    
}
