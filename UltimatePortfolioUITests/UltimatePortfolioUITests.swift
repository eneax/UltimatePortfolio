//
//  UltimatePortfolioUITests.swift
//  UltimatePortfolioUITests
//
//  Created by Enea Xharja on 20.09.25.
//

import XCTest

extension XCUIElement {
    func clear() {
        guard let stringValue = self.value as? String else {
            XCTFail("Failed to clear text in XCUIElement.")
            return
        }

        let deleteString = String(repeating: XCUIKeyboardKey.delete.rawValue, count: stringValue.count)
        typeText(deleteString)
    }
}

final class UltimatePortfolioUITests: XCTestCase {
    var app: XCUIApplication!

    override func setUpWithError() throws {
        continueAfterFailure = false

        app = XCUIApplication()
        app.launchArguments = ["enable-testing"]
        app.launch()
    }

    func testAppStartsWithNavigationBar() throws {
        XCTAssertTrue(app.navigationBars.element.exists, "There should be a navigation bar when the app launches.")
    }

    func testAppHasBasicButtonsOnLaunch() throws {
        XCTAssertTrue(app.navigationBars.buttons["Filters"].exists, "There should be a Filters button launch.")
        XCTAssertTrue(app.navigationBars.buttons["Filter"].exists, "There should be a Filter button launch.")
        XCTAssertTrue(app.navigationBars.buttons["New Issue"].exists, "There should be a New Issue button launch.")
    }

    func testNoIssuesAtStart() {
        XCTAssertEqual(app.cells.count, 0, "There should be no list rows initially.")
    }

    func testCreatingAndDeletingIssues() {
        for tapCount in 1...5 {
            app.buttons["New Issue"].tap()
            app.buttons["Issues"].tap()

            XCTAssertEqual(app.cells.count, tapCount, "There should be \(tapCount) rows in the list.")
        }

        for tapCount in (0...4).reversed() {
            app.cells.firstMatch.swipeLeft()
            app.buttons["Delete"].tap()

            XCTAssertEqual(app.cells.count, tapCount, "There should be \(tapCount) rows in the list.")
        }
    }

    func testEditingIssueTitleUpdatesCorrectly() {
        XCTAssertEqual(app.cells.count, 0, "There should be no list rows initially.")

        app.buttons["New Issue"].tap()

        app.textFields["Enter the issue title here"].tap()
        app.textFields["Enter the issue title here"].clear()
        app.typeText("My New Issue")

        app.buttons["Issues"].tap()
        XCTAssertTrue(app.buttons["My New Issue"].exists, "A My New Issue cell should now exist.")
    }

    func testEditingIssuePriorityShowsIcon() {
        app.buttons["New Issue"].tap()
        app.buttons["Priority, Medium"].tap()
        app.buttons["High"].tap()

        app.buttons["Issues"].tap()

        let identifier = "New issue High Priority"
        XCTAssert(app.images[identifier].exists, "A high-priority issue needs an icon next to it.")
    }

    func testAllAwardsShowLockedAlert() {
        // Open Filters and then the Awards view
        let window = app.windows.element(boundBy: 0)

        let filtersButton = window.buttons["Filters"]
        XCTAssertTrue(filtersButton.waitForExistence(timeout: 2), "Filters button should exist")
        filtersButton.tap()

        let showAwardsButton = app.buttons["Show awards"]
        XCTAssertTrue(showAwardsButton.waitForExistence(timeout: 2), "Show awards button should exist")
        showAwardsButton.tap()

        // Scope to the awards scroll view to avoid ambiguous queries
        let awardsScrollView = app.scrollViews.firstMatch
        XCTAssertTrue(awardsScrollView.waitForExistence(timeout: 2), "Awards scroll view should appear")

        // Collect all award buttons within the scroll view
        let awardButtons = awardsScrollView.buttons.allElementsBoundByIndex
        XCTAssertFalse(awardButtons.isEmpty, "There should be at least one award button")

        for award in awardButtons {
            // Ensure the award is visible; scroll within the scroll view if needed
            if !window.frame.contains(award.frame) {
                awardsScrollView.swipeUp()
            }

            // Tap the award and assert the Locked alert appears
            award.tap()

            let lockedAlert = app.alerts["Locked"]
            XCTAssertTrue(lockedAlert.waitForExistence(timeout: 2), "There should be a Locked alert showing for awards")

            // Dismiss the alert reliably by tapping the OK button within the alert
            let okButton = lockedAlert.buttons["OK"]
            XCTAssertTrue(okButton.waitForExistence(timeout: 2), "OK button should exist on Locked alert")
            okButton.tap()
        }
    }
}
