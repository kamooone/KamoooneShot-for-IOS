//
//  Collision.swift
//  KamoooneShot for IOS
//
//  Created by Kazusa Kondo on 2022/01/22.
//

import Foundation
import UIKit

class Collision {
    private static var isSingleton: Bool = false
    private var collisionJudge: Bool = false
    private var isEnemyLive: [Bool] = []
    
    init(){
        // このクラスのインスタンスは一つのみにする
        if !Collision.isSingleton {
            Init()
            Collision.isSingleton = true
        }
    }
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
    func CollisionJudge(player: PlayerView, enemys: [EnemyView]) {
        for i in 0..<player.bullet.ZIKIMAXBULLET {
            if player.bullet.isBulletTrigger[i] {
                
                // 自機の弾とエネミーとの当たり判定
                for k in 0..<EnemyView.ENEMYMAX {
                    if isEnemyLive[k] {
                        //  ベクトル
                        let posX = player.bullet.body[i].position.x - (enemys[k].body?.position.x ?? 0)
                        let posY = player.bullet.body[i].position.y - (enemys[k].body?.position.y ?? 0)
                        
                        // 三平方定理を使用して距離取得
                        let distance = sqrtf(Float((posX * posX) + (posY * posY)))
                        
                        // 対象となる二つのオブジェクトの半径の和を求める
                        let doubleWidth = Float((player.bullet.body[i].size.width / 3) + (enemys[0].body?.size.width ?? 0 / 3))
                        
                        // 中心座標の2点間の距離より半径の和の方が大きければ接触
                        if distance <= doubleWidth && !GameManager.shared.isSeHit {
                            isEnemyLive[k] = false
                            GameManager.shared.isSeHit = true
                            enemys[k].explotion.isExplosion[k] = true

                            SoundManager.shared.PlaySE()

                            enemys[k].explotion.StartExplosion(x: (enemys[k].body?.position.x)!,y: (enemys[k].body?.position.y)!, cnt: k)
                            player.bullet.body[i].removeFromParent()
                            player.bullet.body[i].position.x = -1000
                            player.bullet.body[i].position.y = -1000
                            enemys[k].body?.removeFromParent()
                            enemys[k].body?.position.x = -1000
                            enemys[k].body?.position.y = -1000
                        }
                    }
                    enemys[k].explotion.Update()
                }
                
                // 自機の弾とエネミーの弾との当たり判定
                for k in 0..<EnemyView.ENEMYMAX {
                    for cnt in 0..<player.bullet.ZIKIMAXBULLET {
                        if enemys[k].bullet.isBulletTrigger[cnt] {
                            //  ベクトル
                            let posX = player.bullet.body[i].position.x - (enemys[k].bullet.body[cnt].position.x )
                            let posY = player.bullet.body[i].position.y - (enemys[k].bullet.body[cnt].position.y )
                            
                            // 三平方定理を使用して距離取得
                            let distance = sqrtf(Float((posX * posX) + (posY * posY)))
                            
                            // 対象となる二つのオブジェクトの半径の和を求める
                            let doubleWidth = Float((player.bullet.body[i].size.width / 3) + (enemys[k].bullet.body[0].size.width / 3))
                            
                            // 中心座標の2点間の距離より半径の和の方が大きければ接触
                            if distance <= doubleWidth && !GameManager.shared.isSeHit {
                                //GameManager.isSeHit = true
                                //GameScene.GetExplosionObject().isExplosion[k] = true
                                
                                SoundManager.shared.PlaySE()
                                
                                //GameScene.GetExplosionObject().StartExplosion(x: enemyPos[k].position.x,y: enemyPos[k].position.y, cnt: k)
                                player.bullet.body[i].removeFromParent()
                                player.bullet.body[i].position.x = -1000
                                player.bullet.body[i].position.y = -1000
                                enemys[k].bullet.body[cnt].removeFromParent()
                                enemys[k].bullet.body[cnt].position.x = -1000
                                enemys[k].bullet.body[cnt].position.y = -1000
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
            for cnt in 0..<enemys[k].bullet.ZIKIMAXBULLET {
                if enemys[k].bullet.isBulletTrigger[cnt] {
                    
                    //  ベクトル
                    let posX = player.body?.position.x ?? 0 - enemys[k].bullet.body[cnt].position.x
                    let posY = player.body?.position.y ?? 0 - enemys[k].bullet.body[cnt].position.y
                    
                    // 三平方定理を使用して距離取得
                    let distance = sqrtf(Float((posX * posX) + (posY * posY)))
                    
                    // 対象となる二つのオブジェクトの半径の和を求める
                    let doubleWidth = Float(((player.body?.size.width)! / 3) + (enemys[k].bullet.body[0].size.width / 3))
                    
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
