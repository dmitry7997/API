//
//  MainView.swift
//  Menu
//
//  Created by manolo on 12/20/21.
//  Copyright © 2021 DoorDash, Inc. All rights reserved.
//

import SwiftUI

struct MainView: View {
    private let service = ContentServiceCombine()
    
    var body: some View {
        Color.clear
            .onAppear {
                service.getMenuItemData()
            }
    }
}
