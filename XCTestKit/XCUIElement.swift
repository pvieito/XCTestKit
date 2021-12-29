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
    private static let alertExistenceTimeout: TimeInterval = 3.0
    
    public func assertErrorAlert(dismiss: Bool = true) {
        let errorMessages = self.staticTexts.matching(identifier: "Error")
        let _ = errorMessages.firstMatch.waitForExistence(timeout: Self.alertExistenceTimeout)
        XCTAssertEqual(errorMessages.count, 1)
        
        if dismiss {
            self.dismissAlert()
        }
    }
    
    public func assertNoErrorAlert() {
        let errorMessages = self.staticTexts.matching(identifier: "Error")
        errorMessages.firstMatch.waitForNotExistence(timeout: Self.alertExistenceTimeout)
        XCTAssertEqual(errorMessages.count, 0)
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
    private static let notExistencePredicate = NSPredicate(format: "exists == FALSE")

    @discardableResult
    public func waitForNotExistence(timeout: TimeInterval) -> XCTWaiter.Result {
        let notExistenceExpectation = XCTNSPredicateExpectation(
            predicate: Self.notExistencePredicate, object: self)
        return XCTWaiter.wait(for: [notExistenceExpectation], timeout: timeout)
    }
}
#endif
