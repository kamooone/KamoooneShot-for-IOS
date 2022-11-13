//
//  GameScene.swift
//  KamoooneShot for IOS
//
//  Created by Kazusa Kondo on 2022/01/16.
// リベーステスト
import Foundation
import SpriteKit // SpriteKitは画面左下が0,0になる。UiKitは左上が0,0
import AVFoundation

//ゲームシーン
@available(iOS 10.0, *) // IOS10.0以降を要求
class GameScene: SKScene {
    var backGround: BackGroundView!
    var gameUI: GameUIView!
    var stick: StickView!

    
    // 画面描画する際の初期化時に呼ばれる
    override func didMove(to view: SKView) {

        // インスタンスを生成
        if backGround == nil {
            backGround = BackGroundView()
        }
        if gameUI == nil {
            gameUI = GameUIView()
        }
        if stick == nil {
            stick = StickView()
        }
    }
    
    //タッチ時に呼ばれる
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        GameManager.shared.isTouch = true
        
        // 初回タップを行うとゲームスタート
        if !GameManager.shared.isGameStart {
            gameUI.Update()
            // BGM再生
            SoundManager.shared.PlayBGM()
            GameManager.shared.isGameStart = true
        }
        
        // タップした位置の座標を取得
        let touch = touches.first!;
        GameManager.shared.touchPos = touch.location(in: GameManager.shared.scene!)
        stick.Move()
        
        for touch in touches {
            _ = touch.location(in: self)
        }
    }
    
    //スワイプ時に呼ばれる
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        // タップした位置に自機を移動
        let touch = touches.first!;
        GameManager.shared.touchPos = touch.location(in: GameManager.shared.scene!)
        
        stick.Move()
    }
    
    // タッチを離した時に呼ばれる
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        GameManager.shared.isTouch = false
        // タップした位置に自機を移動
        let touch = touches.first!;
        GameManager.shared.touchPos = touch.location(in: GameManager.shared.scene!)
    
        // 離したらスティックを元の位置に戻す
        stick.Reset()
    }
    
    //ノードのアクションの処理後に呼ばれる
    override func didEvaluateActions() {
        if GameManager.shared.isGameStart {
            stick.Update()
        }
    }
 }



