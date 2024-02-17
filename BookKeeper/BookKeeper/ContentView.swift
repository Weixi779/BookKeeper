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
                if let fileUrl = FileUtils.chooseCSVFile() {
                    test(fileUrl)
                }
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
