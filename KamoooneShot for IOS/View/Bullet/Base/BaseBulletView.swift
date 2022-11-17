//
//  BaseBulletView.swift
//  KamoooneShot for IOS
//
//  Created by Kazusa Kondo on 2022/10/29.
//

import Foundation
import SpriteKit

class BaseBulletView {
    let ZIKIMAXBULLET: Int = 90
    let BULLET_SPEED: CGFloat = 1.7
    var isBulletTrigger: [Bool] = []
    var bulletDirection: [String] = []
    var body: [SKSpriteNode] = []
    var bulletDuration: Int = 100
    var bulletStartTime: Int = 0
    let VECTOR_Y: CGFloat = 50.0
    let RIGHTVECTOR_X: CGFloat = 10.0
    let LEFTVECTOR_X: CGFloat = 10.0
    var directionX: [CGFloat] = []
    var directionY: [CGFloat] = []
    var nowBulletType: Int = 2
    enum bulletType: Int {
        case normalBullet = 0
        case tripleBullet = 1
        case homingBullet = 2
    }
        
    init(){}
}
