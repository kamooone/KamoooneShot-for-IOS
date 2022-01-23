//
//  BackGround.swift
//  KamoooneShot for IOS
//
//  Created by Kazusa Kondo on 2022/01/23.
//

import Foundation
import SpriteKit

class BackGround {
    func Init(){
        //背景画像のノードを作成する。
        let bgNode = SKSpriteNode(imageNamed: "bg")
        //背景画像の位置をシーンの中央にする。
        bgNode.position = CGPoint(x: GameManager.scene!.frame.midX, y: GameManager.scene!.frame.midY)
        GameManager.scene!.addChild(bgNode)
    }
}
