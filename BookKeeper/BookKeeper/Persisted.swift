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

extension Encodable {
    func save(withKey key: String? = nil) {
        if let encoded = try? JSONEncoder().encode(self) {
            let setKey = key ?? "UserDefaults-\(String(describing: self))"
            UserDefaults.standard.set(encoded, forKey: setKey)
        }
    }
}

extension Decodable {
    static func load<T: Codable>(withKey key: String? = nil) -> T? {
        let dataKey = key ?? "UserDefaults-\(String(describing: self))"
        guard let data = UserDefaults.standard.data(forKey: dataKey),
              let value = try? JSONDecoder().decode(T.self, from: data) else {
            return nil
        }
        return value
    }
}
