//
//  AddressesMockFabric.swift
//  Combine+RXSwiftTests
//
//

import Foundation

struct AddressesMockFabric {
    static func getAddresses() -> [Address] {
        return [
            Address(name: "Томск"),
            Address(name: "Новосибирск"),
            Address(name: "Кемерово"),
            Address(name: "Барнаул")
        ]
    }
}
