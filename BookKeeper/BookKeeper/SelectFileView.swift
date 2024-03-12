//
//  SelectFileView.swift
//  BookKeeper
//
//  Created by 孙世伟 on 2024/3/12.
//

import SwiftUI
import SwiftCSV

struct SelectFileView: View {
    let viewModel: RecordsModel
    
    var body: some View {
        VStack {
            Button("Chosse File") {
                let files = FileUtils.chooseCSVFiles()
                let records = files.flatMap{ parseCSV($0) }
                viewModel.records = records
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
