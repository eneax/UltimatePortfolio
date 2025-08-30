//
//  TagTests.swift
//  UltimatePortfolioTests
//
//  Created by Enea Xharja on 30.08.25.
//

import CoreData
import XCTest
@testable import UltimatePortfolio

final class TagTests: BaseTestCase {
    func testCreatingTagsAndIssues() {
        let count = 10
        let issues = count * count

        for _ in 0..<count {
            let tag = Tag(context: managedObjectContext)

            for _ in 0..<count {
                let issue = Issue(context: managedObjectContext)
                tag.addToIssues(issue)
            }
        }

        XCTAssertEqual(dataController.count(for: Tag.fetchRequest()), count, "Expected tags: \(count).")
        XCTAssertEqual(dataController.count(for: Issue.fetchRequest()), issues, "Expected issues: \(issues).")
    }
}
