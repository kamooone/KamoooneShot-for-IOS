//
//  Collision.swift
//  KamoooneShot for IOS
//
//  Created by Kazusa Kondo on 2022/01/22.
//

import Foundation
import UIKit

class Collision {
    public static var collisionJudge: Bool = false

    
    //=================================================================================
    // 概要   ： 当たり判定入口
    // 仮引数 ： なし
    // 戻り値 ： なし
    //=================================================================================
    static func CollisionJudge() {
        let bulletPos = Bullet.GetBulletPos()
        let enemyPos = Enemy.GetEnemyPos()
        let isBulletTrigger = Bullet.GetBulletTrigger()
        
        for i in 0..<Bullet.ZIKIMAXBULLET {
            if isBulletTrigger[i] {
                for k in 0..<Enemy.ENEMYMAX {
                    //  ベクトル
                    let posX = bulletPos[i].position.x - enemyPos[k].position.x
                    let posY = bulletPos[i].position.y - enemyPos[k].position.y
                    
                    // 三平方定理を使用して距離取得
                    let distance = sqrtf(Float((posX * posX) + (posY * posY)))
                    
                    // 対象となる二つのオブジェクトの半径の和を求める
                    let doubleWidth = Float((bulletPos[0].size.width / 3) + (enemyPos[0].size.width / 3))
                    
                    // 中心座標の2点間の距離より半径の和の方が大きければ接触
                    if distance <= doubleWidth && !GameManager.isSeHit {
                        GameManager.isSeHit = true
                        GameScene.GetExplosionObject().isExplosion[k] = true
                        GameScene.GetSoundObject().PlaySE()
                        GameScene.GetExplosionObject().StartExplosion(x: enemyPos[k].position.x,y: enemyPos[k].position.y, cnt: k)
                        bulletPos[i].removeFromParent()
                        enemyPos[k].removeFromParent()
                        enemyPos[k].position.x = 1000
                        enemyPos[k].position.y = 1000
                    }
                }
            }
            GameManager.isSeHit = false
        }
    }
}
