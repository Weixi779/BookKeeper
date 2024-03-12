//
//  RecordsModel.swift
//  BookKeeper
//
//  Created by 孙世伟 on 2024/3/2.
//

import Foundation
import SwiftUI

@Observable
class RecordsModel {
    var records: [Record] {
        didSet {
            self.records.save()
        }
    }
    
    init() {
        self.records = [Record].load() ?? []
    }
}

extension RecordsModel {
    var isRecordsEmpty: Bool {
        return self.records.isEmpty
    }
}
