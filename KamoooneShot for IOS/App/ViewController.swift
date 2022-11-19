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
class ViewController: UIViewController {
    
    //ロード完了時に呼ばれる
    override func viewDidLoad() {
        super.viewDidLoad()

        //スプライトキットのビューの設定
        let skView = self.view as! SKView
        //FPSの表示
        skView.showsFPS = false
        //ノード数の表示
        skView.showsNodeCount = false

        //シーンの追加(サイズは背景のテクスチャサイズに合わせる)
        GameManager.shared.scene = TitleScene(size: GameManager.shared.backGroundSize)
        GameManager.shared.scene?.scaleMode = SKSceneScaleMode.aspectFill
        skView.presentScene(GameManager.shared.scene)
        //skView.isMultipleTouchEnabled = false
    }
}
