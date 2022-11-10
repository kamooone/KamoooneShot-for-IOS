//
//  EnemyBulettView.swift
//  KamoooneShot for IOS
//
//  Created by Kazusa Kondo on 2022/10/23.
//

import Foundation
import SpriteKit

class EnemyBulletView: BaseBulletView {
    let VECTOR_Y: Float = 50.0
    let RIGHTVECTOR_X: Float = 10.0
    let LEFTVECTOR_X: Float = 10.0
    var tripleBulletNo: Int = 0
    var directionX: [Float] = []
    var directionY: [Float] = []
    enum threeShots: Int {
        case straight = 0
        case diagonalRightFront = 1
        case diagonalLeftFront = 2
    }
    
    
    override init() {
        super.init()
        Init()
    }
    func Init(){
        // エネミー弾の生成
        for _ in 0..<ZIKIMAXBULLET {
            isBulletTrigger.append(false)
            body.append(SKSpriteNode(imageNamed: "pink.png"))
        }
    }
    
    func Update(_x: CGFloat, _y: CGFloat){
        
        // 通常弾
//        if 0 == 0 {
//            // 弾発射前処理
//            for i in 0..<ZIKIMAXBULLET {
//                if !isBulletTrigger[i] && bulletStartTimeForEnemy[i] > bulletDurationForEnemy[i] {
//                    isBulletTrigger[i] = true
//                    body[i].size = CGSize(width: 10, height: 10)
//                    body[i].position = CGPoint(x: _x, y: _y)
//                    GameManager.shared.scene?.addChild(body[i])
//                    bulletStartTimeForEnemy[i] = 0
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
//                    if body[i].position.y <= (GameManager.shared.scene?.frame.minY)! || body[i].position.y >= (GameManager.shared.scene?.frame.maxY)! ||
//                        body[i].position.x <= (GameManager.shared.scene?.frame.minX)! || body[i].position.x >= (GameManager.shared.scene?.frame.maxX)! {
//                        isBulletTrigger[i] = false
//                        body[i].removeFromParent()
//                    }
//
//                }
//                // 弾発射インタバル
//                else if bulletStartTimeForEnemy[i] <= bulletDurationForEnemy[i] {
//                    bulletStartTimeForEnemy[i] += 1
//                }
//            }
//        }
        
        
        // 三点弾 ToDo enumを使う
        if 0 == 0 {
            // 弾の種類によって弾の間隔時間を変更する
            bulletDuration = 50
            // 弾発射前処理
            for i in 0..<ZIKIMAXBULLET {
                if !isBulletTrigger[i] && bulletStartTime > bulletDuration {
                    isBulletTrigger[i] = true
                    body[i].size = CGSize(width: 10, height: 10)
                    body[i].position = CGPoint(x: _x, y: _y)
                    GameManager.shared.scene?.addChild(body[i])
                    bulletStartTime = 0

                    // ターゲット方向のベクトルを求める
                    let vecX = RIGHTVECTOR_X
                    let vecY = VECTOR_Y

                    // 三平方の定理を使って長さを求める
                    let length:Float = sqrt(vecX + vecY)

                    // ベクトルを求めた長さで割り、正規化にする
                    if tripleBulletNo != 1 {
                        directionX.append(vecX / length)
                    } else {
                        directionX.append((vecX / length) * -1)
                    }
                    directionY.append(vecY / length)
                    tripleBulletNo += 1

                    if tripleBulletNo == 3 {
                        tripleBulletNo = 0
                    }
                }
            }

            // 弾移動処理
            for i in 0..<ZIKIMAXBULLET {
                if isBulletTrigger[i] {
                    if tripleBulletNo != 0 {
                        body[i].position.x += CGFloat(directionX[i] * BULLET_SPEED)
                        body[i].run(SKAction.moveTo(x: body[i].position.x, duration: 0))
                    }
                    body[i].position.y -= CGFloat(directionY[i] * BULLET_SPEED)
                    body[i].run(SKAction.moveTo(y: body[i].position.y, duration: 0))

                    if body[i].position.y <= (GameManager.shared.scene?.frame.minY)! || body[i].position.y >= (GameManager.shared.scene?.frame.maxY)! ||
                        body[i].position.x <= (GameManager.shared.scene?.frame.minX)! || body[i].position.x >= (GameManager.shared.scene?.frame.maxX)! {
                        isBulletTrigger[i] = false
                        body[i].removeFromParent()
                    }
                    tripleBulletNo += 1
                    if tripleBulletNo == 3 {
                        tripleBulletNo = 0
                    }
                }
                // 弾発射インタバル
                else if bulletStartTime <= bulletDuration {
                    bulletStartTime += 1
                }
            }
        }
    }
}
