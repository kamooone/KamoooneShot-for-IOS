//
//  Bullet.swift
//  KamoooneShot for IOS
//
//  Created by Kazusa Kondo on 2022/01/23.
//

import Foundation
import SpriteKit

class Bullet {
    public static let ZIKIMAXBULLET: Int = 20
    private static var zikiBullet: [SKSpriteNode] = []
    private var bulletDuration: Int = 10
    private var bulletStartTime: Int = 0
    private static var isBulletTrigger: [Bool] = []

    func Init(){
        // 自機弾の生成
        for _ in 0..<Bullet.ZIKIMAXBULLET {
            Bullet.isBulletTrigger.append(false)
            Bullet.zikiBullet.append(SKSpriteNode(imageNamed: "orange.png"))
        }
    }
    func Update(){
        // 弾発射前処理
        for i in 0..<Bullet.ZIKIMAXBULLET {
            if !Bullet.isBulletTrigger[i] && bulletStartTime > bulletDuration {
                Bullet.isBulletTrigger[i] = true
                // ToDo 画面ごとのサイズ
                Bullet.zikiBullet[i].size = CGSize(width: 10, height: 10)
                Bullet.zikiBullet[i].position = CGPoint(x: Player.GetPlayerPosX(), y: Player.GetPlayerPosY())
                GameManager.scene!.addChild(Bullet.zikiBullet[i])
                bulletStartTime = 0
                break
            }
        }
        
        // 弾移動処理
        for i in 0..<Bullet.ZIKIMAXBULLET {
            if Bullet.isBulletTrigger[i] {
                // 弾発射処理
                Bullet.zikiBullet[i].position.y += 3
                Bullet.zikiBullet[i].run(SKAction.moveTo(y: Bullet.zikiBullet[i].position.y, duration: 0))
                
                if Bullet.zikiBullet[i].position.y >= GameManager.scene!.frame.maxY {
                    Bullet.isBulletTrigger[i] = false
                    Bullet.zikiBullet[i].removeFromParent()
                }
                
            }
        }
        // 弾発射インタバル
        if bulletStartTime <= 10{
            bulletStartTime+=1
        }
    }
    
    public static func GetBulletPos() -> [SKSpriteNode] {
        return Bullet.zikiBullet
    }
    
    public static func GetBulletTrigger() -> [Bool] {
        return Bullet.isBulletTrigger
    }
    
}
