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
        }
    }
    
    func Update(_x: CGFloat, _y: CGFloat){
        switch nowBulletType {
        case bulletType.normalBullet.rawValue:
            NormalBullet(__x: _x, __y: _y)
            break
        case bulletType.tripleBullet.rawValue:
            TripleBullet(__x: _x, __y: _y)
            break
        default:
            break
        }
    }
    
    func NormalBullet(__x: CGFloat, __y: CGFloat) {
        // 弾発射前処理
        for i in 0..<ZIKIMAXBULLET {
            if !isBulletTrigger[i] && bulletStartTime > bulletDuration {
                isBulletTrigger[i] = true
                body[i].size = CGSize(width: 10, height: 10)
                body[i].position = CGPoint(x: __x, y: __y)
                GameManager.shared.scene?.addChild(body[i])
                bulletStartTime = 0
            }
        }
        // 弾移動処理
        for i in 0..<ZIKIMAXBULLET {
            if isBulletTrigger[i] {
                // 弾発射処理
                body[i].position.y -= 2
                body[i].run(SKAction.moveTo(y: body[i].position.y, duration: 0))
                
                // 画面エリア外判定
                if body[i].position.y <= (GameManager.shared.scene?.frame.minY)! || body[i].position.y >= (GameManager.shared.scene?.frame.maxY)! ||
                    body[i].position.x <= (GameManager.shared.scene?.frame.minX)! || body[i].position.x >= (GameManager.shared.scene?.frame.maxX)! {
                    isBulletTrigger[i] = false
                    body[i].removeFromParent()
                }
            }
            // 弾発射インタバル
            else if bulletStartTime <= bulletDuration {
                bulletStartTime += 1
            }
        }
    }
    
    func TripleBullet(__x: CGFloat, __y: CGFloat) {
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
                body[i].position = CGPoint(x: __x, y: __y)
                GameManager.shared.scene?.addChild(body[i])
                
                let vecX = RIGHTVECTOR_X
                let vecY = VECTOR_Y
                let length:Float = sqrt(vecX + vecY)
                
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
                    body[i].position.x += CGFloat(directionX[i] * BULLET_SPEED)
                    body[i].run(SKAction.moveTo(x: body[i].position.x, duration: 0))
                } else {
                    print("bulletDirection[i]",bulletDirection[i])
                    print("")
                }
                body[i].position.y -= CGFloat(directionY[i] * BULLET_SPEED)
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
