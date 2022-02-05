//
//  Sount.swift
//  KamoooneShot for IOS
//
//  Created by Kazusa Kondo on 2022/02/05.
//

import Foundation
import SpriteKit
import AVFoundation

final public class Sound {
    var playerAudio:AVAudioPlayer!
    private let bgm = Bundle.main.bundleURL.appendingPathComponent("bgm1.wav")
    private let seHit = SKAction.playSoundFileNamed("hit", waitForCompletion: true)
    //private static let soundObj = self()
    
    func Init() {
        do {
            playerAudio = try AVAudioPlayer(contentsOf: bgm)
            playerAudio.play()
            //playerAudio.stop()
        } catch {
            print(error)
        }
    }
    
    func PlaySE() {
        GameManager.scene!.run(seHit)
    }
}
