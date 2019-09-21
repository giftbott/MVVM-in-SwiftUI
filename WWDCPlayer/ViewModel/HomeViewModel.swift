//
//  HomeViewModel.swift
//  WWDCPlayer
//
//  Created by Giftbot on 2019/09/16.
//  Copyright © 2019 Giftbot. All rights reserved.
//

import Foundation

final class HomeViewModel: ObservableObject {
 
  // MARK: UI <- ViewModel  (1-way Data Binding)

  @Published var currentVideo: VideoViewModel?
  
  private(set) lazy var videoListViewModel: VideoListViewModel = {
    VideoListViewModel(
      videos: app.videos.map(VideoViewModel.init),
      stateObserving: .currentVideo({ [weak self] in
        self?.currentVideo = $0
      })
    )
  }()
  let appTitle: String
  
  
  // MARK: Private
  
  private let app: AppModel
  
  
  // MARK: Init
  
  init(appModel: AppModel) {
    self.app = appModel
    
    self.appTitle = "WWDC Player"
  }
}
