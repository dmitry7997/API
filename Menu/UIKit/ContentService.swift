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
    let imageUrl: URL?
    let description: String
}

struct ContentItemsResponse: Decodable {
    let contentItems: [Item]
}

protocol ContentServiceProtocol {
    func getItemData(completion: @escaping (Result<[Item], Error>) -> Void)
}

final class ContentService: ContentServiceProtocol {
    
    private let session: FakeNetworkSession
    
    init(session: FakeNetworkSession) {
        self.session = session
    }
    
    func getItemData(completion: @escaping (Result<[Item], Error>) -> Void) {
        session.networkTask { data in
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let response = try decoder.decode(ContentItemsResponse.self, from: data)
                let items = response.contentItems
                
                DispatchQueue.main.async {
                    completion(.success(items))
                }
            } catch {
                print("\(error.localizedDescription)")
            }
        }
    }
}
