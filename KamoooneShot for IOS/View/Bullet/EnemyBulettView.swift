//
//  EnemyBulettView.swift
//  KamoooneShot for IOS
//
//  Created by Kazusa Kondo on 2022/10/23.
//

import Foundation
import SpriteKit

class EnemyBulletView: BaseBulletView {    
    var tripleBulletNo: Int = 1
    
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
        // 弾の種類によって弾の間隔時間を変更する
        bulletDuration = 50
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
        enum tripleBullet: Int {
            case straight = 0
            case diagonallyRight = 1
            case diagonallyLeft = 2
        }
        // 弾の種類によって弾の間隔時間を変更する
        bulletDuration = 50
        // 弾発射前処理
        for i in 0..<ZIKIMAXBULLET {
            if !isBulletTrigger[i] && bulletStartTime > bulletDuration {
                isBulletTrigger[i] = true
                body[i].size = CGSize(width: 10, height: 10)
                body[i].position = CGPoint(x: __x, y: __y)
                GameManager.shared.scene?.addChild(body[i])
                bulletStartTime = 0
                
                let vecX = RIGHTVECTOR_X
                let vecY = VECTOR_Y
                let length:Float = sqrt(vecX + vecY)
            
                if tripleBulletNo == tripleBullet.diagonallyRight.rawValue {
                    directionX.append((vecX / length) * -1)
                } else {
                    directionX.append(vecX / length)
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
                
                // 画面エリア外判定
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
