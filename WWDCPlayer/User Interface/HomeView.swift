//
//  HomeView.swift
//  WWDCPlayer
//
//  Created by Giftbot on 2019/09/13.
//  Copyright © 2019 Giftbot. All rights reserved.
//

import SwiftUI

struct HomeView: View {
  @ObservedObject private var model: HomeViewModel
  
  init(viewModel model: HomeViewModel) {
    self.model = model
  }
  
  // MARK: Body
  
  var body: some View {
    VStack {
      appTitle
      
      AVPlayerView(url: model.currentVideo?.url)
      videoInfo
      divider
      
      VideoListView(viewModel: model.videoListViewModel)
    }
  }
}


// MARK: - Body Content

extension HomeView {
  var appTitle: some View {
    Text(model.appTitle)
      .font(.largeTitle).fontWeight(.heavy)
      .padding(.top, 8)
      .background(LinearGradient(
        gradient: .init(colors: [.red, .yellow, .blue, .purple]),
        startPoint: .topLeading,
        endPoint: .bottomTrailing)
        .opacity(0.4).blur(radius: 25).shadow(radius: 25).scaleEffect(1.1))
  }
  
  var videoInfo: some View {
    Group {
      if model.currentVideo != nil {
        VideoRow(viewModel: model.currentVideo!, isVideoInfo: true)
          .padding(.horizontal)
      } else {
        Text("No Video")
      }
    }
  }
  
  var divider: some View {
    Rectangle()
      .fill(Color.primary.opacity(0.2))
      .frame(minWidth: 0, maxWidth: .infinity, maxHeight: 1)
  }
}


// MARK: - HomeView

#if DEBUG
struct HomeView_Previews : PreviewProvider {
  static var previews: some View {
    let appModel = AppModel()
    let viewModel = HomeViewModel(appModel: appModel)
    return HomeView(viewModel: viewModel)
  }
}
#endif
