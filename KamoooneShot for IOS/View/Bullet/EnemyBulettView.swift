//
//  EnemyBulettView.swift
//  KamoooneShot for IOS
//
//  Created by Kazusa Kondo on 2022/10/23.
//

import Foundation
import SpriteKit

class EnemyBulletView: BaseBulletView {    
    var tripleBulletNo: Int = 0
    
    override init() {
        super.init()
        // エネミー弾の生成
        for _ in 0..<ZIKIMAXBULLET {
            isBulletTrigger.append(false)
            body.append(SKSpriteNode(imageNamed: "bullet.png"))
            bulletDirection.append("")
            directionX.append(0.0)
            directionY.append(0.0)
            normalVecX.append(0.0)
            normalVecY.append(0.0)
            homingEnabled.append(false)
            homingLength.append(0.0)
        }
    }
    
    func Update(_enemyBulletX: CGFloat, _enemyBulletY: CGFloat, __playerX: CGFloat, __playerY: CGFloat, _radian: CGFloat) {
        print("_radian",_radian)
        switch nowBulletType {
        case bulletType.normalBullet.rawValue:
            NormalBullet(__enemyBulletX: _enemyBulletX, __enemyBulletY: _enemyBulletY, ___playerX: __playerX, ___playerY: __playerY, __radian: _radian)
            break
        case bulletType.tripleBullet.rawValue:
            TripleBullet(__enemyBulletX: _enemyBulletX, __enemyBulletY: _enemyBulletY, ___playerX: __playerX, ___playerY: __playerY, __radian: _radian)
            break
        case bulletType.homingBullet.rawValue:
            homingBullet(__enemyBulletX: _enemyBulletX, __enemyBulletY: _enemyBulletY, ___playerX: __playerX, ___playerY: __playerY, __radian: _radian)
            break
        default:
            break
        }
    }
    
    func NormalBullet(__enemyBulletX: CGFloat, __enemyBulletY: CGFloat, ___playerX: CGFloat, ___playerY: CGFloat, __radian: CGFloat) {
        // 弾のベクトルをプレイヤー目掛け手にする。(弾を発射したらベクトルは変更しない、※ホーミングバレットのベクトル固定Ver)
        
        for i in 0..<ZIKIMAXBULLET {
            if !isBulletTrigger[i] && bulletStartTime == 0 {
                isBulletTrigger[i] = true
                body[i].size = CGSize(width: 30, height: 30)
                body[i].position = CGPoint(x: __enemyBulletX, y: __enemyBulletY)
                GameManager.shared.scene?.addChild(body[i])
                bulletStartTime = bulletDuration
                
                // 弾発射ベクトルを求める(発射後は固定)
                let length = sqrt((___playerX - body[i].position.x) * (___playerX - body[i].position.x) + (___playerY - body[i].position.y) * (___playerY - body[i].position.y))
                normalVecX[i] = (___playerX - body[i].position.x) / length
                normalVecY[i] = (___playerY - body[i].position.y) / length
            }
        }
        // 弾移動処理
        for i in 0..<ZIKIMAXBULLET {
            if isBulletTrigger[i] {
                                
                body[i].position.x += normalVecX[i] * BULLET_SPEED
                body[i].run(SKAction.moveTo(x: body[i].position.x, duration: 0))
                body[i].position.y += normalVecY[i] * BULLET_SPEED
                body[i].run(SKAction.moveTo(y: body[i].position.y, duration: 0))
                
                body[i].zRotation = Processing.shared.DegreeToRadian(Degree: __radian)
                
                // 画面エリア外判定
                if body[i].position.y <= (GameManager.shared.scene?.frame.minY)! || body[i].position.y >= (GameManager.shared.scene?.frame.maxY)! ||
                    body[i].position.x <= (GameManager.shared.scene?.frame.minX)! || body[i].position.x >= (GameManager.shared.scene?.frame.maxX)! {
                    isBulletTrigger[i] = false
                    body[i].removeFromParent()
                }
            }
        }
        
        // 弾発射インタバル
        if bulletStartTime != 0 {
            bulletStartTime -= 1
        }
    }
    
