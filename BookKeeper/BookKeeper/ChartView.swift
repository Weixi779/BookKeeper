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
                ScrollView {
                    LazyVGrid(columns: columns) {
                        ForEach(viewModel.records, id: \.self) { record in
                            Text("\(record.amoutString)")
                                .padding()
                                .frame(maxWidth: .infinity, minHeight: 50)
                                .background(Color.gray.opacity(0.2))
                                .cornerRadius(10)
                        }
                    }
                    .padding(.horizontal)
                }
            }
        }
    }
}

#Preview {
    ChartView()
}
