//
//  PlayerView.swift
//  KamoooneShot for IOS
//
//  Created by Kazusa Kondo on 2022/01/22.
//

import Foundation
import SpriteKit

class PlayerView {
    private static var ziki: SKSpriteNode?
    private static var bullet = BulletView()
    // BulletControllerのメソッドはBulletViewで作成する？
    
    func Init(){
        // 自機の生成
        PlayerView.ziki = SKSpriteNode(imageNamed: "ziki.png")
        PlayerView.ziki!.position = CGPoint(x: (GameManager.shared.scene?.frame.midX)!, y: (GameManager.shared.scene?.frame.minY)!+150)
        GameManager.shared.scene?.addChild(PlayerView.ziki!)
        PlayerView.bullet.Init()
    }
    
    func Move(){
        PlayerView.ziki?.run(SKAction.moveTo(x: GameManager.shared.touchPos!.x, duration: 0.2))
        PlayerView.ziki?.run(SKAction.moveTo(y: GameManager.shared.touchPos!.y, duration: 0.2))
    }
    
    func Update(){
        PlayerView.bullet.Update(x: PlayerView.ziki!.position.x, y: PlayerView.ziki!.position.y)
    }
    
    public static func GetPlayerPos() -> SKSpriteNode {
        return PlayerView.ziki!
    }
    public static func GetBullet() -> [SKSpriteNode] {
        return PlayerView.bullet.zikiBullet
    }
    public static func GetBulletTrigger() -> [Bool] {
        return PlayerView.bullet.isBulletTrigger
    }
}

