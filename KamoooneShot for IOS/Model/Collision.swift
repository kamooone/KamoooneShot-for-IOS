//
//  Collision.swift
//  KamoooneShot for IOS
//
//  Created by Kazusa Kondo on 2022/01/22.
//

import Foundation
import UIKit

class Collision {
    private static var collisionJudge: Bool = false
    private static var isEnemyLive: [Bool] = []
    
    static func Init() {
        for _ in 0..<EnemyView.ENEMYMAX {
            isEnemyLive.append(true)
        }
    }
    
    //=================================================================================
    // 概要   ： 当たり判定入口
    // 仮引数 ： なし
    // 戻り値 ： なし
    //=================================================================================
    static func CollisionJudge() {

        let ziki = PlayerView.GetPlayerPos()
        let bullet = PlayerView.GetBullet()
        let bulletTrigger = PlayerView.GetBulletTrigger()
        let enemyPos = EnemyView.GetEnemyPos()
        let enemyBulletPos = EnemyView.GetEnemyBulletPos()
        
        for i in 0..<BulletView.ZIKIMAXBULLET {
            if bulletTrigger[i] {
                
                // 自機の弾とエネミーとの当たり判定
                for k in 0..<EnemyView.ENEMYMAX {
                    if isEnemyLive[k] {
                        //  ベクトル
                        let posX = bullet[i].position.x - enemyPos[k].position.x
                        let posY = bullet[i].position.y - enemyPos[k].position.y
                        
                        // 三平方定理を使用して距離取得
                        let distance = sqrtf(Float((posX * posX) + (posY * posY)))
                        
                        // 対象となる二つのオブジェクトの半径の和を求める
                        let doubleWidth = Float((bullet[i].size.width / 3) + (enemyPos[0].size.width / 3))
                        
                        // 中心座標の2点間の距離より半径の和の方が大きければ接触
                        if distance <= doubleWidth && !GameManager.isSeHit {
                            isEnemyLive[k] = false
                            GameManager.isSeHit = true
                            GameScene.GetExplosionObject().isExplosion[k] = true
                            GameScene.GetSoundObject().PlaySE()
                            GameScene.GetExplosionObject().StartExplosion(x: enemyPos[k].position.x,y: enemyPos[k].position.y, cnt: k)
                            bullet[i].removeFromParent()
                            enemyPos[k].removeFromParent()
                            enemyPos[k].position.x = -1000
                            enemyPos[k].position.y = -1000
                        }
                    }
                }
                
                // 自機の弾とエネミーの弾との当たり判定
                for k in 0..<EnemyView.ENEMYMAX {
                    for cnt in 0..<BulletView.ZIKIMAXBULLET {
                        if enemyBulletPos[k].isBulletTrigger[cnt] {
                            //  ベクトル
                            let posX = bullet[i].position.x - enemyBulletPos[k].enemyBullet[cnt].position.x
                            let posY = bullet[i].position.y - enemyBulletPos[k].enemyBullet[cnt].position.y
                            
                            // 三平方定理を使用して距離取得
                            let distance = sqrtf(Float((posX * posX) + (posY * posY)))
                            
                            // 対象となる二つのオブジェクトの半径の和を求める
                            let doubleWidth = Float((bullet[i].size.width / 3) + (enemyBulletPos[0].enemyBullet[0].size.width / 3))
                            
                            // 中心座標の2点間の距離より半径の和の方が大きければ接触
                            if distance <= doubleWidth && !GameManager.isSeHit {
                                //GameManager.isSeHit = true
                                //GameScene.GetExplosionObject().isExplosion[k] = true
                                GameScene.GetSoundObject().PlaySE()
                                //GameScene.GetExplosionObject().StartExplosion(x: enemyPos[k].position.x,y: enemyPos[k].position.y, cnt: k)
                                enemyBulletPos[k].enemyBullet[cnt].removeFromParent()
                                bullet[i].removeFromParent()
                                enemyBulletPos[k].isBulletTrigger[cnt] = false
                                
                            }
                        }
                    }
                }
            }
            GameManager.isSeHit = false
        }
        
        // 自機と敵の弾との当たり判定
        for k in 0..<EnemyView.ENEMYMAX {
            for cnt in 0..<BulletView.ZIKIMAXBULLET {
                if enemyBulletPos[k].isBulletTrigger[cnt] {
                    
                    //  ベクトル
                    let posX = ziki.position.x - enemyBulletPos[k].enemyBullet[cnt].position.x
                    let posY = ziki.position.y - enemyBulletPos[k].enemyBullet[cnt].position.y
                    
                    // 三平方定理を使用して距離取得
                    let distance = sqrtf(Float((posX * posX) + (posY * posY)))
                    
                    // 対象となる二つのオブジェクトの半径の和を求める
                    let doubleWidth = Float((ziki.size.width / 3) + (enemyBulletPos[0].enemyBullet[0].size.width / 3))
                    
                    // 中心座標の2点間の距離より半径の和の方が大きければ接触
                    if distance <= doubleWidth && !GameManager.isSeHit {
                        //GameManager.isSeHit = true
                        //GameScene.GetExplosionObject().isExplosion[k] = true
                        GameScene.GetSoundObject().PlaySE()
                        //GameScene.GetExplosionObject().StartExplosion(x: enemyPos[k].position.x,y: enemyPos[k].position.y, cnt: k)
                        enemyBulletPos[k].enemyBullet[cnt].removeFromParent()
                        //ziki.removeFromParent()
                        enemyBulletPos[k].isBulletTrigger[cnt] = false
                    }
                }
            }
        }
        
    }
}
