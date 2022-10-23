//
//  PlayerView.swift
//  KamoooneShot for IOS
//
//  Created by Kazusa Kondo on 2022/01/22.
//

import Foundation
import SpriteKit

class PlayerView {
    // 他のクラスで使用できるようにstaticなインスタンスを生成しておく
    static let shared = PlayerView()
    var ziki: SKSpriteNode?
    
    
    func Init(){
        // 自機の生成
        ziki = SKSpriteNode(imageNamed: "ziki.png")
        ziki!.position = CGPoint(x: (GameManager.shared.scene?.frame.midX)!, y: (GameManager.shared.scene?.frame.minY)!+150)
        GameManager.shared.scene?.addChild(ziki!)
        BulletView.shared.Init()
    }
    
    func Move(){
        ziki?.run(SKAction.moveTo(x: GameManager.shared.touchPos!.x, duration: 0.2))
        ziki?.run(SKAction.moveTo(y: GameManager.shared.touchPos!.y, duration: 0.2))
    }
    
    func Update(){
        BulletView.shared.Update(x: ziki!.position.x, y: ziki!.position.y)
    }
}

