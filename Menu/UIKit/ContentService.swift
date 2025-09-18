//
//  FakeNetworkSession.swift
//  Menu
//
//  Created by Alice Hyun on 11/10/21.
//  Copyright © 2021 DoorDash, Inc. All rights reserved.
//

import Foundation

struct Item: Decodable {
    let title: String?
    let image_url: URL?
    let description: String

    enum CodingKeys: String, CodingKey {
        case title = "title"
        case image_url = "image_url"
        case description = "description"
    }
}

struct ContentItemsResponse: Decodable {
    let content_items: [Item]
}

protocol ContentServiceProtocol {
    func getItemData(completion: @escaping (Result<[Item], Error>) -> Void)
}

class ContentService: ContentServiceProtocol {
    private let session = FakeNetworkSession()
    
    func getItemData(completion: @escaping (Result<[Item], Error>) -> Void) {
        session.networkTask { data in
            
            DispatchQueue.global(qos: .userInitiated).async {
                do {
                    let decoder = JSONDecoder()
                    let response = try decoder.decode(ContentItemsResponse.self, from: data)
                    let items = response.content_items
                    
                    DispatchQueue.main.async {
                        completion(.success(items))
                    }
                } catch {
                    print("\(error.localizedDescription)")
                }
            }
        }
    }
}
