//
//  directionButtonView.swift
//  KamoooneShot for IOS
//
//  Created by Kazusa Kondo on 2022/11/19.
//

import Foundation
import SpriteKit

class DirectionButtonView {
    
    init(_x: CGFloat, _y: CGFloat, _rotate: CGFloat, _name: String) {
        let button = SKSpriteNode(imageNamed: "directionButton")
        button.position = CGPoint(x: _x, y: _y)
        button.zPosition = 1
        button.name = _name
        button.zRotation = DegreeToRadian(Degree: _rotate)
        GameManager.shared.scene?.addChild(button)
    }
    
    func DegreeToRadian(Degree : CGFloat!)-> CGFloat{
        return CGFloat(Degree) / CGFloat(180.0 * M_1_PI)
    }
}
