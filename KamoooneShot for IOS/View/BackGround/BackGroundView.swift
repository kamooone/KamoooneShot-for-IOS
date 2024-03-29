//
//  BackGround.swift
//  KamoooneShot for IOS
//
//  Created by Kazusa Kondo on 2022/01/23.
//

import Foundation
import SpriteKit

class BackGroundView {
    private static var isSingleton: Bool = false
    
    init(){
        // このクラスのインスタンスは一つのみにする
        if !BackGroundView.isSingleton {
            Init()
            BackGroundView.isSingleton = true
        }
    }
    func Init(){
        //背景画像のノードを作成する。
        let bgNode = SKSpriteNode(imageNamed: "bg")
        //背景画像の位置をシーンの中央にする。
        bgNode.position = CGPoint(x: (GameManager.shared.scene?.frame.midX)!, y: (GameManager.shared.scene?.frame.midY)!)
        GameManager.shared.scene?.addChild(bgNode)
    }
}
