//
//  VideoRow.swift
//  WWDCPlayer
//
//  Created by Giftbot on 2019/09/13.
//  Copyright © 2019 Giftbot. All rights reserved.
//

import SwiftUI

struct VideoRow : View {
  @ObservedObject private var model: VideoViewModel
  private let isVideoInfo: Bool
  
  init(viewModel model: VideoViewModel, isVideoInfo: Bool = false) {
    self.model = model
    self.isVideoInfo = isVideoInfo
  }

  
  // MARK: Body
  
  var body: some View {
    VStack(alignment: .leading) {
      HStack {
        videoTitle
        if model.isSelected && !isVideoInfo {
          playingImage
        }
        Spacer()
        favoriteImage
      }
      videoDescription("Session \(model.id) · \(model.duration)")
      videoDescription(model.platforms)
    }
    .padding(.vertical, 4)
  }
}


// MARK: - Body Content

extension VideoRow {
  private var videoTitle: some View {
    Text(model.title)
      .font(isVideoInfo ? .system(size: 26, weight: .heavy) : .headline)
      .fixedSize(horizontal: false, vertical: true)
  }
  
  private var playingImage: some View {
    Image(systemName: "tv.music.note").scaleEffect(0.9)
  }
  
  private var favoriteImage: some View {
    Image(systemName: model.isFavorite ? "star.fill" : "star")
      .foregroundColor(model.isFavorite ? Color.yellow : Color.gray)
      .scaleEffect(1.1)
      .onTapGesture { self.model.executeCommand(.toggleFavorite) }
  }
  
  private func videoDescription(_ text: String) -> some View {
    Text(text)
      .font(.footnote).fontWeight(.semibold)
      .foregroundColor(.secondary)
  }
}



// MARK: - Previews

#if DEBUG
struct VideoRow_Previews : PreviewProvider {
  static var previews: some View {
    VideoRow(viewModel: .init(video: defaultVideos[0]), isVideoInfo: false)
  }
}
#endif


