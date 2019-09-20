//
//  VideoListView.swift
//  WWDCPlayer
//
//  Created by Giftbot on 2019/09/20.
//  Copyright © 2019 Giftbot. All rights reserved.
//

import SwiftUI

struct VideoListView: View {
  @ObservedObject private var model: VideoListViewModel
  
  init(viewModel model: VideoListViewModel) {
    self.model = model
  }
  
  // MARK: Body
  
  var body: some View {
    List {
      videoFilter
      videoList
    }
    .listStyle(GroupedListStyle())
  }
}

// MARK: - Body Content

extension VideoListView {
  var videoFilter: some View {
    Section(header: Text("Video Filter").fontWeight(.heavy)) {
      showFavoriteToggle
      platformSegmentedPicker
    }
  }
  
  var platformSegmentedPicker: some View {
    Picker("", selection: self.$model.specificPlatforms) {
      ForEach(model.allPlatforms, id: \.self) { platform in
        Text(platform).tag(platform)
      }
    }
    .pickerStyle(SegmentedPickerStyle())
  }
  
  var showFavoriteToggle: some View {
    Toggle(isOn: self.$model.showFavoriteOnly) {
      Text("Show Favorite Only")
    }
  }
  
  var videoList: some View {
    ForEach(self.model.weekday, id: \.self) { day in
      Section(header: Text(day.capitalized).fontWeight(.heavy)) {
        ForEach(self.model.videoGroup(by: day)) { video in
          VideoRow(viewModel: video)
            .contentShape(Rectangle())
            .onTapGesture { self.model.executeCommand(.selectVideo(video)) }
        }
      }
    }
  }
}


// MARK: - Previews

#if DEBUG
struct VideoListView_Previews : PreviewProvider {
  static var previews: some View {
    let videoModels = defaultVideos.map { VideoViewModel(video: $0) }
    let viewModel = VideoListViewModel(videos: videoModels, stateObserving: nil)
    return VideoListView(viewModel: viewModel)
  }
}
#endif
