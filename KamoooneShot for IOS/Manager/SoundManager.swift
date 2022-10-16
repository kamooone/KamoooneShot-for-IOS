//
//  Sound.swift
//  KamoooneShot for IOS
//
//  Created by Kazusa Kondo on 2022/10/16.
//

import Foundation
import AVFoundation
import SpriteKit

class SoundManager {
    // 他のクラスで使用できるようにstaticなインスタンスを生成しておく
    static let shared = SoundManager()
    
    var playerAudio:AVAudioPlayer!
    let bgm = Bundle.main.bundleURL.appendingPathComponent("bgm1.wav")
    let seHit = SKAction.playSoundFileNamed("hit", waitForCompletion: true)
    
    init() {
    }

    func PlayBGM() {
        do {
            playerAudio = try AVAudioPlayer(contentsOf: bgm)
            playerAudio.play()
            //playerAudio.stop()
        } catch {
            print(error)
        }
    }
    
    func PlaySE() {
        GameManager.shared.scene!.run(seHit)
    }
}
