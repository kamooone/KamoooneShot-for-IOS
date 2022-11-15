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
    let INIT_POS_Y: CGFloat = (GameManager.shared.scene?.frame.midY)!
    
    init() {
        // ジョイスティックの生成
        body = SKSpriteNode(imageNamed: "stick.png")
        body!.position = CGPoint(x: (GameManager.shared.scene?.frame.midX)! + 0, y: (GameManager.shared.scene?.frame.midY)! + 75)
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
        // タップした位置とスティックの位置とのベクトルを求める。
        //var vecX = GameManager.shared.touchPos!.x - INIT_POS_X
        //var vecY = GameManager.shared.touchPos!.y - INIT_POS_Y
        
        let workX = (GameManager.shared.touchPos!.x - INIT_POS_X) * (GameManager.shared.touchPos!.x - INIT_POS_X)
        let workY = (GameManager.shared.touchPos!.y - INIT_POS_Y) * (GameManager.shared.touchPos!.y - INIT_POS_Y)
        let length: CGFloat = sqrt(workX + workY)
        print("length",length)
        //let directionX = (vecX / length)
        //let directionY = (vecY / length * -1)
        
        // ToDo 移動範囲を制限させる(原点からの距離を求めて一定の距離までの移動にする) スティックの加減をつける(原点からの距離によって移動スピードを変える)
        //if length < 50 {
            body?.run(SKAction.moveTo(x: GameManager.shared.touchPos!.x, duration: 0))
            body?.run(SKAction.moveTo(y: GameManager.shared.touchPos!.y, duration: 0))
            player.Move(_positionX : (body?.position.x)!, _positionY : (body?.position.y)!)
            body?.position.x = GameManager.shared.touchPos!.x
            body?.position.y = GameManager.shared.touchPos!.y
        //}
    }
    
    func Update(){
        // 回転処理
        //_enemy[i].run(rotateAction)
        
        if GameManager.shared.isTouch {
            //player.Move(_directionX: (body?.position.x)!, _directionY: (body?.position.y)!)
        }
        player.Update()
        
        // エネミーの数分回す
        for i in 0..<EnemyView.ENEMYMAX {
            enemys[i].Update(_playerX: player.body?.position.x ?? 0, _playerY: player.body?.position.y ?? 0)
        }
        
        colision.CollisionJudge(player: player, enemys: enemys)
    }
    
    func Reset(){
        body!.position = CGPoint(x: (GameManager.shared.scene?.frame.midX)! + 0, y: (GameManager.shared.scene?.frame.midY)! + 75)
        body?.run(SKAction.moveTo(x: (body?.position.x)!, duration: 0.2))
        body?.run(SKAction.moveTo(y: (body?.position.y)!, duration: 0.2))
        
        //player.Reset()
    }
}