    func TripleBullet(__enemyBulletX: CGFloat, __enemyBulletY: CGFloat, ___playerX: CGFloat, ___playerY: CGFloat, __radian: CGFloat) {
        enum tripleBulletType: Int {
            case straight = 1
            case diagonallyRight = 2
            case diagonallyLeft = 3
        }
        
        for i in 0..<ZIKIMAXBULLET {
            if !isBulletTrigger[i] && bulletStartTime == 0 {
                isBulletTrigger[i] = true
                body[i].size = CGSize(width: 30, height: 30)
                body[i].position = CGPoint(x: __enemyBulletX, y: __enemyBulletY)
                GameManager.shared.scene?.addChild(body[i])
                            
                let length:CGFloat = sqrt((___playerX - body[i].position.x) * (___playerX - body[i].position.x) + (___playerY - body[i].position.y) * (___playerY - body[i].position.y))
                tripleBulletNo += 1
                switch tripleBulletNo {
                case tripleBulletType.straight.rawValue:
                    bulletDirection[i] = "Straight"
                    normalVecX[i] = (___playerX - body[i].position.x) / length
                    normalVecY[i] = (___playerY - body[i].position.y) / length
                    break
                    
                case tripleBulletType.diagonallyRight.rawValue:
                    bulletDirection[i] = "DiagonallyRight"
                    normalVecX[i] = (___playerX - body[i].position.x + 45) / length
                    normalVecY[i] = (___playerY - body[i].position.y) / length
                    break
                    
                case tripleBulletType.diagonallyLeft.rawValue:
                    bulletDirection[i] = "DiagonallyLeft"
                    normalVecX[i] = (___playerX - body[i].position.x - 45) / length
                    normalVecY[i] = (___playerY - body[i].position.y) / length
                    tripleBulletNo = 0
                    bulletStartTime = bulletDuration
                    break
                default:
                    break
                }
            }
        }
        // 弾移動処理
        for i in 0..<ZIKIMAXBULLET {
            if isBulletTrigger[i] {
                                
                body[i].position.x += normalVecX[i] * BULLET_SPEED
                body[i].run(SKAction.moveTo(x: body[i].position.x, duration: 0))
                body[i].position.y += normalVecY[i] * BULLET_SPEED
                body[i].run(SKAction.moveTo(y: body[i].position.y, duration: 0))
                
                // トリプルバレットなので一番目と3番目の弾は別途__radian値の調整必要
                body[i].zRotation = Processing.shared.DegreeToRadian(Degree: __radian)
                
                // 画面エリア外判定
                if body[i].position.y <= (GameManager.shared.scene?.frame.minY)! || body[i].position.y >= (GameManager.shared.scene?.frame.maxY)! ||
                    body[i].position.x <= (GameManager.shared.scene?.frame.minX)! || body[i].position.x >= (GameManager.shared.scene?.frame.maxX)! {
                    isBulletTrigger[i] = false
                    body[i].removeFromParent()
                }
            }
        }
        
        // 弾発射インタバル
        if bulletStartTime != 0 {
            bulletStartTime -= 1
        }
    }
    
    func homingBullet(__enemyBulletX: CGFloat, __enemyBulletY: CGFloat, ___playerX: CGFloat, ___playerY: CGFloat, __radian: CGFloat) {
        // 弾発射前処理
        for i in 0..<ZIKIMAXBULLET {
            if !isBulletTrigger[i] && bulletStartTime == 0 {
                isBulletTrigger[i] = true
                body[i].size = CGSize(width: 30, height: 30)
                body[i].position = CGPoint(x: __enemyBulletX, y: __enemyBulletY)
                GameManager.shared.scene?.addChild(body[i])
                bulletStartTime = bulletDuration
                homingEnabled[i] = true
            }
        }
        
        // 弾移動処理
        for i in 0..<ZIKIMAXBULLET {
            if isBulletTrigger[i] {
                // ホーミング有効時の処理
                if homingEnabled[i] {
                    homingLength[i] = sqrt((___playerX - body[i].position.x) * (___playerX - body[i].position.x) + (___playerY - body[i].position.y) * (___playerY - body[i].position.y))
                    body[i].position.x += (___playerX - body[i].position.x) / homingLength[i] * BULLET_SPEED
                    body[i].run(SKAction.moveTo(x: body[i].position.x, duration: 0))
                    body[i].position.y += (___playerY - body[i].position.y) / homingLength[i] * BULLET_SPEED
                    body[i].run(SKAction.moveTo(y: body[i].position.y, duration: 0))
                    // ToDo __radian + 180  これをさらにホーミングによって回転した角度を足さないといけない(先にホーミングで回転した角度を求める必要あり)
                    body[i].zRotation = Processing.shared.DegreeToRadian(Degree: __radian + 180)
                    // 一定の距離まで近づくとホーミング処理停止して現在のベクトルで直進する
                    if homingLength[i] < 80 {
                        homingEnabled[i] = false
                        homingLength[i] = sqrt((___playerX - body[i].position.x) * (___playerX - body[i].position.x) + (___playerY - body[i].position.y) * (___playerY - body[i].position.y))
                        normalVecX[i] = (___playerX - body[i].position.x) / homingLength[i] * BULLET_SPEED
                        normalVecY[i] = (___playerY - body[i].position.y) / homingLength[i] * BULLET_SPEED
                    }
                }
                // ホーミング無効時の処理
                if !homingEnabled[i] {
                    body[i].position.x += normalVecX[i]
                    body[i].run(SKAction.moveTo(x: body[i].position.x, duration: 0))
                    body[i].position.y += normalVecY[i]
                    body[i].run(SKAction.moveTo(y: body[i].position.y, duration: 0))
                }
                
                // 画面エリア外判定
                if body[i].position.y <= (GameManager.shared.scene?.frame.minY)! || body[i].position.y >= (GameManager.shared.scene?.frame.maxY)! ||
                    body[i].position.x <= (GameManager.shared.scene?.frame.minX)! || body[i].position.x >= (GameManager.shared.scene?.frame.maxX)! {
                    isBulletTrigger[i] = false
                    homingEnabled[i] = true
                    body[i].removeFromParent()
                }
            }
        }
        
        // 弾発射インタバル
        if bulletStartTime != 0 {
            bulletStartTime -= 1
        }
    }
}
