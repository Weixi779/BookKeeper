//
//  Record.swift
//  BookKeeper
//
//  Created by 孙世伟 on 2024/2/18.
//

import Foundation

/// 交易流向
enum TradeFlow {
    /// 支出
    case expenditure
    /// 收入
    case income
    /// 流通
    case circulation
}

/// 交易记录
struct Record {
    /// 交易时间
    let time: Date?
    /// 交易类型
    var tradeType: String
    /// 交易对方
    var counterparty: String
    /// 商品
    var goods: String
    /// 交易流向
    let flow: TradeFlow
    /// 金额
    let amount: Double
    /// 支付方式
    let paymentMethod: String
    /// 交易状态
    let tradeState: String
    /// 交易单号
    let tradeId: String
    /// 商户单号
    let merchantId: String
    /// 备注
    var note: String

    init(data: [String]) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        self.time = dateFormatter.date(from: data[0])
        self.tradeType = data[1]
        self.counterparty = data[2]
        self.goods = data[3]
        switch data[4] {
        case "支出": self.flow = .expenditure
        case "收入": self.flow = .income
        default: self.flow = .circulation
        }

        let pattern = /\d*[.]\d*/
        if let match = data[5].firstMatch(of: Regex(pattern)) {
            self.amount = Double(data[5][match.range]) ?? 0
        } else {
            self.amount = 0
        }
        self.paymentMethod = data[6]
        self.tradeState = data[7]
        self.tradeId = data[8].trimmedTab
        self.merchantId = data[9].trimmedTab
        self.note = data[10]
    }
}

extension String {
    var trimmedTab: String {
        guard self.hasSuffix("\t") else { return self }
        return String(self.dropLast())
    }
}
