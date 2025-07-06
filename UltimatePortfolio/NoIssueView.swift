//
//  NoIssueView.swift
//  UltimatePortfolio
//
//  Created by Enea Xharja on 06.07.25.
//

import SwiftUI

struct NoIssueView: View {
    @EnvironmentObject var dataController: DataController
    
    var body: some View {
        Text("No Issue Selected")
            .font(.title)
            .foregroundStyle(.secondary)

        Button("New Issue") {
            // make a new issue
        }
    }
}

#Preview {
    NoIssueView()
}
