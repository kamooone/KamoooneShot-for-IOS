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
    
    var OUT_OF_SCREEN_AREA: CGFloat = -1000
    var isGameStart: Bool = false
    var touchPos: CGPoint = CGPoint(x: 0, y: 0)
    
    // タッチ座標を取得するために使用する
    var scene: SKScene?
    
    // タッチ中かどうかを示す
    var isTouch: Bool = false
    
    var isRightButtonTouch: Bool = false
    var isLeftButtonTouch: Bool = false
    
    let backGroundSize: CGSize = CGSize(width: 360, height: 640)

    // インスタンスを一つにするためにinitはptivateにする
    private init() {
        scene = SKScene()
    }
}
