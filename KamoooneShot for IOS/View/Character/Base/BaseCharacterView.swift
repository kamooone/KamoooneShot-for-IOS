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
    var rotate: CGFloat = 0
    var speed: CGFloat = 0
    var velocity: CGFloat = 0.15
    let explotion = ExplosionView(_MAX: GameManager.shared.ENEMYMAX,_width: 50,_height: 50)
    
    init(){}
}
