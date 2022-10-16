//
//  File.swift
//  KamoooneShot for IOS
//
//  Created by Kazusa Kondo on 2022/01/16.
//

import Foundation
import SpriteKit

class TitleScene: SKScene{
    // 画面を描画する際の初期化時に呼ばれる
    override func didMove(to view: SKView) {
        //背景画像のノードを作成する。
        let bgNode = SKSpriteNode(imageNamed: "bg")
        //背景画像のサイズをシーンと同じにする。
        bgNode.size = self.frame.size
        //背景画像の位置をシーンの中央にする。
        bgNode.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        // 背景画像ノードを追加
        self.addChild(bgNode)
        
        // テキストのノードを作成する。
        let label = SKLabelNode(fontNamed: "American Typewriter Bold")
        // 表示するテキストを入力
        label.text = "KamoooneShot"
        // 表示するテキストの位置(画面中央)
        label.position = CGPoint(x: self.frame.midX, y: self.frame.midY);
        // テキストノードを追加
        self.addChild(label)
    }
    
    // 画面をタッチされた時に呼ばれる
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        if let _ = touches.first as UITouch? {
            //タッチを検出したときにStepSceneを呼び出す
            GameManager.shared.scene = GameScene(size: self.scene!.size)
            GameManager.shared.scene?.scaleMode = SKSceneScaleMode.aspectFill
            self.view!.presentScene(GameManager.shared.scene)
        }
    }
}
