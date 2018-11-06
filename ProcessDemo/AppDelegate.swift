//
//  AppDelegate.swift
//  ProcessDemo
//
//  Created by Jason on 2018/11/6.
//  Copyright © 2018 Jason. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {



    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
        UserDefaults.standard.removeObject(forKey: kSelectedFilePath)
        
    }
    
    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        return true
    }

    @IBAction func githubMenuClick(_ sender: Any) {
        
        NSWorkspace.shared.open(URL(string: "https://github.com/chenjie1219/ProcessDemo")!)
    }
    
}

