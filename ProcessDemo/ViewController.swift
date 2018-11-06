//
//  ViewController.swift
//  ProcessDemo
//
//  Created by Jason on 2018/11/6.
//  Copyright © 2018 Jason. All rights reserved.
//

import Cocoa

let kSelectedFilePath = "userSelectedPath"

class ViewController: NSViewController {
    
    @IBOutlet weak var repoPathFld: NSTextField!          //git仓库地址
    
    @IBOutlet weak var savePathLbl: NSTextField!          //本地保存路径
    
    
}




// MARK: - CustomMethod
extension ViewController{
    
    func openDirectory() {
        
        Shell.execmd("/bin/bash", arguments: ["-c","open \(UserDefaults.standard.value(forKey: kSelectedFilePath) ?? "")"]) { (result) in
            
        }
        
    }
    
}




// MARK: - Click
extension ViewController{
    

    //选择保存路径
    @IBAction func selectSavePath(_ sender: NSButton) {
        
        //1.创建打开文档面板对象
        let openPanel = NSOpenPanel()
        //2.设置确认按钮文字
        openPanel.prompt = "Select"
        //3.设置禁止选择文件
        openPanel.canChooseFiles = false
        //4.设置可以选择目录
        openPanel.canChooseDirectories = true
        //5.弹出面板框
        openPanel.beginSheetModal(for: view.window!) { (result) in
            //6.选择确认按钮
            if result == .OK {
                //7.获取选择的路径
                self.savePathLbl.stringValue = openPanel.directoryURL?.path ?? ""
                //8.保存用户选择路径(为了可以在其他地方有权限访问这个路径，需要对用户选择的路径进行保存)
                UserDefaults.standard.setValue(openPanel.url?.path, forKey: kSelectedFilePath)
                UserDefaults.standard.synchronize()
            }
            //9.恢复按钮状态
            sender.state = .off
            
        }
        
    }
    
    @IBAction func startClone(_ sender: NSButton) {
        
        guard repoPathFld.stringValue != "" else {
            
            let alert = NSAlert()
            
            alert.informativeText = "No Git Repo URL"
            
            alert.runModal()
            
            return
            
        }
        
        
        
        guard let executePath = UserDefaults.standard.value(forKey: kSelectedFilePath) as? String else {
            
            let alert = NSAlert()
            
            alert.informativeText = "No Selected Path"
            
            alert.runModal()
            
            return
        }
        
        sender.isEnabled = false
        
        sender.title = "Downloading..."
        
        Shell.execmd("/bin/bash", arguments: ["-c","cd \(executePath); git clone \(repoPathFld.stringValue)"]) { (result) in
            
            sender.isEnabled = true
            
            sender.title = "Git Clone"
            
            self.openDirectory()
            
        }
        
        
        
        
    }
    
    
}

