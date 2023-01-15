//
//  EnemyView.swift
//  KamoooneShot for IOS
//
//  Created by Kazusa Kondo on 2022/01/23.
//

import Foundation
import SpriteKit

class EnemyView: BaseCharacterView {
    let bullet = EnemyBulletView()
    
    override init() {
        super.init()
        // 画像設定
        body = SKSpriteNode(imageNamed: "enemy.png")
        // ポジション設定
        body?.position = CGPoint(x: CGFloat.random(in: (GameManager.shared.scene?.frame.minX)! + 25..<(GameManager.shared.scene?.frame.maxX)! - 25), y: CGFloat.random(in: (GameManager.shared.scene?.frame.maxY)! + 150..<(GameManager.shared.scene?.frame.maxY)! + 600))
        // 敵機の向き
        rotate = 180
        body?.zRotation = Processing.shared.DegreeToRadian(Degree: rotate)
        // sceneに登録
        GameManager.shared.scene?.addChild(body!)
    }
    
    func Update(_playerX : CGFloat, _playerY : CGFloat){
        // ToDo 自機の方を向く処理(将来的には弾を打つ直前だけ向く処理を入れる。弾を打つ処理も特定のタイミングの時だけ)
        let radian = DirectionUpdate(__playerX: _playerX, __playerY: _playerY)
        
        // ToDo 行動パターン処理を使い分けて敵の種類のバリエーションを実装
        Formation.shared.Update(_body: body!)
        
        // ToDo 向きが決定してから弾を打つようにする。(向きが決定してかつ弾を打っている時は向きを変えない)
        bullet.Update(_enemyBulletX: body!.position.x, _enemyBulletY: body!.position.y, __playerX: _playerX, __playerY: _playerY, _radian: radian - 90)
    }
    
    func DirectionUpdate(__playerX: CGFloat, __playerY : CGFloat) -> CGFloat {
        // ベクトルと角度を求める。そして何°回転させる必要があるか。
        // atanは「アークタンジェント」のことで、「タンジェントの逆三角関数」であるとのこと。辺の長さから角度を求めるために使われるものらしい。
        let pX = __playerX
        let pY = __playerY
        let eX = (body?.position.x)!
        let eY = (body?.position.y)!
        let r = atan2(CGFloat(pY - eY), CGFloat(pX - eX))
        let r1 = r + 2 * CGFloat.pi
        let radian = floor(r1 * 360 / (2 * CGFloat.pi))
        body?.zRotation = Processing.shared.DegreeToRadian(Degree: radian - 90)
        
        return radian
    }
    
}
