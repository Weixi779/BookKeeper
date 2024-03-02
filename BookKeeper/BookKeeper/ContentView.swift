//
//  ContentView.swift
//  BookKeeper
//
//  Created by 孙世伟 on 2024/2/14.
//

import SwiftUI
import SwiftCSV

struct ContentView: View {
    @Persisted(defalutValue: [Record]())
    var records: [Record]
    
    var body: some View {
        VStack {
            Button("Chosse File") {
                let files = FileUtils.chooseCSVFiles()
                var records = files.map{ parseCSV($0) }
            }
        }
    }
    
    func parseCSV(_ url: URL) -> [Record] {
        do {
            let csv = try EnumeratedCSV(url: url)
            let accounts: [[String]] = Array(csv.rows.dropFirst(17))
            return accounts.map { Record(data: $0) }
        } catch {
            print(error.localizedDescription)
        }
        return []
    }
}

#Preview {
    ContentView()
}
