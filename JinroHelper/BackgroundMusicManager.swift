//
//  BackgroundMusicManager.swift
//  JinroHelper
//
//  Created by Ryo Eguchi on 2015/02/21.
//  Copyright (c) 2015年 Ryo Eguchi. All rights reserved.
//
import AVFoundation

class BackgroundMusicManager: NSObject, AVAudioPlayerDelegate {
    var player : AVAudioPlayer! = nil   // プレイヤー
    
    // 初期化処理
    override init() {
        super.init()
        // 音声ファイルパス取得
        let audioPath = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("コールドフィッシュ", ofType: "mp3")!)
        
        // プレイヤー準備
        player = AVAudioPlayer(contentsOfURL: audioPath, error: nil)
        player.delegate = self
        player.prepareToPlay()
    }
    
    // 再生／一時停止処理
    func playOrPause() {
        if (player.playing) {
            // 現在再生中なら一時停止
            player.pause()
        } else {
            // 現在再生していないなら再生
            player.play()
        }
    }
    
    // 再生終了時処理
    func audioPlayerDidFinishPlaying(player: AVAudioPlayer!, successfully flag: Bool) {
        player.stop()
        
        // 再生終了を通知
        let noti = NSNotification(name: "stop", object: self)
        NSNotificationCenter.defaultCenter().postNotification(noti)
    }
}