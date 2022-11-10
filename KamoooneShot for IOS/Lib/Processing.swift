//
//  Processing.swift
//  KamoooneShot for IOS
//
//  Created by Kazusa Kondo on 2022/01/22.
//

import Foundation
import UIKit
import SpriteKit

class Processing {
    // 他のクラスで使用できるようにstaticなインスタンスを生成しておく
    static let shared = Processing()
    
    private init() {
        
    }
    
//    func OutScreenJudge(_body: SKSpriteNode) -> Bool {
//        if _body.position.y <= (GameManager.shared.scene?.frame.minY)! || _body.position.y >= (GameManager.shared.scene?.frame.maxY)! ||
//            _body.position.x <= (GameManager.shared.scene?.frame.minX)! ||
//            _body.position.x >= (GameManager.shared.scene?.frame.maxX)! {
//            return true
//        }
//        return false
//    }
}
