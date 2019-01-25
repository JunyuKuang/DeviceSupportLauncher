//
//  AppDelegate.swift
//  DeviceSupportLauncher
//
//  Created by Junyu Kuang on 10/3/17.
//  Copyright © 2017 Junyu Kuang. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    var window: NSWindow!

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        window = NSApp.windows.first
    }
    
    func applicationShouldHandleReopen(_ sender: NSApplication, hasVisibleWindows flag: Bool) -> Bool {
        window?.makeKeyAndOrderFront(self)
        return false
    }
}

