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
            for _ in 0..<EnemyView.ENEMYMAX {
                isEnemyLive.append(true)
            }
            Collision.isSingleton = true
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
                        //  中心座標
                        let playerX = player.bullet.body[i].position.x + (player.bullet.body[i].size.width / 2)
                        let playerY = player.bullet.body[i].position.y + (player.bullet.body[i].size.height / 2)
                        let enemyX = (enemys[k].body?.position.x)! + ((enemys[k].body?.size.width)! / 2)
                        let enemyY = (enemys[k].body?.position.y)! + ((enemys[k].body?.size.height)! / 2)
                        
                        // 三平方定理を使用して距離取得
                        let workX = ((playerX - enemyX) * (playerX - enemyX))
                        let workY = ((playerY - enemyY) * (playerY - enemyY))
                        let distance = sqrt(workX + workY)
                        
                        // 対象となる二つのオブジェクトの半径の和を求める
                        let doubleWidth = (player.bullet.body[i].size.width / 2) + (enemys[0].body?.size.width ?? 0 / 2)
                        
                        // 中心座標の2点間の距離より半径の和の方が大きければ接触
                        if distance <= doubleWidth && !GameManager.shared.isSeHit {
                            isEnemyLive[k] = false
                            GameManager.shared.isSeHit = true
                            enemys[k].explotion.isExplosion[k] = true

                            SoundManager.shared.PlaySE()

                            enemys[k].explotion.StartExplosion(x: (enemys[k].body?.position.x)!,y: (enemys[k].body?.position.y)!, cnt: k)
                            player.bullet.body[i].removeFromParent()
                            player.bullet.body[i].position.x = GameManager.shared.OUT_OF_SCREEN_AREA
                            player.bullet.body[i].position.y = GameManager.shared.OUT_OF_SCREEN_AREA
                            enemys[k].body?.removeFromParent()
                            enemys[k].body?.position.x = GameManager.shared.OUT_OF_SCREEN_AREA
                            enemys[k].body?.position.y = GameManager.shared.OUT_OF_SCREEN_AREA
                        }
                    }
                    enemys[k].explotion.Update()
                }
                
                // 自機の弾とエネミーの弾との当たり判定
                for k in 0..<EnemyView.ENEMYMAX {
                    for cnt in 0..<player.bullet.ZIKIMAXBULLET {
                        if enemys[k].bullet.isBulletTrigger[cnt] {
                            //  中心座標
                            let playerX = player.bullet.body[i].position.x + (player.bullet.body[i].size.width / 2)
                            let playerY = player.bullet.body[i].position.y + (player.bullet.body[i].size.height / 2)
                            let enemyX = enemys[k].bullet.body[cnt].position.x + (enemys[k].bullet.body[cnt].size.width / 2)
                            let enemyY = enemys[k].bullet.body[cnt].position.y + (enemys[k].bullet.body[cnt].size.height / 2)
                            
                            // 三平方定理を使用して距離取得
                            let workX = ((playerX - enemyX) * (playerX - enemyX))
                            let workY = ((playerY - enemyY) * (playerY - enemyY))
                            let distance = sqrt(workX + workY)
                                                        
                            // 対象となる二つのオブジェクトの半径の和を求める
                            let doubleWidth = (player.bullet.body[i].size.width / 2) + (enemys[k].bullet.body[cnt].size.width / 2)
                            
                            // 中心座標の2点間の距離より半径の和の方が大きければ接触
                            if distance <= doubleWidth && !GameManager.shared.isSeHit {
                                //GameManager.isSeHit = true
                                //GameScene.GetExplosionObject().isExplosion[k] = true
                                
                                SoundManager.shared.PlaySE()
                                
                                //GameScene.GetExplosionObject().StartExplosion(x: enemyPos[k].position.x,y: enemyPos[k].position.y, cnt: k)
                                player.bullet.body[i].removeFromParent()
                                player.bullet.body[i].position.x = GameManager.shared.OUT_OF_SCREEN_AREA
                                player.bullet.body[i].position.y = GameManager.shared.OUT_OF_SCREEN_AREA
                                enemys[k].bullet.body[cnt].removeFromParent()
                                enemys[k].bullet.body[cnt].position.x = GameManager.shared.OUT_OF_SCREEN_AREA
                                enemys[k].bullet.body[cnt].position.y = GameManager.shared.OUT_OF_SCREEN_AREA
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
                    //  中心座標
                    let playerX = player.body!.position.x + (player.body!.size.width / 2)
                    let playerY = player.body!.position.y + (player.body!.size.height / 2)
                    let enemyX = enemys[k].bullet.body[cnt].position.x + (enemys[k].bullet.body[cnt].size.width / 2)
                    let enemyY = enemys[k].bullet.body[cnt].position.y + (enemys[k].bullet.body[cnt].size.height / 2)
                    
                    // 三平方定理を使用して距離取得
                    let workX = ((playerX - enemyX) * (playerX - enemyX))
                    let workY = ((playerY - enemyY) * (playerY - enemyY))
                    let distance = sqrt(workX + workY)
                                        
                    // 対象となる二つのオブジェクトの半径の和を求める
                    let doubleWidth = ((player.body?.size.width)! / 2) + (enemys[k].bullet.body[cnt].size.width / 2)
                    
                    // 中心座標の2点間の距離より半径の和の方が大きければ接触
                    if distance <= doubleWidth && !GameManager.shared.isSeHit {
                        //GameManager.isSeHit = true
                        //GameScene.GetExplosionObject().isExplosion[k] = true
                        
                        //SoundManager.shared.PlaySE()
                        
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
