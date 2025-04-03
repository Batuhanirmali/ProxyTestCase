//
//  ListenOverlayView.swift
//  ProxyCodeCaseStudy
//
//  Created by Talha Batuhan Irmalı on 3.04.2025.
//

import SwiftUI

struct ListenOverlayView: View {
    let audioURL: URL
    @ObservedObject var player: AudioPlayerViewModel
    @ObservedObject var viewModel: BookDetailViewModel

    var body: some View {
        VStack(spacing: 24) {

            HStack(spacing: 24) {
                Button(action: {
                    if viewModel.currentChapterIndex > 0 {
                        viewModel.currentChapterIndex -= 1
                        print("⏮ Skipped to chapter \(viewModel.currentChapterIndex)")
                    }
                }) {
                    Image("skip-back-1")
                        .resizable()
                        .frame(width: 28, height: 28)
                        .scaledToFit()
                        .foregroundColor(.black)
                }

                Button(action: {
                    player.seek(by: -15)
                }) {
                    Image("history-alt-2")
                        .resizable()
                        .frame(width: 36, height: 36)
                        .scaledToFit()
                        .foregroundColor(.black)
                }

                Button(action: {
                    print("Play/Pause button tapped")
                    player.togglePlayPause(url: audioURL)
                }) {
                    Image(systemName: player.isPlaying ? "pause.circle.fill" : "play.circle.fill")
                        .resizable()
                        .frame(width: 60, height: 60)
                        .scaledToFit()
                        .foregroundColor(Color(hex: "#F7C663"))
                }

                Button(action: {
                    player.seek(by: 15)
                }) {
                    Image("history-alt-1")
                        .resizable()
                        .frame(width: 36, height: 36)
                        .scaledToFit()
                        .foregroundColor(.black)
                }

                Button(action: {
                    if viewModel.currentChapterIndex < viewModel.chapters.count - 1 {
                        viewModel.currentChapterIndex += 1
                        print("⏭ Skipped to chapter \(viewModel.currentChapterIndex)")
                    }
                }) {
                    Image("skip-back-2")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 28, height: 28)
                        .foregroundColor(.black)
                }
            }

        }
        .onAppear {
            print("🔊 ListenOverlayView appeared")
            print("Audio URL: \(audioURL)")
        }
        .padding()
    }
}
