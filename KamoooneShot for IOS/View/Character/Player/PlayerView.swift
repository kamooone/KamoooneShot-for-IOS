//
//  PlayerView.swift
//  KamoooneShot for IOS
//
//  Created by Kazusa Kondo on 2022/01/22.
//

import Foundation
import SpriteKit

class PlayerView: BaseCharacterView {
    private static var isSingleton: Bool = false
    let bullet = BulletView()
    
    override init(){
        super.init()
        // このクラスのインスタンスを一つしか生成できないようにする
        if !PlayerView.isSingleton {
            // 自機の生成
            body = SKSpriteNode(imageNamed: "ziki.png")
            body!.position = CGPoint(x: (GameManager.shared.scene?.frame.midX)!, y: (GameManager.shared.scene?.frame.minY)!+150)
            GameManager.shared.scene?.addChild(body!)
            PlayerView.isSingleton = true
        } else {
            // エラー処理に飛ばす
            print("インスタンス重複エラー")
        }
    }
    
    func Move(_positionX: CGFloat, _positionY: CGFloat, _stickLength: CGFloat){
        // ボタンを二つ追加して左右の回転ボタンにする。
        if GameManager.shared.isRightButtonTouch {
            rotate -= 2
        } else if GameManager.shared.isLeftButtonTouch {
            rotate += 2
        }
        // ToDo rotateをベクトルに変換する
        print("rotate",rotate)
        body?.zRotation = DegreeToRadian(Degree: rotate)
        
        if GameManager.shared.touchPos.x != 0 && GameManager.shared.touchPos.y != 0 {
            let workX = (GameManager.shared.touchPos.x - _positionX) * (GameManager.shared.touchPos.x - _positionX)
            let workY = (GameManager.shared.touchPos.y - _positionY) * (GameManager.shared.touchPos.y - _positionY)
            let length = sqrt(workX + workY)
            
            speed = velocity * _stickLength
            body?.position.x += (GameManager.shared.touchPos.x - _positionX) / length * speed
            body?.position.y += (GameManager.shared.touchPos.y - _positionY) / length * speed
            
            // 画面外に出たら戻す
            if (GameManager.shared.scene?.frame.maxX)! - 25 < (body?.position.x)! {
                body?.position.x -= (GameManager.shared.touchPos.x - _positionX) / length * speed
            }
            if (GameManager.shared.scene?.frame.minX)! + 25 > (body?.position.x)! {
                body?.position.x -= (GameManager.shared.touchPos.x - _positionX) / length * speed
            }
            if (GameManager.shared.scene?.frame.maxY)! - 100 < (body?.position.y)! {
                body?.position.y -= (GameManager.shared.touchPos.y - _positionY) / length * speed
            }
            if (GameManager.shared.scene?.frame.minY)! + 100 > (body?.position.y)! {
                body?.position.y -= (GameManager.shared.touchPos.y - _positionY) / length * speed
            }
            
            body?.run(SKAction.moveTo(x: (body?.position.x)!, duration: 0))
            body?.run(SKAction.moveTo(y: (body?.position.y)!, duration: 0))
        }
    }
    
    func Update(){
        bullet.Update(_x: body!.position.x, _y: body!.position.y, _rotate: rotate)
    }
    
    // ToDo ライブラリにする
    func DegreeToRadian(Degree : Double!)-> CGFloat{
        return CGFloat(Degree) / CGFloat(180.0 * M_1_PI)
    }
    
    func Reset() {
        body?.position.x = (GameManager.shared.scene?.frame.midX)!
        body?.position.y = (GameManager.shared.scene?.frame.minY)! + 250
        body?.run(SKAction.moveTo(x: (GameManager.shared.scene?.frame.midX)!, duration: 0))
        body?.run(SKAction.moveTo(y: (GameManager.shared.scene?.frame.minY)! + 250, duration: 0))
    }
}

