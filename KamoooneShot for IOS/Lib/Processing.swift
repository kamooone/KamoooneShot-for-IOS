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
    
    func DegreeToRadian(Degree : CGFloat!)-> CGFloat{
        return CGFloat(Degree) / CGFloat(180.0 * M_1_PI)
    }
}
