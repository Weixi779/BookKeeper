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
                if let fileUrl = FileUtils.chooseCSVFile() {
                    test(fileUrl)
                }
            }
        }
    }
    
    func test(_ url: URL) {
        do {
            let csv = try EnumeratedCSV(url: url)
            let accounts: [[String]] = Array(csv.rows.dropFirst(17))
            let records = accounts.map { Record(data: $0) }
            records.forEach { print($0) }
        } catch {
            print(error.localizedDescription)
        }
    }
}

#Preview {
    ContentView()
}
