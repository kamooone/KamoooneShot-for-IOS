//
//  BaseCharacter.swift
//  KamoooneShot for IOS
//
//  Created by Kazusa Kondo on 2022/10/29.
//

import Foundation
import SpriteKit

class BaseCharacterView {
    var body: SKSpriteNode?
    var rotateAction: SKAction?
    var rotate: Double = 0
    var speed: Double = 0
    var velocity: Double = 0.15
    let explotion = ExplosionView()
    
    init(){}
}
