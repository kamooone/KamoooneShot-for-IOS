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
    var isBulletTrigger: [Bool] = []
    var body: [SKSpriteNode] = []
    var bulletDuration: Int = 10
    var bulletDurationForEnemy: Int = 50
    var bulletStartTime: Int = 0
    var bulletStartTimeForEnemy: Int = 0
        
    init(){}
}
