//
//  EnemyBulettView.swift
//  KamoooneShot for IOS
//
//  Created by Kazusa Kondo on 2022/10/23.
//　プルリクエストテスト4

import Foundation
import SpriteKit

class EnemyBulletView: BaseBulletView {
    
    override init() {
        super.init()
        
        Init()
    }
    func Init(){
        // 自機弾の生成
        for _ in 0..<EnemyView.ENEMYMAX {
            for _ in 0..<ZIKIMAXBULLET {
                isBulletTrigger.append(false)
                body.append(SKSpriteNode(imageNamed: "pink.png"))
            }
        }
    }
    
    func Update(_x: CGFloat, _y: CGFloat){
        
        // 通常弾
//        if 0 == 0 {
//            // 弾発射前処理
//            for i in 0..<ZIKIMAXBULLET {
//                if !isBulletTrigger[i] && bulletStartTimeForEnemy > bulletDurationForEnemy {
//                    isBulletTrigger[i] = true
//                    body[i].size = CGSize(width: 10, height: 10)
//                    body[i].position = CGPoint(x: x, y: y)
//                    GameManager.shared.scene?.addChild(body[i])
//                    bulletStartTimeForEnemy = 0
//                }
//            }
//
//            // 弾移動処理
//            for i in 0..<ZIKIMAXBULLET {
//                if isBulletTrigger[i] {
//                    // 弾発射処理
//                    body[i].position.y -= 2
//                    body[i].run(SKAction.moveTo(y: body[i].position.y, duration: 0))
//
//                    if body[i].position.y <= (GameManager.shared.scene?.frame.minY)! {
//                        isBulletTrigger[i] = false
//                        body[i].removeFromParent()
//                    }
//                    break
//                }
//                // 弾発射インタバル
//                else if bulletStartTimeForEnemy <= bulletDurationForEnemy{
//                    bulletStartTimeForEnemy += 1
//                }
//            }
//        }
        
        
        // 三点弾
        // if 0 == 0 {
        let VECTOR_Y: Float = 50.0
        let RIGHTVECTOR_X: Float = 10.0
        let LEFTVECTOR_X: Float = 10.0
        var tripleBulletNo: Int = 0
        var directionRightX: Float = 0.0
        var directionRightY: Float = 0.0
        
        // 弾発射前処理
        for i in 0..<ZIKIMAXBULLET {
            if !isBulletTrigger[i] && bulletStartTimeForEnemy > bulletDurationForEnemy {
                isBulletTrigger[i] = true
                body[i].size = CGSize(width: 10, height: 10)
                body[i].position = CGPoint(x: _x, y: _y)
                GameManager.shared.scene?.addChild(body[i])
                bulletStartTimeForEnemy = 0
                
                switch tripleBulletNo {
                // 直進発射ToDo enumにする
                case 1:

                    break

                    // 右斜め上発射ToDo enumにする
                case 2:
                    // ターゲット方向のベクトルを求める
                    let vecX = RIGHTVECTOR_X
                    let vecY = VECTOR_Y
                    
                    // 三平方の定理を使って長さを求める
                    let length:Float = sqrt(vecX + vecY)
                    
                    // ベクトルを求めた長さで割り、正規化にする
                    directionRightX = vecX / length
                    directionRightY = vecY / length
                    
                    break
                    
                    // 左斜め上発射ToDo enumにする
                case 3:
                    // ターゲット方向のベクトルを求める

                    // 三平方の定理を使って長さを求める

                    // ベクトルを求めた長さで割り、正規化にする
                    
                    break
                    
                default:
                    break
                }
            }
        }
        
        // 弾移動処理
        for i in 0..<ZIKIMAXBULLET {
            if isBulletTrigger[i] {
                switch tripleBulletNo {
                // 直進発射ToDo enumにする
                case 1:
                    body[i].position.y -= 2
                    body[i].run(SKAction.moveTo(y: body[i].position.y, duration: 0))
                    
                    if body[i].position.y <= (GameManager.shared.scene?.frame.minY)! {
                        isBulletTrigger[i] = false
                        body[i].removeFromParent()
                    }
                    break
                
                // 右斜め上発射ToDo enumにする
                case 2:
                    body[i].position.x -= CGFloat(directionRightX * 2)
                    body[i].run(SKAction.moveTo(x: body[i].position.x, duration: 0))
                    body[i].position.y -= CGFloat(directionRightY * 2)
                    body[i].run(SKAction.moveTo(y: body[i].position.y, duration: 0))
                    
                    if body[i].position.y <= (GameManager.shared.scene?.frame.minY)! {
                        isBulletTrigger[i] = false
                        body[i].removeFromParent()
                    }
                    break
                    
                // 左斜め上発射ToDo enumにする
                case 3:
                    
                    break
                default:
                    break
                    
                }
            }
            tripleBulletNo += 1
        }
//        // 弾発射インタバル
//        else if bulletStartTimeForEnemy <= bulletDurationForEnemy{
//            bulletStartTimeForEnemy += 1
//        }
        
    }
}
