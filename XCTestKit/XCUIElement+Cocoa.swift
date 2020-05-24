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
        self.synthesizeOpenKeyboardShortcut()
        self.synthesizeGoToKeyboardShortcut()
        self.typeText(url.path)
        self.typeText(XCUIKeyboardKey.enter.rawValue)
        
        if selectDirectoryContents {
            self.typeText(XCUIKeyboardKey.rightArrow.rawValue)
            self.synthesizeSelectAllKeyboardShortcut()
        }
        
        self.typeText(XCUIKeyboardKey.enter.rawValue)
    }
    
    public func saveDocument(to url: URL? = nil, filename: String? = nil, pathExtension: String? = nil, assertDefaultFileName: String? = nil) -> URL {
        self.synthesizeSaveKeyboardShortcut()
        self.assertNoErrorAlert()

        if let assertDefaultFileName = assertDefaultFileName {
            let selectedText = self.copySelectedText()
            XCTAssertEqual(selectedText, assertDefaultFileName)
        }
        
        var outputURL = url ?? FileManager.default.temporaryRandomFileURL(
            filename: filename, pathExtension: pathExtension)
        outputURL = outputURL.resolvingSymlinksInPath().absoluteURL
        self.synthesizeGoToKeyboardShortcut()
        self.typeText(outputURL.path)
        self.typeKey(XCUIKeyboardKey.enter.rawValue, modifierFlags: [])
        self.typeKey(XCUIKeyboardKey.enter.rawValue, modifierFlags: [])
        return outputURL
    }
}

extension XCUIElement {
    private func synthesizeOpenKeyboardShortcut() {
        self.typeKey("o", modifierFlags: .command)
    }
    
    private func synthesizeSaveKeyboardShortcut() {
        self.typeKey("s", modifierFlags: .command)
    }
    
    private func synthesizeSelectAllKeyboardShortcut() {
        self.typeKey("a", modifierFlags: .command)
    }
    
    private func synthesizeCopyKeyboardShortcut() {
        self.typeKey("c", modifierFlags: .command)
    }
    
    private func synthesizeGoToKeyboardShortcut() {
        self.typeKey("g", modifierFlags: [.command, .shift])
    }
}

extension XCUIElement {
    public func copySelectedText() -> String? {
        self.synthesizeCopyKeyboardShortcut()
        #if os(macOS)
        let copiedText = NSPasteboard.general.string(forType: .string)
        #else
        let copiedText = UIPasteboard.general.string
        #endif
        return copiedText
    }
    
    public func copyAllText() -> String? {
        self.synthesizeSelectAllKeyboardShortcut()
        return self.copySelectedText()
    }
}
#endif
