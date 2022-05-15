//
//  InMemoryStore.swift
//  WWDCPlayer
//
//  Created by Giftbot on 2022/05/14.
//  Copyright © 2022 Giftbot. All rights reserved.
//

import Foundation

protocol VideoStore {
  func fetchVideos() async -> [Video]
  func toggleFavorite(of video: Video) -> Video
}

final class InMemoryVideoStore: VideoStore {
  private(set) var videos: [Video] = defaultVideos

  func fetchVideos() async -> [Video] {
    try? await Task.sleep(nanoseconds: 200_000_000)
    return videos
  }

  func toggleFavorite(of video: Video) -> Video {
    guard let index = videos.firstIndex(of: video) else { return video }
    videos[index].isFavorite.toggle()
    return videos[index]
  }
}

let defaultVideos = [
  Video(sessionID: 101, title: "Keynote", duration: 8252, weekDay: .monday, platforms: Platform.allCases, urlString: "https://p-events-delivery.akamaized.net/3004qzusahnbjppuwydgjzsdyzsippar/m3u8/hls_vod_mvp.m3u8"),
  Video(sessionID: 103, title: "Platforms State of the Union", duration: 7038, weekDay: .monday, platforms: Platform.allCases, urlString: "https://devstreaming-cdn.apple.com/videos/wwdc/2019/103bax22h2udxu0n/103/hls_vod_mvp.m3u8", isFavorite: true),
  Video(sessionID: 204, title: "Introducing SwiftUI: Building Your First App", duration: 3255, weekDay: .tuesday, platforms: Platform.allCases, urlString: "https://devstreaming-cdn.apple.com/videos/wwdc/2019/204isgnpbqud244/204/hls_vod_mvp.m3u8"),
  Video(sessionID: 216, title: "SwiftUI Essentials", duration: 3507, weekDay: .wednesday, platforms: Platform.allCases, urlString: "https://devstreaming-cdn.apple.com/videos/wwdc/2019/216oe5ad0gu7zw8cqfd/216/hls_vod_mvp.m3u8", isFavorite: true),
  Video(sessionID: 219, title: "SwiftUI on watchOS", duration: 1852, weekDay: .wednesday, platforms: [.watchOS], urlString: "https://devstreaming-cdn.apple.com/videos/wwdc/2019/219s60i7y7dovs8r4/219/hls_vod_mvp.m3u8"),
  Video(sessionID: 226, title: "Data Flow Through SwiftUI", duration: 2239, weekDay: .thursday, platforms: Platform.allCases, urlString: "https://devstreaming-cdn.apple.com/videos/wwdc/2019/226mq9pvm28zqfqer2a/226/hls_vod_mvp.m3u8"),
  Video(sessionID: 231, title: "Integrating SwiftUI", duration: 2301, weekDay: .thursday, platforms: Platform.allCases, urlString: "https://devstreaming-cdn.apple.com/videos/wwdc/2019/231qbm6xl2bbd5t/231/hls_vod_mvp.m3u8"),
  Video(sessionID: 237, title: "Building Custom Views with SwiftUI", duration: 2410, weekDay: .thursday, platforms: Platform.allCases, urlString: "https://devstreaming-cdn.apple.com/videos/wwdc/2019/237x70rryl2b933v/237/hls_vod_mvp.m3u8"),
  Video(sessionID: 238, title: "Accessibility in SwiftUI", duration: 2285, weekDay: .friday, platforms: [.iOS, .macOS], urlString: "https://devstreaming-cdn.apple.com/videos/wwdc/2019/238w8avpcuaf5ox/238/hls_vod_mvp.m3u8"),
  Video(sessionID: 240, title: "SwiftUI on All Devices", duration: 2704, weekDay: .friday, platforms: Platform.allCases, urlString: "https://devstreaming-cdn.apple.com/videos/wwdc/2019/240kqdx1bcyovfjoz/240/hls_vod_mvp.m3u8"),
]
