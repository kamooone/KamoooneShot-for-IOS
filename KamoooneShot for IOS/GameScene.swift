//
//  GameScene.swift
//  KamoooneShot for IOS
//
//  Created by Kazusa Kondo on 2022/01/16.
//
import SpriteKit
import UIKit

//ゲームシーン
@available(iOS 10.0, *) // IOS10.0以降を要求
class GameScene: SKScene {
    
    // オブジェクトインスタンス生成
    private var backGround = BackGround()
    private var player = Player()
    private var enemy = Enemy()
    private var gameUI = GameUI()
    
    // 画面描画する際の初期化時に呼ばれる
    override func didMove(to view: SKView) {
        // 初期化
        backGround.Init()
        player.Init()
        enemy.Init()
        gameUI.Init()
    }
    
    //タッチ時に呼ばれる
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        // タップした位置の座標を取得
        let touch = touches.first!;
        GameManager.touchPos = touch.location(in: GameManager.scene!)
        // 移動
        player.Move()
        gameUI.Update()
    }
    
    //タッチ移動時に呼ばれる
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        // タップした位置に自機を移動
        let touch = touches.first!;
        GameManager.touchPos = touch.location(in: GameManager.scene!)
        // 移動
        player.Move()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        // 移動
        // タップした位置に自機を移動
        let touch = touches.first!;
        GameManager.touchPos = touch.location(in: GameManager.scene!)
        player.Move()
    }
    
    //ノードのアクションの処理後に呼ばれる
    override func didEvaluateActions() {
        // 回転処理
        //_enemy[i].run(rotateAction)
        
        player.Update()
        enemy.Update()

        // 当たり判定処理
        //Collision.CollisionJudge()
    }
}



