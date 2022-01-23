//
//  GameViewController.swift
//  KamoooneShot for IOS
//
//  Created by Kazusa Kondo on 2022/01/16.
//

import UIKit
import SpriteKit

//ゲームビューコントローラ
@available(iOS 10.0, *)
class GameViewController: UIViewController {
    
    //ロード完了時に呼ばれる
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //スプライトキットのビューの設定
        let skView = self.view as! SKView
        skView.showsFPS = false       //FPSの表示
        skView.showsNodeCount = false //ノード数の表示
        
        //シーンの追加(サイズは背景のテクスチャサイズに合わせる)
        GameManager.scene = TitleScene(size: GameManager.backGroundSize)
        GameManager.scene!.scaleMode = SKSceneScaleMode.aspectFill
        skView.presentScene(GameManager.scene)
    }
}
