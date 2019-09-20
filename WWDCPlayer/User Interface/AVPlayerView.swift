//
//  PlayerViewController.swift
//  WWDCPlayer
//
//  Created by Giftbot on 2019/09/13.
//  Copyright © 2019 Giftbot. All rights reserved.
//

import AVKit
import SwiftUI

struct AVPlayerView: UIViewControllerRepresentable {
  private let player = AVPlayer()
  let url: URL?
  
  func makeUIViewController(context: Context) -> AVPlayerViewController {
    let playerVC = AVPlayerViewController()
    playerVC.player = self.player
    return playerVC
  }
  
  func updateUIViewController(_ uiViewController: AVPlayerViewController, context: Context) {
    guard let url = url,
      let player = uiViewController.player
      else { return }
    
    self.reset(player: player)
    self.playVideoURL(player: player, url: url)
  }
  
  private func reset(player: AVPlayer) {
    player.pause()
    player.replaceCurrentItem(with: nil)
  }
  
  private func playVideoURL(player: AVPlayer, url: URL) {
    let item = AVPlayerItem(url: url)
    player.replaceCurrentItem(with: item)
    player.play()
  }
}
