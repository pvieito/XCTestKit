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
    public func openDocuments(at url: URL, selectDirectoryContents: Bool = false) {
        let url = url.resolvingSymlinksInPath().absoluteURL
        self.typeKey("o", modifierFlags: .command)
        self.typeKey("g", modifierFlags: [.command, .shift])
        self.typeText(url.path)
        self.typeText(XCUIKeyboardKey.enter.rawValue)
        
        if selectDirectoryContents {
            self.typeText(XCUIKeyboardKey.rightArrow.rawValue)
            self.typeKey("a", modifierFlags: [.command])
        }
        
        self.typeText(XCUIKeyboardKey.enter.rawValue)
    }
    
    public func saveDocument(to url: URL? = nil, filename: String? = nil, pathExtension: String? = nil, assertDefaultFileName: String? = nil) -> URL {
        self.typeKey("s", modifierFlags: .command)
        self.assertNoErrorAlert()
        
        if let assertDefaultFileName = assertDefaultFileName {
            self.typeKey("c", modifierFlags: .command)
            #if os(macOS)
            XCTAssertEqual(NSPasteboard.general.string(forType: .string), assertDefaultFileName)
            #else
            XCTAssertEqual(UIPasteboard.general.string, assertDefaultFileName)
            #endif
        }
        
        var outputURL = url ?? FileManager.default.temporaryRandomFileURL(
            filename: filename, pathExtension: pathExtension)
        outputURL = outputURL.resolvingSymlinksInPath().absoluteURL
        self.typeKey("g", modifierFlags: [.command, .shift])
        self.typeText(outputURL.path)
        self.typeKey(XCUIKeyboardKey.enter.rawValue, modifierFlags: [])
        self.typeKey(XCUIKeyboardKey.enter.rawValue, modifierFlags: [])
        return outputURL
    }
}
#endif
