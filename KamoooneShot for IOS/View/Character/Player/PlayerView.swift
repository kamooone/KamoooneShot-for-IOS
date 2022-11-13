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
    
    func Move(_positionX: CGFloat, _positionY: CGFloat){
        let length = sqrt((GameManager.shared.touchPos!.x - _positionX) * (GameManager.shared.touchPos!.x - _positionX) + (GameManager.shared.touchPos!.y - _positionY) * (GameManager.shared.touchPos!.y - _positionY))
        body?.position.x += (GameManager.shared.touchPos!.x - _positionX) / length * 41.7
        body?.run(SKAction.moveTo(x: (body?.position.x)!, duration: 0.2))
        body?.position.y += (GameManager.shared.touchPos!.y - _positionY) / length * 41.7
        body?.run(SKAction.moveTo(y: (body?.position.y)!, duration: 0.2))
    }
    
    func Update(){
        bullet.Update(x: body!.position.x, y: body!.position.y)
    }
    
    func Reset() {
        body?.position.x = (GameManager.shared.scene?.frame.midX)!
        body?.position.y = (GameManager.shared.scene?.frame.minY)! + 250
        body?.run(SKAction.moveTo(x: (GameManager.shared.scene?.frame.midX)!, duration: 0.2))
        body?.run(SKAction.moveTo(y: (GameManager.shared.scene?.frame.minY)! + 250, duration: 0.2))
    }
}

