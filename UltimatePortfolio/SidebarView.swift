//
//  SidebarView.swift
//  UltimatePortfolio
//
//  Created by Enea Xharja on 25.06.25.
//

import SwiftUI

struct SidebarView: View {
    @EnvironmentObject var dataController: DataController
    let smartFilters: [Filter] = [.all, .recent]
    
    var body: some View {
        List(selection: $dataController.selectedFilter) {
            Section("Smart Filters") {
                ForEach(smartFilters) { filter in
                    NavigationLink(value: filter) {
                        Label(filter.name, systemImage: filter.icon)
                    }
                }
            }
        }
    }
}

#Preview {
    SidebarView()
        .environmentObject(DataController.preview)
}
