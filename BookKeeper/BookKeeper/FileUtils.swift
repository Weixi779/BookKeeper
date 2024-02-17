//
//  FileUtils.swift
//  BookKeeper
//
//  Created by 孙世伟 on 2024/2/17.
//

import AppKit
import Foundation

struct FileUtils {
    static func chooseCSVFile() -> URL? {
        let panel = NSOpenPanel()
        panel.allowsMultipleSelection = false
        panel.canChooseDirectories = false
        panel.canChooseFiles = true
        panel.allowedContentTypes = [.commaSeparatedText]

        if panel.runModal() == .OK {
            if let url = panel.urls.first {
                return url
            }
        }
        return nil
    }
}