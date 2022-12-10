//
//  StickView.swift
//  KamoooneShot for IOS
//
//  Created by Kazusa Kondo on 2022/11/13.
//

import Foundation
import SpriteKit

class StickView {
    var bodyBG: SKSpriteNode?
    var body: SKSpriteNode?
    var player: PlayerView!
    var enemys: [EnemyView] = []
    var colision: Collision!
    let STICK_INIT_POS_X: Double = (GameManager.shared.scene?.frame.minX)! + 75
    let STICK_INIT_POS_Y: Double = (GameManager.shared.scene?.frame.minY)! + 125
    let STICK_SPEED: CGFloat = 20.0
    let STICK_MOVE_RANGE: Double = 20
    
    init() {
        // ジョイスティックの生成
        bodyBG = SKSpriteNode(imageNamed: "stickBG.png")
        bodyBG!.position = CGPoint(x: STICK_INIT_POS_X, y: STICK_INIT_POS_Y)
        GameManager.shared.scene?.addChild(bodyBG!)
        body = SKSpriteNode(imageNamed: "stick.png")
        body!.position = CGPoint(x: STICK_INIT_POS_X, y: STICK_INIT_POS_Y)
        GameManager.shared.scene?.addChild(body!)
        
        // プレイヤーのインスタンスを生成
        if player == nil {
            player = PlayerView()
        }
        
        // エネミーの数分インスタンスを生成する
        for _ in 0..<EnemyView.ENEMYMAX {
            enemys.append(EnemyView())
        }
        
        // 当たり判定処理クラスのインスタンスを生成
        if colision == nil {
            colision = Collision()
        }
    }
    
    func Move(){
        //  スティックの中心座標
        let initCenterX: Double = (Double((body?.position.x)!))
        let initCenterY: Double = (Double((body?.position.y)!))
        
        // 移動ベクトル
        let vecX: Double = GameManager.shared.touchPos.x - initCenterX
        let vecY: Double = GameManager.shared.touchPos.y - initCenterY
        
        // 求めるのはタッチした場所までの距離ではなく、スティック初期位置からスティック移動した位置までの距離
        let workTouchX: Double = (GameManager.shared.touchPos.x - STICK_SPEED) * (GameManager.shared.touchPos.x - STICK_SPEED)
        let workTouchY: Double = (GameManager.shared.touchPos.y - STICK_SPEED) * (GameManager.shared.touchPos.y - STICK_SPEED)
        let touchLength: Double = sqrt(workTouchX + workTouchY)
        
        // スティック移動ベクトル
        let directionX: Double = vecX / touchLength
        let directionY: Double = vecY / touchLength

        // スティック移動処理
        body!.position.x += directionX * STICK_SPEED
        body!.position.y += directionY * STICK_SPEED
        
        // スティック初期位置からスティック移動した位置までの距離を求める
        let workBodyX: Double = ((body?.position.x)! - STICK_INIT_POS_X) * ((body?.position.x)! - STICK_INIT_POS_X)
        let workBodyY: Double = ((body?.position.y)! - STICK_INIT_POS_Y) * ((body?.position.y)! - STICK_INIT_POS_Y)
        var stickLength: Double = sqrt(Double(workBodyX + workBodyY))
        stickLength = round(stickLength * 100) / 100 // 小数点第二位以下を切り捨てる
        
        // スティック移動距離が一定の距離を超えないようにする
        if stickLength > STICK_MOVE_RANGE {
            stickLength = STICK_MOVE_RANGE
            body!.position.x -= directionX * STICK_SPEED
            body!.position.y -= directionY * STICK_SPEED
        }
        
        body!.run(SKAction.moveTo(x: body!.position.x, duration: 0))
        body!.run(SKAction.moveTo(y: body!.position.y, duration: 0))
        
        player.Move(_positionX: (body?.position.x)!, _positionY: (body?.position.y)!, _stickLength: stickLength)
    }
    
    func Update(){
        player.Update()
        
        for i in 0..<EnemyView.ENEMYMAX {
            enemys[i].Update(_playerX: player.body?.position.x ?? 0, _playerY: player.body?.position.y ?? 0)
        }
        
        colision.CollisionJudge(player: player, enemys: enemys)
    }
    
    func Reset(){
        body!.position = CGPoint(x: STICK_INIT_POS_X, y: STICK_INIT_POS_Y)
        body?.run(SKAction.moveTo(x: (body?.position.x)!, duration: 0))
        body?.run(SKAction.moveTo(y: (body?.position.y)!, duration: 0))
    }
}
