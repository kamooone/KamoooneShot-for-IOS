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
        // ToDo タッチしたところにスティック移動ではなく、ベクトルでスティックを移動させる。
        //  中心座標
        let initCenterX = INIT_POS_X
        let initCenterY = INIT_POS_Y
        
        let workX = (GameManager.shared.touchPos!.x - initCenterX) * (GameManager.shared.touchPos!.x - initCenterX)
        let workY = (GameManager.shared.touchPos!.y - initCenterY) * (GameManager.shared.touchPos!.y - initCenterY)
        let length: CGFloat = sqrt(workX + workY)
        
        // ToDo 移動範囲を制限させる(原点からの距離を求めて一定の距離までの移動にする) スティックの加減をつける(原点からの距離によって移動スピードを変える)
        let x = abs(initCenterX) + 40
        let y = abs(initCenterY) + 40
        
        if abs((body?.position.x)!) < x {
            body?.run(SKAction.moveTo(x: GameManager.shared.touchPos!.x, duration: 0))
        } else {
            //body?.run(SKAction.moveTo(x: x - 0.002, duration: 0))
        }
        if abs((body?.position.y)!) < y {
            body?.run(SKAction.moveTo(y: GameManager.shared.touchPos!.y, duration: 0))
        } else {
            //body?.run(SKAction.moveTo(y: y - 0.002, duration: 0))
        }
        // ToDo 円形の移動制限幅を超えたら処理を行う
        //中心点から自身までの方向ベクトルを作る
        //作った方向ベクトルを正規化する
        //方向ベクトル分半径に移動させる
        print("INIT_POS_X",INIT_POS_X)
        print("INIT_POS_Y",INIT_POS_Y)
        print("initCenterX",initCenterX)
        print("initCenterY",initCenterY)
        print("x",x)
        print("y",y)
        print("body?.position.x",body?.position.x)
        print("body?.position.y",body?.position.x)
        print("length",length)
        
        
        player.Move(_positionX : (body?.position.x)!, _positionY : (body?.position.y)!)
        
        body?.position.x = GameManager.shared.touchPos!.x
        body?.position.y = GameManager.shared.touchPos!.y
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
        body!.position = CGPoint(x: (GameManager.shared.scene?.frame.midX)! + 0, y: (GameManager.shared.scene?.frame.midY)! + 75)
        body?.run(SKAction.moveTo(x: (body?.position.x)!, duration: 0.2))
        body?.run(SKAction.moveTo(y: (body?.position.y)!, duration: 0.2))
        
        //player.Reset()
    }
}
