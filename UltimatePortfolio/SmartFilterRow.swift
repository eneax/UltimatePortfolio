//
//  SmartFilterRow.swift
//  UltimatePortfolio
//
//  Created by Enea Xharja on 29.07.25.
//

import SwiftUI

struct SmartFilterRow: View {
    var filter: Filter

    var body: some View {
        NavigationLink(value: filter) {
            Label(LocalizedStringKey(filter.name), systemImage: filter.icon)
        }
    }
}

#Preview {
    SmartFilterRow(filter: .all)
}
