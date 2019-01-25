//
//  ViewController.swift
//  DeviceSupportLauncher
//
//  Created by Junyu Kuang on 10/3/17.
//  Copyright © 2017 Junyu Kuang. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet private var iOSButton: NSButton!
    @IBOutlet private var watchOSButton: NSButton!
    @IBOutlet private var tvOSButton: NSButton!
    @IBOutlet private var xcodeDirectorySelectionButton: NSButton!
}

private extension ViewController {
    
    enum Platform : String {
        case iOS, watchOS, tvOS
        
        var name: String {
            return rawValue
        }
        
        var directoryName: String {
            switch self {
            case .iOS:
                return "iPhoneOS.platform"
            case .watchOS:
                return "WatchOS.platform"
            case .tvOS:
                return "AppleTVOS.platform"
            }
        }
    }
    
    var selectedPlatforms: [Platform] {
        var platforms = [Platform]()
        if iOSButton?.state == .on {
            platforms.append(.iOS)
        }
        if watchOSButton?.state == .on {
            platforms.append(.watchOS)
        }
        if tvOSButton?.state == .on {
            platforms.append(.tvOS)
        }
        return platforms
    }
    
    @IBAction func selectedPlatformsDidChange(_ sender: Any) {
        xcodeDirectorySelectionButton.isEnabled = !selectedPlatforms.isEmpty
    }
    
    @IBAction func selectXcodeDirectory(_ sender: Any) {
        let panel = NSOpenPanel()
        panel.allowsMultipleSelection = true
        panel.allowedFileTypes = [kUTTypeApplication as String]
        panel.directoryURL = FileManager.default.urls(for: .applicationDirectory, in: .localDomainMask).last
        
        panel.beginSheetModal(for: view.window!) { result in
            guard result == .OK else { return }
            DispatchQueue.main.async {
                panel.urls.forEach(self.handleOpenedAppDirectory)
            }
        }
    }
    
    func handleOpenedAppDirectory(_ url: URL) {
        let platformsDirectory = url.appendingPathComponent("Contents/Developer/Platforms", isDirectory: true)
        let deviceSupportDirectories = selectedPlatforms.map { platformsDirectory.appendingPathComponent($0.directoryName + "/DeviceSupport", isDirectory: true) }
        deviceSupportDirectories.forEach { NSWorkspace.shared.open($0) }
    }
}
