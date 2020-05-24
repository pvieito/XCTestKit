//
//  XCUIElement.swift
//  XCTestKit
//
//  Created by Pedro José Pereira Vieito on 24/05/2020.
//  Copyright © 2020 Pedro José Pereira Vieito. All rights reserved.
//

#if canImport(Cocoa)
import Foundation
import FoundationKit
import XCTest

extension XCUIElement {
    func saveDocument(to url: URL? = nil, filpathExtension: String? = nil, assertDefaultFileName: String? = nil) {
        self.typeKey("s", modifierFlags: .command)
        self.assertNoErrorMessages()
        
        if let assertDefaultFileName = assertDefaultFileName {
            self.typeKey("c", modifierFlags: .command)
            #if os(macOS)
            XCTAssertEqual(NSPasteboard.general.string(forType: .string), assertDefaultFileName)
            #else
            XCTAssertEqual(UIPasteboard.general.string, assertDefaultFileName)
            #endif
        }
        
        let temporaryOutputURL = FileManager.default.temporaryRandomFileURL(
            pathExtension: "pdf")
        self.typeKey("g", modifierFlags: [.command, .shift])
        self.typeText(temporaryOutputURL.path)
        self.typeKey(XCUIKeyboardKey.enter.rawValue, modifierFlags: [])
        self.typeKey(XCUIKeyboardKey.enter.rawValue, modifierFlags: [])

    }
}
#endif
