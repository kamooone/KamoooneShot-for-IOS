//
//  File.swift
//  KamoooneShot for IOS
//
//  Created by Kazusa Kondo on 2022/01/16.
//

import Foundation
import SpriteKit
import UIKit

class TitleScene: SKScene{
    
    // 画面を描画する際の初期化時に呼ばれる
    override func didMove(to view: SKView) {
        //背景画像のノードを作成する。
        let bgNode = SKSpriteNode(imageNamed: "bg")
        //背景画像のサイズをシーンと同じにする。
        bgNode.size = self.frame.size
        //背景画像の位置をシーンの中央にする。
        bgNode.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        self.addChild(bgNode)
        
        // テキストのノードを作成する。
        let label = SKLabelNode(fontNamed: "American Typewriter Bold")
        label.text = "KamoooneShot"
        label.position = CGPoint(x: self.frame.midX, y: self.frame.maxY - 150);
        self.addChild(label)
        
        // ランキングボタンを表示
        let rankingButtonLabel = SKLabelNode(fontNamed: "American Typewriter Bold")
        rankingButtonLabel.text = "RANKING"
        rankingButtonLabel.position = CGPoint(x: self.frame.midX, y: 240);
        rankingButtonLabel.fontSize = 30
        self.addChild(rankingButtonLabel)
        var circle = UIBezierPath(roundedRect: CGRect(x: 100, y: 400, width: 180, height: 40), cornerRadius: 10)
        let rankingButton = SKShapeNode(path: circle.cgPath, centered: true)
        rankingButton.position = CGPoint(x:self.frame.midX, y:250)
        rankingButton.name = "RANKING"
        addChild(rankingButton)
         
        // ゲームスタートボタンを表示
        let startButtonLabel = SKLabelNode(fontNamed: "American Typewriter Bold")
        startButtonLabel.text = "START"
        startButtonLabel.position = CGPoint(x: self.frame.midX, y: 140);
        startButtonLabel.fontSize = 30
        self.addChild(startButtonLabel)
        circle = UIBezierPath(roundedRect: CGRect(x: 100, y: 400, width: 180, height: 40), cornerRadius: 10)
        let startButton = SKShapeNode(path: circle.cgPath, centered: true)
        startButton.position = CGPoint(x:self.frame.midX, y:150)
        startButton.name = "START"
        addChild(startButton)
        
        
        
        
        // WebAPIレスポンステスト
//        let url: URL = URL(string: "http://kamooone.sakura.ne.jp/GetRanking.php")!
//        let task: URLSessionTask = URLSession.shared.dataTask(with: url, completionHandler: {(data, response, error) in
//            do{
//                let couponData = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments) as! [[String: Any]]
//                print(couponData) // Jsonの中身を表示
//                print("=============================")
//            }
//            catch {
//                print(error)
//            }
//        })
//        task.resume()
        
        
        // WebAPIリクエストテスト
//        let url = URL(string: "http://kamooone.sakura.ne.jp/SetRanking.php")!
//        var request = URLRequest(url: url)
//        request.httpMethod = "POST"
//        let parameters = [["name": "テスト名前1", "score": "765"]]
//
//        request.httpBody = try! JSONSerialization.data(withJSONObject: parameters)
//        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//
//        let task = URLSession.shared.dataTask(with: request) { data, response, error in
//            guard let data = data, error == nil else {
//                // WebApi処理が失敗した時に呼ばれる。
//                print(error?.localizedDescription ?? "No data")
//                return
//            }
//
//            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
//            if let responseJSON = responseJSON as? [String: Any] {
//                // WebAPIのレスポンス
//                print(responseJSON)
//            }
//        }
//        task.resume()
    }
    
    // 画面をタッチされた時に呼ばれる
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        // タッチしたボタンによって処理を分ける
        for touch: AnyObject in touches {
            let location = touch.location(in: self)
            let node = self.atPoint(location)
            
            if (node.name == "RANKING") {
                
            } else if (node.name == "START") {
                GameManager.shared.scene = GameScene(size: self.scene!.size)
                GameManager.shared.scene?.scaleMode = SKSceneScaleMode.aspectFill
                self.view!.presentScene(GameManager.shared.scene)
            }
        }
    }
}
