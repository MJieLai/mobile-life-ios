//
//  Data+Extension.swift
//  MobileLifeAssessment
//
//  Created by MJ on 30/07/2022.
//

import Foundation

extension Data {
    func parseTo<T: Codable>(typeClass: T.Type) -> T? {
        guard let model = try? JSONDecoder().decode(typeClass.self, from: self) else { return nil }
        return model
    }

    func parseTo<T: Codable>(typeClass: [T].Type) -> [T]? {
        guard let model = try? JSONDecoder().decode(typeClass.self, from: self) else { return nil }
        return model
    }
    
    func prettyPrintedJSONString() throws -> String { /// NSString gives us a nice sanitized debugDescription
        let object = try JSONSerialization.jsonObject(with: self, options: [])
        let data = try JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted])
        let prettyPrintedString = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
        return (prettyPrintedString ?? NSString()) as String
    }
    
    var toBase64String: String? {
        return self.base64EncodedString()
    }
}

