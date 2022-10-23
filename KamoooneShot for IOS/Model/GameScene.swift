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
    
    // オブジェクトインスタンス生成
    private var backGround = BackGroundView()
    private var gameUI = GameUIView()
    private var enemys: [EnemyView] = []

    // 画面描画する際の初期化時に呼ばれる
    override func didMove(to view: SKView) {
        // 初期化
        backGround.Init()
        PlayerView.shared.Init()
        
        // エネミーの数分インスタンスを生成する
        for i in 0..<EnemyView.ENEMYMAX {
            enemys.append(EnemyView())
            enemys[i].Init()
        }
        
        gameUI.Init()

        ExplosionView.shared.Init()
        Collision.shared.Init()
    }
    
    //タッチ時に呼ばれる
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        // タップした位置の座標を取得
        let touch = touches.first!;
        GameManager.shared.touchPos = touch.location(in: GameManager.shared.scene!)
        // 移動
        PlayerView.shared.Move()
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
        PlayerView.shared.Move()
    }
    
    // タッチを離した時に呼ばれる
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        // タップした位置に自機を移動
        let touch = touches.first!;
        GameManager.shared.touchPos = touch.location(in: GameManager.shared.scene!)
        PlayerView.shared.Move()
    }
    
    //ノードのアクションの処理後に呼ばれる
    override func didEvaluateActions() {
        // 回転処理
        //_enemy[i].run(rotateAction)
        
        PlayerView.shared.Update()
        
        // エネミーの数分回す
        for i in 0..<EnemyView.ENEMYMAX {
            enemys[i].Update()
        }
        
        Collision.shared.CollisionJudge(enemys: enemys)
        ExplosionView.shared.Update()
    }
 }



