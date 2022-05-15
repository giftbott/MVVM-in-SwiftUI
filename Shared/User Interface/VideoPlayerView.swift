//
//  VideoPlayerView.swift
//  WWDCPlayer
//
//  Created by Giftbot on 2019/09/13.
//  Copyright © 2019 Giftbot. All rights reserved.
//

import AVKit
import SwiftUI

#if os(iOS)
typealias ViewRepresentable = UIViewControllerRepresentable
#else
typealias ViewRepresentable = NSViewRepresentable
#endif

struct VideoPlayerView: ViewRepresentable {
  private let player = AVPlayer()
  let url: URL?

#if os(iOS)
  func makeUIViewController(context: Context) -> AVPlayerViewController {
    let playerVC = AVPlayerViewController()
    playerVC.player = self.player
    return playerVC
  }

  func updateUIViewController(_ viewController: AVPlayerViewController, context: Context) {
    guard let url = url, let player = viewController.player else { return }
    if let currentURL = itemURL(of: player), currentURL == url {
      return
    }

    self.reset(player: player)
    self.playVideoURL(player: player, url: url)
  }
#else
  func makeNSView(context: Context) -> AVPlayerView {
    let playerView = AVPlayerView()
    playerView.player = self.player
    playerView.showsFullScreenToggleButton = true
    return playerView
  }

  func updateNSView(_ nsView: AVPlayerView, context: Context) {
    guard let url = url, let player = nsView.player else { return }
    if let currentURL = itemURL(of: player), currentURL == url {
      return
    }

    self.reset(player: player)
    self.playVideoURL(player: player, url: url)
  }
#endif

  private func reset(player: AVPlayer) {
    player.pause()
    player.replaceCurrentItem(with: nil)
  }

  private func playVideoURL(player: AVPlayer, url: URL) {
    let item = AVPlayerItem(url: url)
    player.replaceCurrentItem(with: item)
    player.play()
  }

  private func itemURL(of player: AVPlayer) -> URL? {
    guard let itemAsset = player.currentItem?.asset as? AVURLAsset else { return nil }
    return itemAsset.url
  }
}

// MARK: - Previews

struct AVPlayerView_Previews: PreviewProvider {
  static var previews: some View {
    VStack {
      VideoPlayerView(url: defaultVideos[0].url)
      VideoPlayerView(url: defaultVideos[1].url)
    }
  }
}
