//
//  ScrollItemView.swift
//  BookKeeper
//
//  Created by 孙世伟 on 2024/3/14.
//

import SwiftUI

struct ScrollItemView: View {
    let record: Record
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("\(dateString)")
                Text("\(record.counterparty)")
                Text("\(record.goods)").lineLimit(1)
                Text("\(record.amoutString)")
            }
            Spacer()
            VStack {
                Text("\(record.flow.detail)")
                    .bold()
                Spacer()
            }
        }
        
        .padding()
        .frame(maxWidth: .infinity, minHeight: 50)
        .background(Color.gray.opacity(0.2))
        .cornerRadius(10)
    }
    
    var dateString: String {
        guard let date = record.time else {
            return "未知"
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd HH:mm"
        return dateFormatter.string(from: date)
    }
}

#Preview {
    let record = Record(data: ["2023-03-31 21:23:01", "商户消费", "滴滴出行", "滴滴出行服务", "支出", "¥18.73", "零钱通", "支付成功", "4200001804202303312908843537\t", "PnGuAHa49gFnHUvBBNA1SCxxxxqBExZx\t", "/"])
    return ScrollItemView(record: record)
}
