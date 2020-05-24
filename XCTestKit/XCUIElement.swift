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
    public func assertErrorMessage() {
        XCTAssertEqual(self.staticTexts.matching(identifier: "Error").count, 1)
    }
    
    public func assertNoErrorMessages() {
        XCTAssertEqual(self.staticTexts.matching(identifier: "Error").count, 0)
    }
}
#endif
