//
//  PlayerView.swift
//  KamoooneShot for IOS
//
//  Created by Kazusa Kondo on 2022/01/22.
//

import Foundation
import SpriteKit

class PlayerView: BaseCharacterView {
    private static var isSingleton: Bool = false
    let bullet = BulletView()
    
    override init(){
        super.init()
        // このクラスのインスタンスを一つしか生成できないようにする
        if !PlayerView.isSingleton {
            // 自機の生成
            body = SKSpriteNode(imageNamed: "ziki.png")
            body!.position = CGPoint(x: (GameManager.shared.scene?.frame.midX)!, y: (GameManager.shared.scene?.frame.minY)!+150)
            GameManager.shared.scene?.addChild(body!)
            PlayerView.isSingleton = true
        } else {
            // エラー処理に飛ばす
            print("インスタンス重複エラー")
        }
    }
    
    func Move(){
        body?.run(SKAction.moveTo(x: GameManager.shared.touchPos!.x, duration: 0.2))
        body?.run(SKAction.moveTo(y: GameManager.shared.touchPos!.y, duration: 0.2))
    }
    
    func Update(){
        bullet.Update(x: body!.position.x, y: body!.position.y)
    }
}

