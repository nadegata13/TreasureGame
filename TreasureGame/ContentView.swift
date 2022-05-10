//
//  ContentView.swift
//  TreasureGame
//
//  Created by 尾崎拓 on 2022/05/09.
//

import SwiftUI

struct ContentView: View {
    //トレジャーハンターの画像の場所
    @ObservedObject var viewModel1  = viewModel()
    @State var position : CGPoint = CGPoint(x: 200, y: 300)
    @State var isFirstPlay = false
    @State var isShowImage = false
    
    
    var body: some View {
        

        GeometryReader { geometry in
            ZStack{
//                Image("background")
//                    .aspectRatio(contentMode: .fill)
                Rectangle()
                    .foregroundColor(Color("groundColor"))
                //クリアしたら宝箱が現れるようにする
                if(viewModel1.isClearGame){
                    Image("treasure")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 300.0)
                }
                VStack{
                    Button{
                        isFirstPlay = true
                        isShowImage = true
                        //トレジャーハンターの位置を画面の中心に設定する
                        position = CGPoint(x: geometry.size.width / 2, y: geometry.size.height / 2)
                        viewModel1.reset()

                    } label: {
                        ZStack{
                            Rectangle()
                                .frame(width: geometry.size.width / 4
                                       , height:50)
                                .foregroundColor(Color.red)
                                .cornerRadius(10)
                                .shadow(radius: 5, x: 3, y: 5)
                            Text("始める")
                                .foregroundColor(Color.white)
                                .bold()
                                
                        }
                    }
                    .position(x: geometry.size.width / 2, y: 60)
                    Spacer()
                    
                }
        }
                //掘ったところのヒントが出る
                Text(viewModel1.resultText)
                .bold()
                    .position(x: geometry.size.width / 2, y: geometry.size.height / 2 - 100)
                    .font(.title)
                    .foregroundColor(Color.white)
                if(isShowImage){
                    Image("treasureHunter")
                        .resizable()
                        .scaledToFit()
                    //サイズを画面の10分の1にする
                        .frame(width: geometry.size.width / 10, height: geometry.size.height)
                        .position(x: position.x , y: position.y)
                        .gesture(DragGesture().onChanged { value in
                                if(!viewModel1.isClearGame){
                                    
                            position = CGPoint(
                                x: value.startLocation.x + value.translation.width, y: value.startLocation.y + value.translation.height)
                                }

                        }
                                    .onEnded { value in
                            
                            //初回のみランダムな座標を生成する
                            if(isFirstPlay){
                                viewModel1.randomCGSize(width: geometry.size.width, height: geometry.size.height)
                            }
                            isFirstPlay = false
                            
                            if(!viewModel1.isClearGame){
                                //トレジャーハンターとアタリの座標を比較する
                                viewModel1.compareToTreasure(x: position.x, y: position.y)
                            }

                        }
                                 
                        )
                }

            }
    }
        
        
        
        
    }


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
