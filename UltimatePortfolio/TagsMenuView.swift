//
//  TagsMenuView.swift
//  UltimatePortfolio
//
//  Created by Enea Xharja on 28.07.25.
//

import SwiftUI

struct TagsMenuView: View {
    @EnvironmentObject var dataController: DataController
    @ObservedObject var issue: Issue

    var body: some View {
        Menu {
            // selected tags
            ForEach(issue.issueTags) { tag in
                Button {
                    issue.removeFromTags(tag)
                } label: {
                    Label(tag.tagName, systemImage: "checkmark")
                }
            }

            // unselected tags
            let otherTags = dataController.missingTags(from: issue)

            if otherTags.isEmpty == false {
                Divider()

                Section("Add Tags") {
                    ForEach(otherTags) { tag in
                        Button(tag.tagName) {
                            issue.addToTags(tag)
                        }
                    }
                }
            }
        } label: {
            Text(issue.issueTagsList)
                .multilineTextAlignment(.leading)
                .frame(maxWidth: .infinity, alignment: .leading)
                .animation(nil, value: issue.issueTagsList)
        }
    }
}

#Preview {
    TagsMenuView(issue: .example)
        .environmentObject(DataController(inMemory: true))
}
