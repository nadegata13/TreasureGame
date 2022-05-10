//
//  viewModel.swift
//  TreasureGame
//
//  Created by 尾崎拓 on 2022/05/09.
//

import Foundation
import SwiftUI
class viewModel : ObservableObject {
    @Published var randomCGSize = (0.0, 0.0)
    @Published var resultText = "トレジャーハンターを動かせ！"
    @Published var isClearGame = false
    let soundPlayer = SoundPlayer()
    
    func randomCGSize(width: Double, height: Double){
        //ランダムの座標を決める
        let randomWidth =  Double.random(in: 0...width)
        let randomHeight = Double.random(in: 0...height)
        //小数点を切り捨てた値を入れる
        randomCGSize = (round(randomWidth ), round(randomHeight ))
    }
    func compareToTreasure(x: Double, y: Double) {
        print(round(x), round(y))
        print(randomCGSize)
        //小数点まで含めると鬼畜すぎたので切り捨てをする
        // 絶対値を取る
        let absValueOfX = abs(randomCGSize.0 - round(x))
        let absValueOfY = abs(randomCGSize.1 - round(y))
        
        if absValueOfX <= 1 && absValueOfY <= 1{
            resultText = "神に感謝"
            soundPlayer.stopAllMusic()
            soundPlayer.clearSoundPlayer()
            isClearGame = true
        } else if absValueOfX < 3  && absValueOfY < 3 {
            resultText = "ドル箱持ってこい！"
            soundPlayer.stopAllMusic()
            soundPlayer.musicPlayer(playSpeed: 1.5)
        } else if absValueOfX < 10 && absValueOfY < 10 {
            resultText = "この反応は！"
            
            soundPlayer.stopAllMusic()
            soundPlayer.musicPlayer(playSpeed: 1.0)
        }else  if   absValueOfX < 40 && absValueOfY < 40{
            resultText = "きてる"
            soundPlayer.stopAllMusic()
            soundPlayer.musicPlayer(playSpeed: 0.7)
            
        }else if absValueOfX < 70 && absValueOfY < 70{
            resultText = "なんか当たりそう"
            soundPlayer.stopAllMusic()
            soundPlayer.musicPlayer(playSpeed: 0.5)
        } else {
            resultText = "ハズレやなぁ"
            soundPlayer.stopAllMusic()
        }

    }
    func reset() {
    
        randomCGSize = (0.0, 0.0)
        resultText = "トレジャーハンターを動かせ！"
        soundPlayer.stopAllMusic()
        isClearGame = false
    }
}
