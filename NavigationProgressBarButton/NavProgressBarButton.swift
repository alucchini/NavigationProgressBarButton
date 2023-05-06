//
//  ContentView.swift
//  NavigationProgressBarButton
//
//  Created by Antoine Lucchini on 23/03/2023.
//

import SwiftUI

struct NavProgressBarButton: View {

    let title: String
    @Binding var progress: Float
    @Binding var isActivate: Bool

    let action: () -> Void

    var body: some View {
        Button {
            action()
        } label: {
            HStack {
                Spacer()
                Text(title)
                    .foregroundColor(Color.white)
                    .padding(20)
                Spacer()
            }
            .background {
                if !isActivate {
                    VStack {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color.purple)
                    }
                } else {
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color.purple.opacity(0.2))
                        GeometryReader { geo in
                            RoundedRectangle(cornerRadius: 2)
                                .fill(Color.purple)
                                .frame(width: geo.size.width * CGFloat(progress))
                                .animation(.linear(duration: 0.01), value: progress)
                        }
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                    }
                }
            }
        }
        .buttonStyle(.plain)
    }
}
