//
//  GameScene.swift
//  KamoooneShot for IOS
//
//  Created by Kazusa Kondo on 2022/01/16.
//
import SpriteKit
import UIKit

//ゲームシーン
@available(iOS 10.0, *) // IOS10.0以降を要求
class GameScene: SKScene {
    
    private final var ZIKIMAXBULLET: Int = 20
    private var bulletDuration: Int = 10
    private var bulletStartTime: Int = 0
    private var _tapText: SKLabelNode?
    private var isBulletTrigger: [Bool] = []
    private final var ENEMYMAX: Int = 20
    
    private var _title: SKSpriteNode?
    private var _ziki: SKSpriteNode?
    private var _zikiBullet: [SKSpriteNode] = []
    private var _enemy: [SKSpriteNode] = []
    //private var _enemyBullet: [SKSpriteNode] = []
    
    private var screenSize: CGSize?
    private var scale_x: CGFloat?
    private var scale_y: CGFloat?
    
    private var unHideAction : SKAction!
    private var rotateAction :SKAction!
    
    // 画面描画する際の初期化時に呼ばれる
    override func didMove(to view: SKView) {
        // Nodeを非表示させるアクションを作る.
        unHideAction = SKAction.hide()
        // 指定した回転値まで回転させるアクションを作る.
        rotateAction = SKAction.rotate( toAngle: DegreeToRadian(Degree: 180.0) , duration: 1)
        
        //画面サイズの取得
        screenSize = UIScreen.main.bounds.size
        scale_x = screenSize?.width
        scale_y = screenSize?.height
        
        //背景画像のノードを作成する。
        let bgNode = SKSpriteNode(imageNamed: "bg")
        //背景画像の位置をシーンの中央にする。
        bgNode.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        self.addChild(bgNode)
        
        // テキストのノードを作成する。
        _tapText = SKLabelNode(fontNamed: "American Typewriter Bold")
        _tapText!.text = "タップしてスタート！"
        _tapText!.fontSize = 20
        // 表示位置を画面中央
        _tapText!.position = CGPoint(x: self.frame.midX, y: self.frame.midY);
        self.addChild(_tapText!)
        
        // 自機弾の生成
        for _ in 0..<ZIKIMAXBULLET {
            isBulletTrigger.append(false)
            _zikiBullet.append(SKSpriteNode(imageNamed: "orange.png"))
        }
        
        //自機の生成
        _ziki = SKSpriteNode(imageNamed: "ziki.png")
        _ziki!.position = CGPoint(x: self.frame.midX, y: self.frame.minY+150)
        self.addChild(_ziki!)
        
        // エネミーの生成
        for i in 0..<ENEMYMAX {
            _enemy.append(SKSpriteNode(imageNamed: "enemy.png"))
            _enemy[i].position = CGPoint(x: CGFloat.random(in: self.frame.minX+25..<self.frame.maxX-25), y: CGFloat.random(in: self.frame.minY+150..<self.frame.maxY))
            _enemy[i].zRotation = DegreeToRadian(Degree: 180)
            self.addChild(_enemy[i])
        }
    }
    
    //タッチ時に呼ばれる
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        // タップしてスタートの文字を削除
        _tapText!.run(unHideAction)
        
        // タップした位置に自機を移動
        let touch = touches.first!;
        let pos = touch.location(in: self)
        _ziki?.run(SKAction.moveTo(x: pos.x, duration: 0.2))
        _ziki?.run(SKAction.moveTo(y: pos.y, duration: 0.2))
    }
    
    //タッチ移動時に呼ばれる
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
    }
    
    //ノードのアクションの処理後に呼ばれる
    override func didEvaluateActions() {
        // 回転処理
        //_enemy[i].run(rotateAction)
        
        // エネミー移動処理
        for i in 0..<ENEMYMAX {
            //_enemy[i].position.y -= 1
        }
        
        // 弾発射前処理
        for i in 0..<ZIKIMAXBULLET {
            if !isBulletTrigger[i] && bulletStartTime > bulletDuration {
                isBulletTrigger[i] = true
                // ToDo 画面ごとのサイズ
                _zikiBullet[i].size = CGSize(width: 10, height: 10)
                _zikiBullet[i].position = CGPoint(x: _ziki!.position.x, y: _ziki!.position.y)
                self.addChild(_zikiBullet[i])
                bulletStartTime = 0
                break
            }
        }
        
        // 弾移動処理
        for i in 0..<ZIKIMAXBULLET {
            if isBulletTrigger[i] {
                // 弾発射処理
                _zikiBullet[i].position.y += 3
                _zikiBullet[i].run(SKAction.moveTo(y: _zikiBullet[i].position.y, duration: 0))
                
                if _zikiBullet[i].position.y >= self.frame.maxY {
                    isBulletTrigger[i] = false
                    _zikiBullet[i].removeFromParent()
                }
                
            }
        }
        // 弾発射インタバル
        if bulletStartTime <= 10{
            bulletStartTime+=1
        }
        
        
        // 当たり判定処理
        Collision.CollisionJudge()
    }
}

extension SKScene{
    func DegreeToRadian(Degree : Double!)-> CGFloat{
        return CGFloat(Degree) / CGFloat(180.0 * M_1_PI)
    }
}


