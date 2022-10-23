//
//  GameManager.swift
//  KamoooneShot for IOS
//
//  Created by Kazusa Kondo on 2022/01/23.
//

import Foundation
import SpriteKit

class GameManager {
    // 他のクラスで使用できるようにstaticなインスタンスを生成しておく
    static let shared = GameManager()
    
    var touchPos: CGPoint?
    
    // タッチ座標を取得するために使用する
    var scene: SKScene?
    
    let backGroundSize: CGSize = CGSize(width: 360, height: 640)
    var isSeHit: Bool = false

    // インスタンスを一つにするためにinitはptivateにする
    private init() {
        scene = SKScene()
    }
}
