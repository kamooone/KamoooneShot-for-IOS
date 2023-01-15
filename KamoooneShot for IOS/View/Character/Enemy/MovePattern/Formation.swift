//
//  Formation.swift
//  KamoooneShot for IOS
//
//  Created by Kazusa Kondo on 2023/01/15.
//

import Foundation
import SpriteKit

class Formation {
    // 他のクラスで使用できるようにstaticなインスタンスを生成しておく
    static let shared = Formation()
    
    // インスタンスを一つにするためにinitはptivateにする
    private init() {

    }
    
    func Update(_body: SKNode) {
        _body.position.y -= 0.5
    }
}

