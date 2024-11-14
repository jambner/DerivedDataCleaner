//
//  AppDelegate.swift
//  DerivedDataCleaner
//
//  Created by jambo on 11/14/24.
//

import Cocoa

class AppDelegate: NSObject, NSApplicationDelegate {
    private var statusItem: NSStatusItem!
    
    
    
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        setupStatusItem()
    }
    
    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
    
    func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
        return true
    }
    
    private func setupStatusItem() {
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.squareLength)
        
        let menu = NSMenu()
        menu.addItem(NSMenuItem(title: "Clear DerivedData", action: #selector(clearDerivedData), keyEquivalent: "c"))
        menu.addItem(NSMenuItem.separator())
        menu.addItem(NSMenuItem(title: "Quit", action: #selector(NSApplication.terminate(_:)), keyEquivalent: "q"))
        
        if let button = statusItem.button {
            button.image = NSImage(systemSymbolName: "trash", accessibilityDescription: "Clear DerivedData")
            button.target = self
        }
        
        statusItem.menu = menu
    }
    
    @objc private func clearDerivedData() {
        let confirmationAlert = NSAlert()
        confirmationAlert.messageText = "Are you sure you want to clear DerivedData?"
        confirmationAlert.informativeText = "This action will remove temporary build data. It cannot be undone."
        confirmationAlert.alertStyle = .warning
        confirmationAlert.addButton(withTitle: "Clear")
        confirmationAlert.addButton(withTitle: "Cancel")
        
        let response = confirmationAlert.runModal()
        
        if response == .alertFirstButtonReturn {
            let result = DerivedDataManager.shared.clearDerivedData()
            let resultAlert = NSAlert()
            resultAlert.messageText = result.success ? "Success" : "Error"
            resultAlert.informativeText = result.message
            resultAlert.alertStyle = result.success ? .informational : .warning
            resultAlert.addButton(withTitle: "OK")
            resultAlert.runModal()
        }
    }
}
