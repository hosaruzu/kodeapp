//
//  Person.swift
//  kodeapp
//
//  Created by Artem Tebenkov on 25.03.2024.
//

import Foundation

struct PeopleResponse: Decodable {
    let items: [Person]
}

struct Person: Decodable {
    let id: String
    let firstName: String
    let lastName: String
    let userTag: String
    let department: String
    let position: String
    let birthday: String
    let phone: String
}
