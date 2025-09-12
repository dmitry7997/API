//
//  FakeNetworkSession.swift
//  Menu
//
//  Created by Alice Hyun on 11/10/21.
//  Copyright © 2021 DoorDash, Inc. All rights reserved.
//

import Foundation

class ContentService {
    let session = FakeNetworkSession()
    // добавить мапинг, преобразовать данные в модели (массив объектов)
    
    /// fetches data to retrieve item content
    func getItemData() {
        // pretend this is a real network request, but you
        // can assume there will always be data and no error
        session.networkTask { data in
            print(String(data: data, encoding: .utf8)!)
            // make updates here
        }
    }
}
