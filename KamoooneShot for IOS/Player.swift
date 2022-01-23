//
//  Player.swift
//  KamoooneShot for IOS
//
//  Created by Kazusa Kondo on 2022/01/22.
//

import Foundation
import SpriteKit

class Player {
    private var _ziki: SKSpriteNode?
    private var _zikiBullet: [SKSpriteNode] = []
    private final var ZIKIMAXBULLET: Int = 20
    private var bulletDuration: Int = 10
    private var bulletStartTime: Int = 0
    private var isBulletTrigger: [Bool] = []
    private var screenSize: CGSize?
    private var scale_x: CGFloat?
    private var scale_y: CGFloat?
    
    func Init(){
        //自機の生成
        _ziki = SKSpriteNode(imageNamed: "ziki.png")
        _ziki!.position = CGPoint(x: GameManager.scene!.frame.midX, y: GameManager.scene!.frame.minY+150)
        GameManager.scene!.addChild(_ziki!)
        
        // 自機弾の生成
        for _ in 0..<ZIKIMAXBULLET {
            isBulletTrigger.append(false)
            _zikiBullet.append(SKSpriteNode(imageNamed: "orange.png"))
        }
    }
    
    func Move(){
        _ziki?.run(SKAction.moveTo(x: GameManager.touchPos!.x, duration: 0.2))
        _ziki?.run(SKAction.moveTo(y: GameManager.touchPos!.y, duration: 0.2))
    }
    
    func Update(){
        // 弾発射前処理
        for i in 0..<ZIKIMAXBULLET {
            if !isBulletTrigger[i] && bulletStartTime > bulletDuration {
                isBulletTrigger[i] = true
                // ToDo 画面ごとのサイズ
                _zikiBullet[i].size = CGSize(width: 10, height: 10)
                _zikiBullet[i].position = CGPoint(x: _ziki!.position.x, y: _ziki!.position.y)
                GameManager.scene!.addChild(_zikiBullet[i])
                bulletStartTime = 0
                break
            }
        }
        
        // 弾移動処理
        for i in 0..<ZIKIMAXBULLET {
            if isBulletTrigger[i] {
                // 弾発射処理
                _zikiBullet[i].position.y += 3
                _zikiBullet[i].run(SKAction.moveTo(y: _zikiBullet[i].position.y, duration: 0))
                
                if _zikiBullet[i].position.y >= GameManager.scene!.frame.maxY {
                    isBulletTrigger[i] = false
                    _zikiBullet[i].removeFromParent()
                }
                
            }
        }
        // 弾発射インタバル
        if bulletStartTime <= 10{
            bulletStartTime+=1
        }
    }
}

