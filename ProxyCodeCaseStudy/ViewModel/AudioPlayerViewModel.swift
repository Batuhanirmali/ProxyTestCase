//
//  AudioPlayerViewModel.swift
//  ProxyCodeCaseStudy
//
//  Created by Talha Batuhan Irmalı on 3.04.2025.
//

import AVFoundation
import Combine

class AudioPlayerViewModel: ObservableObject {
    private var player: AVPlayer?
    private var timeObserverToken: Any?
    @Published var isPlaying = false
    @Published var currentTime: Double = 0.0

    func togglePlayPause(url: URL) {
        if player == nil {
            player = AVPlayer(url: url)
            addPeriodicTimeObserver()
        }

        if isPlaying {
            player?.pause()
        } else {
            player?.play()
        }

        isPlaying.toggle()
    }

    private func addPeriodicTimeObserver() {
        guard let player = player else { return }

        let interval = CMTime(seconds: 0.1, preferredTimescale: CMTimeScale(NSEC_PER_SEC))
        timeObserverToken = player.addPeriodicTimeObserver(forInterval: interval, queue: .main) { [weak self] time in
            self?.currentTime = time.seconds
        }
    }
    
    func seek(by seconds: Double) {
        guard let player = player else { return }
        let currentTime = player.currentTime().seconds
        let newTime = max(currentTime + seconds, 0)
        let time = CMTime(seconds: newTime, preferredTimescale: 600)
        player.seek(to: time)
    }

    deinit {
        if let token = timeObserverToken {
            player?.removeTimeObserver(token)
        }
    }
}
