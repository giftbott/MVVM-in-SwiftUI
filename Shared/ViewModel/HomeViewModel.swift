//
//  HomeViewModel.swift
//  WWDCPlayer
//
//  Created by Giftbot on 2019/09/16.
//  Copyright © 2019 Giftbot. All rights reserved.
//

import SwiftUI

final class HomeViewModel: ObservableObject {

  @Published var state: State
  let videoService: VideoService

  init(state: State = .init(), videoService: VideoService = VideoDataService()) {
    self.state = state
    self.videoService = videoService
    Task { await self.action(.initialize) }
  }

  // MARK: UI <- ViewModel

  struct State {
    let platforms: [String] = ["All"] + Platform.allCases.map(\.rawValue)

    var videoRowViewModels: [VideoRowViewModel] = []
    var chosenVideo: Video?
    var chosenPlatform: Platform?
    var showFavoriteOnly: Bool = false
  }

  // MARK: UI -> ViewModel

  enum Action {
    case initialize
    case onAppear
    case chosenVideo(_ video: Video)
  }

  @MainActor func action(_ action: Action) async {
    switch action {
    case .initialize:
      let videos = await videoService.fetchVideos()
      let viewModels = videos.map {
        VideoRowViewModel(state: .init(video: $0), videoService: videoService)
      }
      state.videoRowViewModels = viewModels
    case .onAppear:
      break
    case let .chosenVideo(video):
      guard state.chosenVideo != video else { return }
      state.chosenVideo = video
    }
  }
}

extension HomeViewModel {
  func videoURL(of video: Video?) -> URL? {
    guard let urlString = video?.urlString else { return nil }
    return URL(string: urlString)
  }

  func videoViewModelGrouped(by weekday: WeekDay) -> [VideoRowViewModel] {
    state.videoRowViewModels.lazy
      .filter({ $0.state.video.weekDay == weekday })
      .filter({ self.state.showFavoriteOnly ? $0.state.video.isFavorite : true })
      .filter({
        guard let platform = self.state.chosenPlatform else { return true }
        return $0.state.video.platforms.contains(platform)
      })
  }

  func viewModel(for video: Video) -> VideoRowViewModel {
    state.videoRowViewModels.first(where: { $0.state.video == video })
    ?? VideoRowViewModel(state: .init(video: video), videoService: videoService)
  }
}
