//
//  ContentView.swift
//  BookKeeper
//
//  Created by 孙世伟 on 2024/2/14.
//

import SwiftUI
import SwiftCSV

struct ContentView: View {
    var body: some View {
        VStack {
            Button("Chosse File") {
                chooseFile()
            }
        }
    }
    
    func chooseFile() {
        let panel = NSOpenPanel()
        panel.allowsMultipleSelection = false
        panel.canChooseDirectories = false
        panel.canChooseFiles = true
        panel.allowedContentTypes = [.commaSeparatedText]

        if panel.runModal() == .OK {
            if let url = panel.urls.first {
                test(url)
            }
        }
    }
    
    func test(_ url: URL) {
        do {
            let csv = try CSV<Named>(url: url)
            print(csv.rows.count)
            print(csv.columns?.count)
        } catch {
            print(error.localizedDescription)
        }
    }
}

#Preview {
    ContentView()
}
