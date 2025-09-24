//
//  MainView.swift
//  Menu
//
//  Created by manolo on 12/20/21.
//  Copyright © 2021 DoorDash, Inc. All rights reserved.
//

import SwiftUI

struct MainView: View {
    private let service: ContentServiceCombine
    
    init(service: ContentServiceCombine) {
        self.service = service
    }
     var items: [Items] = []
    
    var body: some View {
        List(items, id: \.id) { item in
            HStack {
                Image(items.imageUrl) // ошибка здесь
                    .resizable()
                    .scaledToFit()
                    .frame(width: 80, height: 80)
                    .cornerRadius(12)
                
                VStack(alignment: .leading, spacing: 16) {
                    Text(item.title) // здесь
                        .fontWeight(.bold)
                        .lineLimit(3)
                        .minimumScaleFactor(0.5)
                    
                    Text(item.description) // и здесь
                        .fontWeight(.regular)
                        .font(.subheadline)
                }
            }
        }
        Color.clear
            .onAppear {
                service.getMenuItemData()
            }
    }
}
