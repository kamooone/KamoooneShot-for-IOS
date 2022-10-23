//
//  GameUI.swift
//  KamoooneShot for IOS
//
//  Created by Kazusa Kondo on 2022/01/23.
//

import Foundation
import SpriteKit

class GameUIView {
    private var _tapText: SKLabelNode?
    private var _title: SKSpriteNode?
    private var unHideAction : SKAction!
    private static var isSingleton: Bool = false
    
    init(){
        // このクラスのインスタンスは一つのみにする
        if !GameUIView.isSingleton {
            Init()
            GameUIView.isSingleton = true
        }
    }
    func Init(){
        // Nodeを非表示させるアクションを作る.
        unHideAction = SKAction.hide()
        // テキストのノードを作成する。
        _tapText = SKLabelNode(fontNamed: "American Typewriter Bold")
        _tapText!.text = "タップしてスタート！"
        _tapText!.fontSize = 20
        // 表示位置を画面中央
        _tapText!.position = CGPoint(x: (GameManager.shared.scene?.frame.midX)!, y: (GameManager.shared.scene?.frame.midY)!);
        GameManager.shared.scene?.addChild(_tapText!)
    }
    
    func Update(){
        // タップしてスタートの文字を削除
        _tapText!.run(unHideAction)
    }
}
