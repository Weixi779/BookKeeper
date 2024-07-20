//
//  RecordsModel.swift
//  BookKeeper
//
//  Created by 孙世伟 on 2024/3/2.
//

import Foundation
import SwiftUI

enum SortType {
    case time, amount
}

@Observable
class RecordsModel {
    
    var records: [Record] {
        didSet {
            self.records.save(withKey: "record")
        }
    }
    
    var sortType: SortType = .amount
    
    init() {
        self.records = [Record].load(withKey: "record") ?? []
    }
    
    let sortTime: (Date?, Date?) -> Bool = { date1, date2 in
        guard let date1 = date1, let date2 = date2 else {
            return false
        }
        return date1 > date2
    }
}

extension RecordsModel {
    var isRecordsEmpty: Bool {
        return self.records.isEmpty
    }
    
    var totalExpenditure: String {
        let total = self.records.reduce(0) { $1.flow == .expenditure ? $0 + $1.amount : $0 }
        return String(format: "%.2f", total)
    }
    
    var totalIncome: String {
        let total = self.records.reduce(0) { $1.flow == .income ? $0 + $1.amount : $0 }
        return String(format: "%.2f", total)
    }
    
    var totalCirculation: String {
        let total = self.records.reduce(0) { $1.flow == .circulation ? $0 + $1.amount : $0 }
        return String(format: "%.2f", total)
    }
    
    var totalAmount: String {
        let totalIncome = self.records.reduce(0) { $1.flow == .income ? $0 + $1.amount : $0 }
        let totalExpenditure = self.records.reduce(0) { $1.flow == .expenditure ? $0 + $1.amount : $0 }
        return String(format: "%.2f", totalIncome - totalExpenditure)
    }
    
    var displayRecords: [Record] {
        let withoutCirculation = self.records.filter{ $0.flow != .circulation }
        switch self.sortType {
        case .time:
            return withoutCirculation.sorted { ($0.time ?? Date.distantPast) < ($1.time ?? Date.distantPast) }
        case .amount:
            return withoutCirculation.sorted { $0.amount > $1.amount }
        }
    }
}
