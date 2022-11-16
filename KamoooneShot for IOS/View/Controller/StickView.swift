//
//  StickView.swift
//  KamoooneShot for IOS
//
//  Created by Kazusa Kondo on 2022/11/13.
//

import Foundation
import SpriteKit

class StickView {
    var body: SKSpriteNode?
    var player: PlayerView!
    var enemys: [EnemyView] = []
    var colision: Collision!
    let INIT_POS_X: CGFloat = (GameManager.shared.scene?.frame.midX)!
    let INIT_POS_Y: CGFloat = (GameManager.shared.scene?.frame.midY)! + 75
    
    init() {
        // ジョイスティックの生成
        body = SKSpriteNode(imageNamed: "stick.png")
        body!.position = CGPoint(x: INIT_POS_X, y: INIT_POS_Y)
        GameManager.shared.scene?.addChild(body!)
        
        if player == nil {
            player = PlayerView()
        }
        
        // エネミーの数分インスタンスを生成する
        for _ in 0..<EnemyView.ENEMYMAX {
            enemys.append(EnemyView())
        }
        
        if colision == nil {
            colision = Collision()
        }
    }
    
    func Move(){
        //  スティックの中心座標
        let initCenterX = body?.position.x
        let initCenterY = body?.position.y
        
        // 移動ベクトル
        let vecX = GameManager.shared.touchPos!.x - initCenterX!
        let vecY = GameManager.shared.touchPos!.y - initCenterY!
        
        // スティックの中心座標とタッチした場所の中心座標の距離
        let workX = (GameManager.shared.touchPos!.x - initCenterX!) * (GameManager.shared.touchPos!.x - initCenterX!)
        let workY = (GameManager.shared.touchPos!.y - initCenterY!) * (GameManager.shared.touchPos!.y - initCenterY!)
        let length: CGFloat = sqrt(workX + workY)

        let directionX = vecX / length
        let directionY = vecY / length
        
        body!.position.x += directionX * 1.01
        body!.run(SKAction.moveTo(x: body!.position.x, duration: 0))
        body!.position.y += directionY * 1.01
        body!.run(SKAction.moveTo(y: body!.position.y, duration: 0))
        
        //player.Move(_positionX : (body?.position.x)!, _positionY : (body?.position.y)!)
    }
    
    func Update(){
        // 回転処理
        //_enemy[i].run(rotateAction)
        
        if GameManager.shared.isTouch {
            //player.Move(_directionX: (body?.position.x)!, _directionY: (body?.position.y)!)
        }
        //player.Update()
        
        // エネミーの数分回す
        for i in 0..<EnemyView.ENEMYMAX {
            enemys[i].Update(_playerX: player.body?.position.x ?? 0, _playerY: player.body?.position.y ?? 0)
        }
        
        colision.CollisionJudge(player: player, enemys: enemys)
    }
    
    func Reset(){
        body!.position = CGPoint(x: INIT_POS_X, y: INIT_POS_Y)
        body?.run(SKAction.moveTo(x: (body?.position.x)!, duration: 0.2))
        body?.run(SKAction.moveTo(y: (body?.position.y)!, duration: 0.2))
        
        //player.Reset()
    }
}
