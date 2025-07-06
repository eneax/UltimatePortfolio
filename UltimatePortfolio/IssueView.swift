//
//  IssueView.swift
//  UltimatePortfolio
//
//  Created by Enea Xharja on 06.07.25.
//

import SwiftUI

struct IssueView: View {
    @ObservedObject var issue: Issue
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    IssueView(issue: .example)
}
