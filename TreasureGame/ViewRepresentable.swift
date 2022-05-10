//
//  ViewRepresentable.swift
//  TreasureGame
//
//  Created by 尾崎拓 on 2022/05/09.
//

import Foundation
import SwiftUI

struct ViewRepresentable: UIViewRepresentable {

   class Coordinator: NSObject {

      @Binding var point: CGPoint

      init(point: Binding<CGPoint>) {
         _point = point
      }

      @objc func longTapped(_ gesture: UILongPressGestureRecognizer) {
         // stateは適当なイベントで、
         if gesture.state == .began {
            point = gesture.location(in: gesture.view)
         }
      }
   }

   /// タップされた座標
   @Binding var point: CGPoint

   func makeUIView(context: Context) -> UIView {
      let view = UIView(frame: .zero)

      let gesture = UILongPressGestureRecognizer(
         target: context.coordinator,
         action: #selector(Coordinator.longTapped(_:))
      )
      view.addGestureRecognizer(gesture)
      return view
   }

   func makeCoordinator() -> ViewRepresentable.Coordinator {
      Coordinator(point: $point)
   }

   func updateUIView(_ uiView: UIView, context: Context) {}

}
