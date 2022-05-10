//
//  SoundPlayer.swift
//  TreasureGame
//
//  Created by 尾崎拓 on 2022/05/10.
//

import UIKit
import AVFoundation

class SoundPlayer: NSObject {

    let music_data=NSDataAsset(name: "picoSound")!.data   // 音源の指定
    let clearSound = NSDataAsset(name: "clearSound")!.data
    var music_player:AVAudioPlayer!

    // 音楽を再生
    func musicPlayer(playSpeed : Float){

        do{
            music_player=try AVAudioPlayer(data:music_data)   // 音楽を指定
            music_player.numberOfLoops = -1
            //rateの変更を許可する。
           music_player.enableRate = true
            
           //2倍速にする。
           music_player.rate = playSpeed
            
            music_player.play()   // 音楽再生

        }catch{
            print("エラー発生.音を流せません")
        }

    }
    func clearSoundPlayer(){

        do{
            music_player=try AVAudioPlayer(data:clearSound)   // 音楽を指定

            music_player.play()   // 音楽再生

        }catch{
            print("エラー発生.音を流せません")
        }

    }

    // 音楽を停止
    func stopAllMusic (){
        music_player?.stop()
    }
}
