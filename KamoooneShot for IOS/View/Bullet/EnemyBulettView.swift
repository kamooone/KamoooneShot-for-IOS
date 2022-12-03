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
            body.append(SKSpriteNode(imageNamed: "pink.png"))
            bulletDirection.append("")
            directionX.append(0.0)
            directionY.append(0.0)
            normalVecX.append(0.0)
            normalVecY.append(0.0)
        }
    }
    
    func Update(_enemyBulletX: CGFloat, _enemyBulletY: CGFloat, __playerX: CGFloat, __playerY: CGFloat, _radian: Double) {
        print("_radian",_radian)
        switch nowBulletType {
        case bulletType.normalBullet.rawValue:
            NormalBullet(__enemyBulletX: _enemyBulletX, __enemyBulletY: _enemyBulletY, ___playerX: __playerX, ___playerY: __playerY)
            break
        case bulletType.tripleBullet.rawValue:
            TripleBullet(__enemyBulletX: _enemyBulletX, __enemyBulletY: _enemyBulletY)
            break
        case bulletType.homingBullet.rawValue:
            homingBullet(__enemyBulletX: _enemyBulletX, __enemyBulletY: _enemyBulletY, ___playerX: __playerX, ___playerY: __playerY)
            break
        default:
            break
        }
    }
    
    func NormalBullet(__enemyBulletX: CGFloat, __enemyBulletY: CGFloat, ___playerX: CGFloat, ___playerY: CGFloat) {
        // 弾のベクトルをプレイヤー目掛け手にする。(弾を発射したらベクトルは変更しない、※ホーミングバレットのベクトル固定Ver)
        
        for i in 0..<ZIKIMAXBULLET {
            if !isBulletTrigger[i] && bulletStartTime == 0 {
                isBulletTrigger[i] = true
                body[i].size = CGSize(width: 10, height: 10)
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
    
    func TripleBullet(__enemyBulletX: CGFloat, __enemyBulletY: CGFloat) {
        enum tripleBulletType: Int {
            case straight = 1
            case diagonallyRight = 2
            case diagonallyLeft = 3
        }
        // 弾発射前処理
        for i in 0..<ZIKIMAXBULLET {
            if !isBulletTrigger[i] && bulletStartTime == 0 {
                isBulletTrigger[i] = true
                body[i].size = CGSize(width: 10, height: 10)
                body[i].position = CGPoint(x: __enemyBulletX, y: __enemyBulletY)
                GameManager.shared.scene?.addChild(body[i])
                
                let vecX = RIGHTVECTOR_X
                let vecY = VECTOR_Y
                let length:CGFloat = sqrt(vecX + vecY)
                
                tripleBulletNo += 1
                directionY[i] = (vecY / length)
                switch tripleBulletNo {
                case tripleBulletType.straight.rawValue:
                    bulletDirection[i] = "Straight"
                    break
                    
                case tripleBulletType.diagonallyRight.rawValue:
                    directionX[i] = (vecX / length) * -1
                    bulletDirection[i] = "DiagonallyRight"
                    break
                    
                case tripleBulletType.diagonallyLeft.rawValue:
                    directionX[i] = (vecX / length)
                    bulletDirection[i] = "DiagonallyLeft"
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
                if bulletDirection[i] != "Straight" {
                    body[i].position.x += directionX[i] * BULLET_SPEED
                    body[i].run(SKAction.moveTo(x: body[i].position.x, duration: 0))
                }
                body[i].position.y -= directionY[i] * BULLET_SPEED
                body[i].run(SKAction.moveTo(y: body[i].position.y, duration: 0))
                
                
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
    
    func homingBullet(__enemyBulletX: CGFloat, __enemyBulletY: CGFloat, ___playerX: CGFloat, ___playerY: CGFloat) {
        // 弾発射前処理
        for i in 0..<ZIKIMAXBULLET {
            if !isBulletTrigger[i] && bulletStartTime == 0 {
                isBulletTrigger[i] = true
                body[i].size = CGSize(width: 10, height: 10)
                body[i].position = CGPoint(x: __enemyBulletX, y: __enemyBulletY)
                GameManager.shared.scene?.addChild(body[i])
                bulletStartTime = bulletDuration
            }
        }
        // 弾移動処理
        for i in 0..<ZIKIMAXBULLET {
            if isBulletTrigger[i] {
                // 三平方の定理を使って長さを求める
                let length = sqrt((___playerX - body[i].position.x) * (___playerX - body[i].position.x) + (___playerY - body[i].position.y) * (___playerY - body[i].position.y))
                                
                body[i].position.x += (___playerX - body[i].position.x) / length * BULLET_SPEED
                body[i].run(SKAction.moveTo(x: body[i].position.x, duration: 0))
                body[i].position.y += (___playerY - body[i].position.y) / length * BULLET_SPEED
                body[i].run(SKAction.moveTo(y: body[i].position.y, duration: 0))
                
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
}
