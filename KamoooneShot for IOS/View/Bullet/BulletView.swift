//
//  BulletView.swift
//  KamoooneShot for IOS
//
//  Created by Kazusa Kondo on 2022/01/23.
//

import Foundation
import SpriteKit

class BulletView: BaseBulletView {
    private static var isSingleton: Bool = false
    
    override init(){
        super.init()
        // このクラスのインスタンスは一つのみにする
        if !BulletView.isSingleton {
            // 自機弾の生成
            for _ in 0..<ZIKIMAXBULLET {
                isBulletTrigger.append(false)
                body.append(SKSpriteNode(imageNamed: "orange.png"))
            }
            BulletView.isSingleton = true
        } else {
            // エラー処理
            print("エラー処理")
        }
    }
    
    func Update(x: CGFloat, y: CGFloat){
        // 弾発射前処理
        for i in 0..<ZIKIMAXBULLET {
            if !isBulletTrigger[i] && bulletStartTime > bulletDuration {
                isBulletTrigger[i] = true
                // ToDo 画面ごとのサイズ
                body[i].size = CGSize(width: 10, height: 10)
                body[i].position = CGPoint(x: x, y: y)
                GameManager.shared.scene?.addChild(body[i])
                bulletStartTime = 0
                break
            }
        }
        
        // 弾移動処理
        for i in 0..<ZIKIMAXBULLET {
            if isBulletTrigger[i] {
                // 弾発射処理
                body[i].position.y += 3
                body[i].run(SKAction.moveTo(y: body[i].position.y, duration: 0))
                
                if body[i].position.y >= (GameManager.shared.scene?.frame.maxY)! {
                    isBulletTrigger[i] = false
                    body[i].removeFromParent()
                }
            }
        }
        // 弾発射インタバル
        if bulletStartTime <= 10{
            bulletStartTime+=1
        }
    }
}
