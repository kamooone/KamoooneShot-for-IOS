//
//  EnemyView.swift
//  KamoooneShot for IOS
//
//  Created by Kazusa Kondo on 2022/01/23.
//

import Foundation
import SpriteKit

class EnemyView: BaseCharacterView {
    public static let ENEMYMAX: Int = 20

    let bullet = EnemyBulletView()
    var rotateAction :SKAction?
    
    override init(){
        super.init()
        // 指定した回転値まで回転させるアクションを作る.
        //rotateAction = SKAction.rotate( toAngle: DegreeToRadian(Degree: 180.0) , duration: 1)
        
        // 画像設定
        body = SKSpriteNode(imageNamed: "enemy.png")
        // ポジション設定
        body?.position = CGPoint(x: CGFloat.random(in: (GameManager.shared.scene?.frame.minX)! + 25..<(GameManager.shared.scene?.frame.maxX)! - 25), y: CGFloat.random(in: (GameManager.shared.scene?.frame.maxY)! + 150..<(GameManager.shared.scene?.frame.maxY)! + 600))
        // 180度回転
        body?.zRotation = DegreeToRadian(Degree: 180)
        // sceneに登録
        GameManager.shared.scene?.addChild(body!)
        // 弾初期化
        bullet.Init()
    }
    
    func Update(){
        body!.position.y -= 1
        bullet.Update(x: body!.position.x, y: body!.position.y)
    }
    
    func DegreeToRadian(Degree : Double!)-> CGFloat{
        return CGFloat(Degree) / CGFloat(180.0 * M_1_PI)
    }
}



