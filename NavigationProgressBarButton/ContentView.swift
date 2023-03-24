//
//  ContentView.swift
//  NavigationProgressBarButton
//
//  Created by Antoine Lucchini on 23/03/2023.
//

import SwiftUI

struct ContentView: View {
    @State var advancment = 0
    @State var isActive = false
    @State var pushNewView = false
    let timer = Timer.publish(every: 0.01, on: .main, in: .common).autoconnect()


    var body: some View {
        NavigationView {
            VStack {
                if !isActive {
                    Button("New View", action: {
                        isActive = true
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3.6) {
                            self.pushNewView = true
                        }
                    })
                    .background(
                        NavigationLink("", isActive: $pushNewView) {
                            EmptyView()
                        }
                    )
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
                    .padding(20)
                    .foregroundColor(Color.white)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.purple.opacity(0.2), lineWidth: 4)
                    )
                    .background(Color.purple)
                    .cornerRadius(20)
                } else {
                    ZStack {
                        Path { path in
                            path.move(to: CGPoint(x: 0, y: 0))
                            path.addLine(to: CGPoint(x: 360, y: 0))
                            path.addLine(to: CGPoint(x: 360, y: 60))
                            path.addLine(to: CGPoint(x: 0, y: 60))
                        }
                        .foregroundColor(.purple.opacity(0.2))
                        .frame(maxHeight: 60)
                        Path { path in
                            path.move(to: CGPoint(x: 0, y: 0))
                            path.addLine(to: CGPoint(x: advancment, y: 0))
                            path.addLine(to: CGPoint(x: advancment, y: 60))
                            path.addLine(to: CGPoint(x: 0, y: 60))
                        }
                        .foregroundColor(.purple)
                        .frame(maxHeight: 60)
                        .onReceive(timer) { _ in
                            if advancment < 360 {
                                advancment += 1
                            } else {
                                isActive = false
                                advancment = 0
                            }
                        }
                        Text("New View")
                            .foregroundColor(.white)
                    }
                    .cornerRadius(20)
                }
            }
            .padding(15)
        }
    }
}
