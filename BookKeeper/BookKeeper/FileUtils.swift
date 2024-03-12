//
//  FileUtils.swift
//  BookKeeper
//
//  Created by 孙世伟 on 2024/2/17.
//

import AppKit
import Foundation

struct FileUtils {
    static func chooseCSVFiles() -> [URL] {
        let panel = NSOpenPanel()
        panel.allowsMultipleSelection = true
        panel.canChooseDirectories = false
        panel.canChooseFiles = true
        panel.allowedContentTypes = [.commaSeparatedText]

        if panel.runModal() == .OK {
            return panel.urls
        }
        return []
    }
}
