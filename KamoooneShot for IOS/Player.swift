//
//  Player.swift
//  KamoooneShot for IOS
//
//  Created by Kazusa Kondo on 2022/01/22.
//

import Foundation
import SpriteKit

class Player {
    private static var ziki: SKSpriteNode?
    private var bullet = Bullet()
    
    func Init(){
        // 自機の生成
        Player.ziki = SKSpriteNode(imageNamed: "ziki.png")
        Player.ziki!.position = CGPoint(x: GameManager.scene!.frame.midX, y: GameManager.scene!.frame.minY+150)
        GameManager.scene!.addChild(Player.ziki!)
        //let wor = Player.ziki!.size.width / 2
        // 弾の初期化
        bullet.Init()
    }
    
    func Move(){
        Player.ziki?.run(SKAction.moveTo(x: GameManager.touchPos!.x, duration: 0.2))
        Player.ziki?.run(SKAction.moveTo(y: GameManager.touchPos!.y, duration: 0.2))
    }
    
    func Update(){
        bullet.Update()
    }
    
    public static func GetPlayerPosX() -> CGFloat {
        return ziki!.position.x
    }
    public static func GetPlayerPosY() -> CGFloat {
        return ziki!.position.y
    }
}

