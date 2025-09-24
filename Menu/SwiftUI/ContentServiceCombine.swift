//
//  ContentServiceCombine.swift
//  Menu
//
//  Created by manolo on 3/28/22.
//  Copyright © 2022 DoorDash, Inc. All rights reserved.
//

import Combine
import Foundation
import SwiftUI

struct Items: Identifiable, Decodable {
    var id = UUID()
    let title: String?
    let imageUrl: URL?
    let description: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case imageUrl = "image_url"
        case description
    }
    
    struct ContentItemResponse: Decodable {
        let contentItems: [Items]
        
        enum CodingKeys: String, CodingKey {
            case contentItems = "content_items"
        }
    }
    
     class ContentServiceCombine {
        private var cancellables = Set<AnyCancellable>()
        private let session: FakeNetworkSession
        
        init(cancellables: Set<AnyCancellable> = Set<AnyCancellable>(), session: FakeNetworkSession) {
            self.cancellables = cancellables
            self.session = session
        }
        /// fetches data to retrieve item content
        func getMenuItemData() {
            // pretend this is a real network request, but you
            // can assume there will always be data and no error
            session
                .networkCall
                .sink(
                    receiveCompletion: { completion in
                        switch completion {
                        case .failure(let error):
                            print(error)
                        case .finished:
                            break
                        }
                    },
                    receiveValue: { data in
                        print(String(data: data, encoding: .utf8)!)
                        // make updates here
                    }
                )
                .store(in: &cancellables)
        }
    }
}
