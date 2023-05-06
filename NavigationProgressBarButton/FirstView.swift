//
//  FirstView.swift
//  NavigationProgressBarButton
//
//  Created by Antoine Lucchini on 06/05/2023.
//

import SwiftUI

struct FirstView: View {

    @State private var progress: Float = 0
    @State private var isActive = false
    @State private var pushNewView = false

    let timer = Timer.publish(every: 0.01, on: .main, in: .common).autoconnect()
    @State private var duration: Float = 0

    var body: some View {
        NavigationView {
            VStack{
                Text("First View")
                NavigationLink("", isActive: $pushNewView) {
                    SecondView()
                }
                .opacity(0.0)

                NavProgressBarButton(title: "Next View", progress: $progress, isActivate: $isActive, action: {
                    self.isActive = true
                })
            }
            .onReceive(timer) { _ in
                guard isActive else { return }
                if duration <= 3.6 {
                    duration += 0.01
                } else {
                    pushNewView = true
                }
            }
            .onChange(of: duration) { _ in
                progress = Float(duration) / Float(3.6)
            }
        }
    }
}

struct FirstView_Previews: PreviewProvider {
    static var previews: some View {
        FirstView()
    }
}
