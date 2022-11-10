//
//  BaseBulletView.swift
//  KamoooneShot for IOS
//
//  Created by Kazusa Kondo on 2022/10/29.
//

import Foundation
import SpriteKit

class BaseBulletView {
    let ZIKIMAXBULLET: Int = 21
    let BULLET_SPEED: Float = 1.0
    var isBulletTrigger: [Bool] = []
    var body: [SKSpriteNode] = []
    var bulletDuration: Int = 10
    var bulletStartTime: Int = 0
    let VECTOR_Y: Float = 50.0
    let RIGHTVECTOR_X: Float = 10.0
    let LEFTVECTOR_X: Float = 10.0
    var directionX: [Float] = []
    var directionY: [Float] = []
    var nowBulletType: Int = 1
    enum bulletType: Int {
        case normalBullet = 0
        case tripleBullet = 1
    }
        
    init(){}
}
