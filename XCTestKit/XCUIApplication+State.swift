//
//  XCUIApplication.swift
//  XCTestKit
//
//  Created by Pedro José Pereira Vieito on 12/06/2020.
//  Copyright © 2020 Pedro José Pereira Vieito. All rights reserved.
//

import Foundation
import XCTest

extension XCUIApplication.State {
    private static let runningStates: [XCUIApplication.State] = [
        .runningBackground,
        .runningForeground
    ]
    
    public var isRunning: Bool {
        return Self.runningStates.contains(self)
    }
}
