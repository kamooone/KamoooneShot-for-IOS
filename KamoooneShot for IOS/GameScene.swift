//
//  GameScene.swift
//  KamoooneShot for IOS
//
//  Created by Kazusa Kondo on 2022/01/16.
//
import SpriteKit
import Foundation
import SpriteKit
import AVFoundation

//ゲームシーン
@available(iOS 10.0, *) // IOS10.0以降を要求
class GameScene: SKScene, AVAudioPlayerDelegate{
    var playerAudio:AVAudioPlayer!
    
    // オブジェクトインスタンス生成
    private var backGround = BackGround()
    private var player = Player()
    private var enemy = Enemy()
    private var gameUI = GameUI()
    
    private var explosion: [SKTexture] = []
    // BGM
    let url = Bundle.main.bundleURL.appendingPathComponent("bgm1.wav")
    // SE
    let action = SKAction.playSoundFileNamed("hit", waitForCompletion: true)
    
    // 画面描画する際の初期化時に呼ばれる
    override func didMove(to view: SKView) {
        // 初期化
        backGround.Init()
        player.Init()
        enemy.Init()
        gameUI.Init()
        
        do {
            playerAudio = try AVAudioPlayer(contentsOf: url)
            playerAudio.delegate = self
            playerAudio.prepareToPlay()
            //音楽を再生する。
            playerAudio.play()
        } catch {
            print(error)
        }
        
        // テクスチャアトラスのフォルダ名を指定
        let atlas = SKTextureAtlas(named: "explosion")
        //human0~human3を配列textureに追加
        for i in 0...15{
            explosion.append(atlas.textureNamed("explosion" + String(i+1)))
        }
    }
    
    //タッチ時に呼ばれる
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        // タップした位置の座標を取得
        let touch = touches.first!;
        GameManager.touchPos = touch.location(in: GameManager.scene!)
        // 移動
        player.Move()
        gameUI.Update()
        
        for touch in touches {
            _ = touch.location(in: self)
            let sprite = SKSpriteNode(texture: explosion[0])
            sprite.position = CGPoint(x: 100, y: 200)
            //パラパラアニメのアクション
            let animation = SKAction.animate(with: explosion, timePerFrame: 0.125)
            //画面の左方向に80pixcel/secの速さで動かす
            sprite.run(SKAction.repeatForever(animation))
            
            GameManager.scene!.addChild(sprite)
        }
    }
    
    //タッチ移動時に呼ばれる
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        // タップした位置に自機を移動
        let touch = touches.first!;
        GameManager.touchPos = touch.location(in: GameManager.scene!)
        // 移動
        player.Move()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        // 移動
        // タップした位置に自機を移動
        let touch = touches.first!;
        GameManager.touchPos = touch.location(in: GameManager.scene!)
        player.Move()
    }
    
    //ノードのアクションの処理後に呼ばれる
    override func didEvaluateActions() {
        // 回転処理
        //_enemy[i].run(rotateAction)
        
        player.Update()
        enemy.Update()
        self.run(action)
        // 当たり判定処理
        Collision.CollisionJudge()
        self.run(action)
    }
}



