//
//  PlayerView.swift
//  KamoooneShot for IOS
//
//  Created by Kazusa Kondo on 2022/01/22.
//

import Foundation
import SpriteKit

class PlayerView {
    private static var isSingleton: Bool = false
    var ziki: SKSpriteNode?
    let bullet = BulletView()
    
    init(){
        // このクラスのインスタンスを一つしか生成できないようにする
        if !PlayerView.isSingleton {
            Init()
            PlayerView.isSingleton = true
        } else {
            // エラー処理に飛ばす
            print("インスタンス重複エラー")
        }
    }
    
    func Init(){
        // 自機の生成
        ziki = SKSpriteNode(imageNamed: "ziki.png")
        ziki!.position = CGPoint(x: (GameManager.shared.scene?.frame.midX)!, y: (GameManager.shared.scene?.frame.minY)!+150)
        GameManager.shared.scene?.addChild(ziki!)
        bullet.Init()
    }
    
    func Move(){
        ziki?.run(SKAction.moveTo(x: GameManager.shared.touchPos!.x, duration: 0.2))
        ziki?.run(SKAction.moveTo(y: GameManager.shared.touchPos!.y, duration: 0.2))
    }
    
    func Update(){
        bullet.Update(x: ziki!.position.x, y: ziki!.position.y)
    }
}

