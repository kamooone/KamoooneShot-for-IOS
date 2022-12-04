//
//  GameScene.swift
//  KamoooneShot for IOS
//
//  Created by Kazusa Kondo on 2022/01/16.

import Foundation
import SpriteKit // SpriteKitは画面左下が0,0になる。UiKitは左上が0,0
import AVFoundation

//ゲームシーン
@available(iOS 10.0, *) // IOS10.0以降を要求
class GameScene: SKScene {
    var backGround: BackGroundView!
    var gameUI: GameUIView!
    var stick: StickView!
    var dirrectionButton: [DirectionButtonView] = []

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
        dirrectionButton.append(DirectionButtonView(_x: (GameManager.shared.scene?.frame.maxX)! - 60, _y: (GameManager.shared.scene?.frame.minY)! + 125, _rotate: 0, _name: "RightButton"))
        
        dirrectionButton.append(DirectionButtonView(_x: (GameManager.shared.scene?.frame.maxX)! - 100, _y: (GameManager.shared.scene?.frame.minY)! + 125, _rotate: 180, _name: "LeftButton"))
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
        if touch.location(in: GameManager.shared.scene!).x < 130 && touch.location(in: GameManager.shared.scene!).y < 220 {
            GameManager.shared.touchPos = touch.location(in: GameManager.shared.scene!)
        }
        
        for touch: AnyObject in touches {
            let location = touch.location(in: self)
            let node = self.atPoint(location)
           
            if (node.name == "LeftButton") {
                GameManager.shared.isLeftButtonTouch = true
                GameManager.shared.isRightButtonTouch = false
            } else if (node.name == "RightButton") {
                GameManager.shared.isLeftButtonTouch = false
                GameManager.shared.isRightButtonTouch = true
            } else {
                GameManager.shared.isLeftButtonTouch = false
                GameManager.shared.isRightButtonTouch = false
            }
        }
    }
    
    //スワイプ時に呼ばれる
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        // タップした位置に自機を移動
        let touch = touches.first!;
        if touch.location(in: GameManager.shared.scene!).x < 130 && touch.location(in: GameManager.shared.scene!).y < 220 {
            GameManager.shared.touchPos = touch.location(in: GameManager.shared.scene!)
        }
    }
    
    // タッチを離した時に呼ばれる
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        GameManager.shared.isLeftButtonTouch = false
        GameManager.shared.isRightButtonTouch = false
        // タップした位置に自機を移動
        let touch = touches.first!;
        if touch.location(in: GameManager.shared.scene!).x < 130 && touch.location(in: GameManager.shared.scene!).y < 220 {
            GameManager.shared.isTouch = false
            GameManager.shared.touchPos.x = 0
            GameManager.shared.touchPos.y = 0
            stick.Reset()
        }
    }
    
    //ノードのアクションの処理後に呼ばれる
    override func didEvaluateActions() {
        if GameManager.shared.isGameStart {
            stick.Update()
        }
        if GameManager.shared.isTouch {
            stick.Move()
        }
    }
 }
