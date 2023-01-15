//
//  GameUI.swift
//  KamoooneShot for IOS
//
//  Created by Kazusa Kondo on 2022/01/23.
//

import Foundation
import SpriteKit

class GameUIView {
    private static var isSingleton: Bool = false
    private var tapText: SKLabelNode?
    private var title: SKSpriteNode?
    private var scoreText: SKLabelNode?
    private var unHideAction : SKAction!
    
    init(){
        // このクラスのインスタンスは一つのみにする
        if !GameUIView.isSingleton {
            // Nodeを非表示させるアクションを作る.
            unHideAction = SKAction.hide()
            // テキストのノードを作成する。
            tapText = SKLabelNode(fontNamed: "American Typewriter Bold")
            tapText!.text = "タップしてスタート！"
            tapText!.fontSize = 20
            // 表示位置を画面中央
            tapText!.position = CGPoint(x: (GameManager.shared.scene?.frame.midX)!, y: (GameManager.shared.scene?.frame.midY)!);
            GameManager.shared.scene?.addChild(tapText!)
            
            // テキストのノードを作成する。
            scoreText = SKLabelNode(fontNamed: "American Typewriter Bold")
            scoreText!.text = "Score : 0"
            scoreText!.fontSize = 16
            // 表示位置を画面中央
            scoreText!.position = CGPoint(x: (GameManager.shared.scene?.frame.minX)! + 60, y: (GameManager.shared.scene?.frame.maxY)! - 120);
            GameManager.shared.scene?.addChild(scoreText!)
            
            GameUIView.isSingleton = true
        }
    }
    
    func Update(){
        // タップしてスタートの文字を削除
        tapText!.run(unHideAction)
        
        // ToDo スコアアップ時の処理が入った場合、if文で上がった点数まで加算するまで+1を繰り返す
        if GameManager.shared.nowScore != GameManager.shared.addScore {
            GameManager.shared.nowScore += 2
        }
        
        scoreText!.text = "Score : " + String(GameManager.shared.nowScore)
    }
}
