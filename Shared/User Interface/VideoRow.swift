//
//  VideoRow.swift
//  WWDCPlayer
//
//  Created by Giftbot on 2019/09/13.
//  Copyright © 2019 Giftbot. All rights reserved.
//

import SwiftUI

struct VideoRow: View {

  @ObservedObject var model: VideoRowViewModel
  var isSelected: Bool = false
  var isVideoInfoView: Bool = false

  var body: some View {
    VStack(alignment: .leading, spacing: 0) {
      HStack {
        videoTitle
        playingImage
          .showIf(isSelected && !isVideoInfoView)
        Spacer(minLength: 0)
        favoriteImage
      }
      .padding(.bottom, 4)

      VStack(alignment: .leading, spacing: 2) {
        Text("Session \(model.state.video.sessionID) · \(model.timeFormattedDuration)")
        Text(model.platforms)
          .showIf(!isVideoInfoView)
      }
      .font(.footnote.weight(.medium))
      .foregroundColor(.secondary)
    }
    .padding(.vertical, 4)
    .frame(maxWidth: .infinity, alignment: .leading)
    .onAppear { model.action(.onAppear) }
  }
}

fileprivate extension VideoRow {
  var videoTitle: some View {
    Text(model.state.video.title)
      .font(isVideoInfoView ? .title2.bold() : .headline)
      .foregroundColor(.primary)
      .multilineTextAlignment(.leading)
      .fixedSize(horizontal: false, vertical: true)
  }

  var playingImage: some View {
    Image(systemName: "tv.music.note").scaleEffect(0.9)
  }

  var favoriteImage: some View {
    Image(systemName: model.state.video.isFavorite ? "star.fill" : "star")
      .foregroundColor(model.state.video.isFavorite ? Color.yellow : Color.gray)
      .scaleEffect(1.1)
      .onTapGesture { model.action(.toggleFavorite) }
  }
}

// MARK: - Previews

struct VideoRow_Previews : PreviewProvider {
  static var previews: some View {
    let video = defaultVideos[0]
    return List {
      VideoRow(model: .init(state: .init(video: video)), isSelected: false, isVideoInfoView: true)
      VideoRow(model: .init(state: .init(video: video)), isSelected: true, isVideoInfoView: true)
      VideoRow(model: .init(state: .init(video: video)), isSelected: false, isVideoInfoView: false)
      VideoRow(model: .init(state: .init(video: video)), isSelected: true, isVideoInfoView: false)
      VideoRow(model: .init(state: .init(video: defaultVideos[1])))
      VideoRow(model: .init(state: .init(video: defaultVideos[2])))
      VideoRow(model: .init(state: .init(video: defaultVideos[2])), isVideoInfoView: true)
    }
#if os(iOS)
    .listStyle(.grouped)
#elseif os(macOS)
    .listStyle(.inset)
#endif
  }
}
