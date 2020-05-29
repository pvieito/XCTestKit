//
//  XCUIElement.swift
//  XCTestKit
//
//  Created by Pedro José Pereira Vieito on 24/05/2020.
//  Copyright © 2020 Pedro José Pereira Vieito. All rights reserved.
//

#if canImport(Darwin)
import Foundation
import XCTest

extension XCUIElement {
    public func assertErrorAlert(dismiss: Bool = true) {
        XCTAssertEqual(self.staticTexts.matching(identifier: "Error").count, 1)
        
        if dismiss {
            self.dismissAlert()
        }
    }
    
    public func assertNoErrorAlert() {
        XCTAssertEqual(self.staticTexts.matching(identifier: "Error").count, 0)
    }
}

extension XCUIElement {
    public func dismissAlert() {
        self.buttons["OK"].firstMatch.tap()
    }
    
    public func dismissPopover() {
        self.otherElements["PopoverDismissRegion"].tap()
    }
}

extension XCUIElement {
    private static let notExistancePredicate = NSPredicate(format: "exists == FALSE")

    @discardableResult
    public func waitForNotExistence(timeout: TimeInterval) -> XCTWaiter.Result {
        let notExistanceExpectation = XCTNSPredicateExpectation(
            predicate: Self.notExistancePredicate, object: self)
        return XCTWaiter.wait(for: [notExistanceExpectation], timeout: timeout)
    }
}
#endif
