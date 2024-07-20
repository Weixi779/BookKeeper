//
//  ContentView.swift
//  BookKeeper
//
//  Created by 孙世伟 on 2024/2/14.
//

import SwiftUI
import SwiftCSV

struct ChartView: View {
    let viewModel: RecordsModel = RecordsModel()
    
    let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        VStack {
            if viewModel.isRecordsEmpty {
                SelectFileView(viewModel: viewModel)
            } else {
                VStack(alignment: .leading) {
                    Text("总流通:\(viewModel.totalCirculation)")
                    Text("总支出:\(viewModel.totalExpenditure)")
                    Text("总收入:\(viewModel.totalIncome)")
                    Text("总收益:\(viewModel.totalAmount)")
                }
                .bold()
                .padding()
                Divider()
                
                HStack {
                    Spacer()
                    
                }
                .padding()
                
                ScrollView {
                    LazyVGrid(columns: columns) {
                        ForEach(viewModel.displayRecords, id: \.self) { record in
                            ScrollItemView(record: record)
                        }
                    }
                    .padding()
                }
            }
        }
    }
}

#Preview {
    ChartView()
}
