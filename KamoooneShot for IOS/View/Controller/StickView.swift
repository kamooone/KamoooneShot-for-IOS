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
        //  中心座標
        let initCenterX = INIT_POS_X + ((body?.size.width)! / 2)
        let initCenterY = INIT_POS_Y + ((body?.size.height)! / 2)
        
        let workX = (GameManager.shared.touchPos!.x - initCenterX) * (GameManager.shared.touchPos!.x - initCenterX)
        let workY = (GameManager.shared.touchPos!.y - initCenterY) * (GameManager.shared.touchPos!.y - initCenterY)
        let length: CGFloat = sqrt(workX + workY)
        print("length",length)
        
        // ToDo 移動範囲を制限させる(原点からの距離を求めて一定の距離までの移動にする) スティックの加減をつける(原点からの距離によって移動スピードを変える)
        let x = abs(initCenterX) + 100
        let y = abs(initCenterY) + 100
        
        if abs((body?.position.x)!) < x {
            body?.run(SKAction.moveTo(x: GameManager.shared.touchPos!.x, duration: 0))
        } else {
            // 円形の移動制限幅を超えたら処理を行う
            //中心点から自身までの方向ベクトルを作る
            //Vector3 nor=transform.position-centerObj.transform.position;
            //作った方向ベクトルを正規化する
            //nor.Normalize();
            //方向ベクトル分半径に移動させる
            //transform.position = nor * radius;
        }
        if abs((body?.position.y)!) < y {
            body?.run(SKAction.moveTo(y: GameManager.shared.touchPos!.y, duration: 0))
        } else {
            // 円形の移動制限幅を超えたら処理を行う
        }
         
        player.Move(_positionX : (body?.position.x)!, _positionY : (body?.position.y)!)
        
        if abs((body?.position.x)!) < x {
            body?.position.x = GameManager.shared.touchPos!.x
        } else {
            // 円形の移動制限幅を超えたら処理を行う
        }
        if abs((body?.position.y)!) < y {
            body?.position.y = GameManager.shared.touchPos!.y
        } else {
            // 円形の移動制限幅を超えたら処理を行う
        }
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
