//
//  EnemyView.swift
//  KamoooneShot for IOS
//
//  Created by Kazusa Kondo on 2022/01/23.
//

import Foundation
import SpriteKit

class EnemyView: BaseCharacterView {
    public static let ENEMYMAX: Int = 10
    
    let bullet = EnemyBulletView()
    
    override init() {
        super.init()
        // 画像設定
        body = SKSpriteNode(imageNamed: "enemy.png")
        // ポジション設定
        body?.position = CGPoint(x: CGFloat.random(in: (GameManager.shared.scene?.frame.minX)! + 25..<(GameManager.shared.scene?.frame.maxX)! - 25), y: CGFloat.random(in: (GameManager.shared.scene?.frame.maxY)! + 150..<(GameManager.shared.scene?.frame.maxY)! + 600))
        // 敵機の向き
        rotate = 180
        body?.zRotation = DegreeToRadian(Degree: rotate)
        // sceneに登録
        GameManager.shared.scene?.addChild(body!)
    }
    
    func Update(_playerX : CGFloat, _playerY : CGFloat){
        // ToDo 自機の方を向く処理(将来的には弾を打つ直前だけ向く処理を入れる。弾を打つ処理も特定のタイミングの時だけ)
        // ベクトルと角度を求める。そして何°回転させる必要があるか。
        // atanは「アークタンジェント」のことで、「タンジェントの逆三角関数」であるとのこと。辺の長さから角度を求めるために使われるものらしい。
        let pX = _playerX
        let pY = _playerY
        let eX = (body?.position.x)!
        let eY = (body?.position.y)!
        let r = atan2(Double(pY - eY), Double(pX - eX))
        let r1 = r + 2 * Double.pi
        let radian = floor(r1 * 360 / (2 * Double.pi))
        body?.zRotation = DegreeToRadian(Degree: radian - 90)
        
        // ToDo 向きが決定してから弾を打つようにする。(向きが決定してかつ弾を打っている時は向きを変えない)
        body!.position.y -= 0.5
        bullet.Update(_enemyBulletX: body!.position.x, _enemyBulletY: body!.position.y, __playerX: _playerX, __playerY: _playerY, _radian: radian)
    }
    
    func DegreeToRadian(Degree : Double!)-> CGFloat{
        return CGFloat(Degree) / CGFloat(180.0 * M_1_PI)
    }
}



