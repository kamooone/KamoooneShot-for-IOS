//
//  GameScene.swift
//  KamoooneShot for IOS
//
//  Created by Kazusa Kondo on 2022/01/16.
//
import Foundation
import SpriteKit
import AVFoundation

//ゲームシーン
@available(iOS 10.0, *) // IOS10.0以降を要求
class GameScene: SKScene {
    
    // オブジェクトインスタンス生成(ToDo インスタンスを一つのみに限定しなければいけないやつかつ、staticを使用する必要のないものはシングルトンを使用する)
    private var backGround: BackGroundView!
    private var gameUI: GameUIView!
    private var player: PlayerView!
    private var colision: Collision!
    

    // 表示するエネミーの数分のインスタンスを生成する
    private var enemys: [EnemyView] = []
    
    // 画面描画する際の初期化時に呼ばれる
    override func didMove(to view: SKView) {

        // インスタンスを生成
        if backGround == nil {
            backGround = BackGroundView()
        }
        if gameUI == nil {
            gameUI = GameUIView()
        }
        if player == nil {
            player = PlayerView()
        }
        if colision == nil {
            colision = Collision()
        }
        // エネミーの数分インスタンスを生成する
        for _ in 0..<EnemyView.ENEMYMAX {
            enemys.append(EnemyView())
        }
    }
    
    //タッチ時に呼ばれる
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        // タップした位置の座標を取得
        let touch = touches.first!;
        GameManager.shared.touchPos = touch.location(in: GameManager.shared.scene!)
        // 移動
        player.Move()
        gameUI.Update()
        
        for touch in touches {
            _ = touch.location(in: self)
        }
    }
    
    //タッチ移動時に呼ばれる
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        // タップした位置に自機を移動
        let touch = touches.first!;
        GameManager.shared.touchPos = touch.location(in: GameManager.shared.scene!)
        player.Move()
    }
    
    // タッチを離した時に呼ばれる
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        // タップした位置に自機を移動
        let touch = touches.first!;
        GameManager.shared.touchPos = touch.location(in: GameManager.shared.scene!)
        player.Move()
    }
    
    //ノードのアクションの処理後に呼ばれる
    override func didEvaluateActions() {
        // 回転処理
        //_enemy[i].run(rotateAction)
        
        player.Update()
        
        // エネミーの数分回す
        for i in 0..<EnemyView.ENEMYMAX {
            enemys[i].Update()
        }
        
        colision.CollisionJudge(player: player, enemys: enemys)
        ExplosionView.shared.Update()
    }
 }



