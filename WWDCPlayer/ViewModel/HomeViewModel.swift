//
//  HomeViewModel.swift
//  WWDCPlayer
//
//  Created by Giftbot on 2019/09/16.
//  Copyright © 2019 Giftbot. All rights reserved.
//

import Foundation

final class HomeViewModel: ObservableObject {
  private let app: AppModel
  init(appModel: AppModel) {
    self.app = appModel
  }
 
  // MARK: UI <- ViewModel  (1-way Data Binding)

  private(set) lazy var videoListViewModel: VideoListViewModel = {
    VideoListViewModel(
      videos: app.videos.map(VideoViewModel.init),
      stateObserving: .currentVideo({ [weak self] in
        self?.currentVideo = $0
      })
    )
  }()

  var appTitle: String {
    "WWDC Player"
  }
  
  @Published var currentVideo: VideoViewModel?
}
