//
//  EnemyBulettView.swift
//  KamoooneShot for IOS
//
//  Created by Kazusa Kondo on 2022/10/23.
//マージテスト11/9

import Foundation
import SpriteKit

class EnemyBulletView: BaseBulletView {
    let VECTOR_Y: Float = 50.0
    let RIGHTVECTOR_X: Float = 10.0
    let LEFTVECTOR_X: Float = 10.0
    var tripleBulletNo: Int = 0
    // ToDo directionは右左関係なく同じ配列にする。直進の弾にもdirectionを設定する。(要素番号を揃えるため)
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
            bulletDurationForEnemy.append(50)
            bulletStartTimeForEnemy.append(0)
            body.append(SKSpriteNode(imageNamed: "pink.png"))
        }
    }
    
    func Update(_x: CGFloat, _y: CGFloat){
        
        // 通常弾
//                if 0 == 0 {
//                    // 弾発射前処理
//                    for i in 0..<ZIKIMAXBULLET {
//                        if !isBulletTrigger[i] && bulletStartTimeForEnemy > bulletDurationForEnemy {
//                            isBulletTrigger[i] = true
//                            body[i].size = CGSize(width: 10, height: 10)
//                            body[i].position = CGPoint(x: _x, y: _y)
//                            GameManager.shared.scene?.addChild(body[i])
//                            bulletStartTimeForEnemy = 0
//                        }
//                    }
//
//                    // 弾移動処理
//                    for i in 0..<ZIKIMAXBULLET {
//                        if isBulletTrigger[i] {
//                            // 弾発射処理
//                            body[i].position.y -= 2
//                            body[i].run(SKAction.moveTo(y: body[i].position.y, duration: 0))
//
//                            if body[i].position.y <= (GameManager.shared.scene?.frame.minY)! {
//                                isBulletTrigger[i] = false
//                                body[i].removeFromParent()
//                            }
//                            break
//                        }
//                        // 弾発射インタバル
//                        else if bulletStartTimeForEnemy <= bulletDurationForEnemy{
//                            bulletStartTimeForEnemy += 1
//                        }
//                    }
//                }
        
        
        // 三点弾 ToDo enumを使う
        if 0 == 0 {
            // 弾発射前処理
            for i in 0..<ZIKIMAXBULLET {
                if !isBulletTrigger[i] && bulletStartTimeForEnemy[i] > bulletDurationForEnemy[i] {
                    isBulletTrigger[i] = true
                    body[i].size = CGSize(width: 10, height: 10)
                    body[i].position = CGPoint(x: _x, y: _y)
                    GameManager.shared.scene?.addChild(body[i])
                    bulletStartTimeForEnemy[i] = 0

                    switch tripleBulletNo {
                    case threeShots.straight.rawValue:
                        // 直進弾のベクトル
                        directionX.append(0)
                        directionY.append(0)
                        tripleBulletNo += 1
                        break

                    case threeShots.diagonalRightFront.rawValue:
                        // ターゲット方向のベクトルを求める
                        let vecX = RIGHTVECTOR_X
                        let vecY = VECTOR_Y

                        // 三平方の定理を使って長さを求める
                        let length:Float = sqrt(vecX + vecY)

                        // ベクトルを求めた長さで割り、正規化にする
                        directionX.append(vecX / length)
                        directionY.append(vecY / length)
                        tripleBulletNo += 1
                        break

                    case threeShots.diagonalLeftFront.rawValue:
                        // ターゲット方向のベクトルを求める
                        let vecX = LEFTVECTOR_X
                        let vecY = VECTOR_Y

                        // 三平方の定理を使って長さを求める
                        let length:Float = sqrt(vecX + vecY)

                        // ベクトルを求めた長さで割り、正規化にする
                        directionX.append(vecX / length)
                        directionY.append(vecY / length)
                        tripleBulletNo = 0
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
                    case threeShots.straight.rawValue:
                        body[i].position.y -= 2
                        body[i].run(SKAction.moveTo(y: body[i].position.y, duration: 0))

                        if body[i].position.y <= (GameManager.shared.scene?.frame.minY)! || body[i].position.y >= (GameManager.shared.scene?.frame.maxY)! ||
                            body[i].position.x <= (GameManager.shared.scene?.frame.minX)! ||
                            body[i].position.x >= (GameManager.shared.scene?.frame.maxX)! {
                            isBulletTrigger[i] = false
                            body[i].removeFromParent()
                        }
                        tripleBulletNo += 1
                        break

                    case threeShots.diagonalRightFront.rawValue:
                        body[i].position.x += CGFloat(directionX[i] * 0.2)
                        body[i].run(SKAction.moveTo(x: body[i].position.x, duration: 0))
                        body[i].position.y -= CGFloat(directionY[i] * 0.2)
                        body[i].run(SKAction.moveTo(y: body[i].position.y, duration: 0))

                        if body[i].position.y <= (GameManager.shared.scene?.frame.minY)! || body[i].position.y >= (GameManager.shared.scene?.frame.maxY)! ||
                            body[i].position.x <= (GameManager.shared.scene?.frame.minX)! ||
                            body[i].position.x >= (GameManager.shared.scene?.frame.maxX)! {
                            isBulletTrigger[i] = false
                            body[i].removeFromParent()
                        }
                        tripleBulletNo += 1
                        break

                    case threeShots.diagonalLeftFront.rawValue:
                        body[i].position.x -= CGFloat(directionX[i] * 0.2)
                        body[i].run(SKAction.moveTo(x: body[i].position.x, duration: 0))
                        body[i].position.y -= CGFloat(directionY[i] * 0.2)
                        body[i].run(SKAction.moveTo(y: body[i].position.y, duration: 0))

                        if body[i].position.y <= (GameManager.shared.scene?.frame.minY)! || body[i].position.y >= (GameManager.shared.scene?.frame.maxY)! ||
                            body[i].position.x <= (GameManager.shared.scene?.frame.minX)! ||
                            body[i].position.x >= (GameManager.shared.scene?.frame.maxX)! {
                            isBulletTrigger[i] = false
                            body[i].removeFromParent()
                        }
                        tripleBulletNo = 0
                        break
                    default:
                        break

                    }
                }
                // 弾発射インタバル
                else if bulletStartTimeForEnemy[i] <= bulletDurationForEnemy[i] {
                    bulletStartTimeForEnemy[i] += 1
                }
            }
        }
    }
}
