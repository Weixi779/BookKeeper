//
//  Persisted.swift
//  BookKeeper
//
//  Created by 孙世伟 on 2024/3/1.
//

import Foundation

@propertyWrapper
struct Persisted<Value: Codable> {
    private let key: String
    private let defaultValue: Value
    
    init(defaultValue: Codable, key: String) {
        self.defaultValue = defaultValue as! Value
        self.key = key
    }
    
    init(defalutValue: Codable) {
        self.defaultValue = defalutValue as! Value
        self.key = "Persisted-\(Self.self)"
    }
    
    var wrappedValue: Value {
        get {
            guard let data = UserDefaults.standard.data(forKey: key),
                  let value = try? JSONDecoder().decode(Value.self, from: data) else {
                return defaultValue
            }
            return value
        }
        set {
            let data = try? JSONEncoder().encode(newValue)
            UserDefaults.standard.set(data, forKey: self.key)
        }
    }
}
