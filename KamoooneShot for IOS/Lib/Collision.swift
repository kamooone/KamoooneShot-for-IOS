//
//  Collision.swift
//  KamoooneShot for IOS
//
//  Created by Kazusa Kondo on 2022/01/22.
//

import Foundation
import UIKit

class Collision {
    // 他のクラスで使用できるようにstaticなインスタンスを生成しておく
    static let shared = Collision()
    
    private var collisionJudge: Bool = false
    private var isEnemyLive: [Bool] = []
    
    func Init() {
        for _ in 0..<EnemyView.ENEMYMAX {
            isEnemyLive.append(true)
        }
    }
    
    //=================================================================================
    // 概要   ： 当たり判定入口
    // 仮引数 ： なし
    // 戻り値 ： なし
    //=================================================================================
    func CollisionJudge(enemys: [EnemyView]) {
        for i in 0..<BulletView.shared.ZIKIMAXBULLET {
            if BulletView.shared.isBulletTrigger[i] {
                
                // 自機の弾とエネミーとの当たり判定
                for k in 0..<EnemyView.ENEMYMAX {
                    if isEnemyLive[k] {
                        //  ベクトル
                        let posX = BulletView.shared.zikiBullet[i].position.x - (enemys[k].body?.position.x ?? 0)
                        let posY = BulletView.shared.zikiBullet[i].position.y - (enemys[k].body?.position.y ?? 0)
                        
                        // 三平方定理を使用して距離取得
                        let distance = sqrtf(Float((posX * posX) + (posY * posY)))
                        
                        // 対象となる二つのオブジェクトの半径の和を求める
                        let doubleWidth = Float((BulletView.shared.zikiBullet[i].size.width / 3) + ((enemys[0].body?.size.width ?? 0) / 3))
                        
                        // 中心座標の2点間の距離より半径の和の方が大きければ接触
                        if distance <= doubleWidth && !GameManager.shared.isSeHit {
                            isEnemyLive[k] = false
                            GameManager.shared.isSeHit = true
                            ExplosionView.shared.isExplosion[k] = true

                            SoundManager.shared.PlaySE()

                            ExplosionView.shared.StartExplosion(x: enemys[k].body?.position.x ?? 0,y: enemys[k].body?.position.y ?? 0, cnt: k)
                            BulletView.shared.zikiBullet[i].removeFromParent()
                            enemys[k].body?.removeFromParent()
                            enemys[k].body?.position.x = -1000
                            enemys[k].body?.position.y = -1000
                        }
                    }
                }
                
                // 自機の弾とエネミーの弾との当たり判定
                for k in 0..<EnemyView.ENEMYMAX {
                    for cnt in 0..<BulletView.shared.ZIKIMAXBULLET {
                        if enemys[k].bullet.isBulletTrigger[cnt] {
                            //  ベクトル
                            let posX = BulletView.shared.zikiBullet[i].position.x - (enemys[k].bullet.body[cnt].position.x )
                            let posY = BulletView.shared.zikiBullet[i].position.y - (enemys[k].bullet.body[cnt].position.y )
                            
                            // 三平方定理を使用して距離取得
                            let distance = sqrtf(Float((posX * posX) + (posY * posY)))
                            
                            // 対象となる二つのオブジェクトの半径の和を求める
                            let doubleWidth = Float((BulletView.shared.zikiBullet[i].size.width / 3) + (enemys[k].bullet.body[0].size.width / 3))
                            
                            // 中心座標の2点間の距離より半径の和の方が大きければ接触
                            if distance <= doubleWidth && !GameManager.shared.isSeHit {
                                //GameManager.isSeHit = true
                                //GameScene.GetExplosionObject().isExplosion[k] = true
                                
                                SoundManager.shared.PlaySE()
                                
                                //GameScene.GetExplosionObject().StartExplosion(x: enemyPos[k].position.x,y: enemyPos[k].position.y, cnt: k)
                                enemys[k].bullet.body[cnt].removeFromParent()
                                BulletView.shared.zikiBullet[i].removeFromParent()
                                enemys[k].bullet.isBulletTrigger[cnt] = false
                                
                            }
                        }
                    }
                }
            }
            GameManager.shared.isSeHit = false
        }
        
        // 自機と敵の弾との当たり判定
        for k in 0..<EnemyView.ENEMYMAX {
            for cnt in 0..<BulletView.shared.ZIKIMAXBULLET {
                if enemys[k].bullet.isBulletTrigger[cnt] {
                    
                    //  ベクトル
                    let posX = PlayerView.shared.ziki?.position.x ?? 0 - enemys[k].bullet.body[cnt].position.x
                    let posY = PlayerView.shared.ziki?.position.y ?? 0 - enemys[k].bullet.body[cnt].position.y
                    
                    // 三平方定理を使用して距離取得
                    let distance = sqrtf(Float((posX * posX) + (posY * posY)))
                    
                    // 対象となる二つのオブジェクトの半径の和を求める
                    let doubleWidth = Float(((PlayerView.shared.ziki?.size.width ?? 0) / 3) + (enemys[k].bullet.body[0].size.width / 3))
                    
                    // 中心座標の2点間の距離より半径の和の方が大きければ接触
                    if distance <= doubleWidth && !GameManager.shared.isSeHit {
                        //GameManager.isSeHit = true
                        //GameScene.GetExplosionObject().isExplosion[k] = true
                        
                        SoundManager.shared.PlaySE()
                        
                        //GameScene.GetExplosionObject().StartExplosion(x: enemyPos[k].position.x,y: enemyPos[k].position.y, cnt: k)
                        enemys[k].bullet.body[cnt].removeFromParent()
                        //ziki.removeFromParent()
                        enemys[k].bullet.isBulletTrigger[cnt] = false
                    }
                }
            }
        }
        
    }
}
