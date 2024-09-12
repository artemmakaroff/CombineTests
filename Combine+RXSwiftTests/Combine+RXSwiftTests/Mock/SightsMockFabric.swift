//
//  SightsMockFabric.swift
//  Combine+RXSwiftTests
//
//  Created by Тёма on 12.09.2024.
//

import Foundation

struct SightsMockFabric {
    static func getSights() -> [Sight] {
        return [
            Sight(name: "Томский памятник Ленину", creationDate: Date()),
            Sight(name: "Новосибирский театр драмы", creationDate: Date()),
            Sight(name: "Кемеровский вокзал", creationDate: Date()),
            Sight(name: "Барнаульский проспект Ленина", creationDate: Date())
        ]
    }
}
