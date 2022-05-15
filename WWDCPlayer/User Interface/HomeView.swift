//
//  HomeView.swift
//  WWDCPlayer
//
//  Created by Giftbot on 2019/09/13.
//  Copyright © 2019 Giftbot. All rights reserved.
//

import SwiftUI

struct HomeView: View {

  @StateObject var model: HomeViewModel = .init()

  var body: some View {
    VStack(spacing: 0) {
      appTitle
        .padding(.bottom, 4)

      VideoPlayerView(url: model.state.chosenVideo?.url)
        .showIf(model.state.chosenVideo != nil)

      videoInfo
      videoSelector
    }
    .task { await model.action(.onAppear) }
  }
}

fileprivate extension HomeView {
  var appTitle: some View {
    Text("WWDC Player")
      .font(.largeTitle)
      .fontWeight(.heavy)
      .background(
        LinearGradient(
          gradient: .init(colors: [.red, .yellow, .blue, .purple]),
          startPoint: .topLeading,
          endPoint: .bottomTrailing
        )
        .opacity(0.4)
        .blur(radius: 25)
        .shadow(radius: 25)
        .scaleEffect(1.1)
      )
  }

  @ViewBuilder
  var videoInfo: some View {
    if let video = model.state.chosenVideo {
      VStack(spacing: 0) {
        VideoRow(model: model.viewModel(for: video), isVideoInfoView: true)
          .padding(.horizontal)
          .padding(.vertical, 6)

        Rectangle()
          .fill(Color.primary.opacity(0.2))
          .frame(maxWidth: .infinity)
          .frame(height: 1)
      }
    }
  }

  var videoSelector: some View {
    List {
      videoFilter

      ForEach(WeekDay.allCases, id: \.self) {
        videoRows(groupedBy: $0)
      }
    }
    .listStyle(.grouped)
  }

  var videoFilter: some View {
    Section(header: Text("Video Filter").fontWeight(.heavy)) {
      showFavoriteToggle
      platformSegmentedPicker
    }
  }

  var showFavoriteToggle: some View {
    Toggle(isOn: $model.state.showFavoriteOnly) {
      Text("Show Favorite Only")
        .font(.subheadline)
    }
  }

  var platformSegmentedPicker: some View {
    Picker("", selection: $model.state.chosenPlatform) {
      ForEach(model.state.platforms, id: \.self) { platform in
        Text(platform)
          .tag(Platform(rawValue: platform))
      }
    }
    .pickerStyle(SegmentedPickerStyle())
  }

  func videoRows(groupedBy weekday: WeekDay) -> some View {
    let viewModels = model.videoViewModelGrouped(by: weekday)
    let headerText = "\(weekday.rawValue.capitalized) (\(viewModels.count))"
    return Section(header: Text(headerText).fontWeight(.heavy)) {
      ForEach(viewModels) { viewModel in
        VideoRow(model: viewModel)
          .contentShape(Rectangle())
          .onTapGesture {
            Task { await model.action(.chosenVideo(viewModel.state.video)) }
          }
      }
    }
  }
}

// MARK: - Previews

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    let mockService = MockVideoDataService()
    return Group {
      HomeView(model: .init(videoService: mockService))
      HomeView(model: .init(state: .init(showFavoriteOnly: true), videoService: mockService))
      HomeView(model: .init(state: .init(chosenPlatform: .macOS), videoService: mockService))
//      HomeView(model: .init(state: .init(chosenVideo: defaultVideos[0]), videoService: mockService))
    }
  }
}
