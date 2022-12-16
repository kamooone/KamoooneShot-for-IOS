//
//  BulletView.swift
//  KamoooneShot for IOS
//
//  Created by Kazusa Kondo on 2022/01/23.
//

import Foundation
import SpriteKit

class BulletView: BaseBulletView {
    private static var isSingleton: Bool = false
    let rotateSpeed: CGFloat = 2.25
    
    override init(){
        super.init()
        // このクラスのインスタンスは一つのみにする
        if !BulletView.isSingleton {
            // 自機弾の生成
            for i in 0..<ZIKIMAXBULLET {
                isBulletTrigger.append(false)
                body.append(SKSpriteNode(imageNamed: "bullet.png"))
                // 敵機の向き
                rotate = 180
                body[i].zRotation = DegreeToRadian(Degree: rotate)
                directionX.append(0.0)
                directionY.append(0.0)
            }
            BulletView.isSingleton = true
        } else {
            // エラー処理
            print("エラー処理")
        }
    }
    
    func Update(_x: CGFloat, _y: CGFloat, _rotate: CGFloat) {
        // 弾発射前処理
        for i in 0..<ZIKIMAXBULLET {
            if !isBulletTrigger[i] && bulletStartTime == 0 {
                isBulletTrigger[i] = true
                body[i].size = CGSize(width: 30, height: 30)
                body[i].position = CGPoint(x: _x, y: _y)
                body[i].zRotation = DegreeToRadian(Degree: _rotate + 180)
                GameManager.shared.scene?.addChild(body[i])
                bulletStartTime = bulletDuration

                // 時期の向きに合わせて弾のベクトルを決定する
                let work = abs(Int(_rotate / rotateSpeed))
                var vecX: CGFloat = 0 + (CGFloat(work) * 0.25)
                var vecY: CGFloat = 10 - (CGFloat(work) * 0.25)
                if _rotate < -90 || _rotate > 90 {
                    let w = (CGFloat(work) * 0.25) - 10
                    vecX = 10 - w
                    vecY = (CGFloat(work) * 0.25) - 10
                }
                
                let length:CGFloat = sqrt(vecX + vecY)
                directionX[i] = (vecX / length)
                directionY[i] = (vecY / length)

                if _rotate > 0 {
                    directionX[i] = (-vecX / length)
                }
                if _rotate < -90 || _rotate > 90 {
                    directionY[i] = (-vecY / length)
                }
                break
            }
        }
        
        // 弾移動処理
        for i in 0..<ZIKIMAXBULLET {
            if isBulletTrigger[i] {
                body[i].position.x += directionX[i] * BULLET_SPEED
                body[i].run(SKAction.moveTo(x: body[i].position.x, duration: 0))
                body[i].position.y += directionY[i] * BULLET_SPEED
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
            bulletStartTime -= 5
        }
    }
    
    func DegreeToRadian(Degree : CGFloat!)-> CGFloat{
        return CGFloat(Degree) / CGFloat(180.0 * M_1_PI)
    }
}
