//
//  Group.swift
//  KobayashiMaru
//
//  Created by Dustin Koch on 6/14/19.
//  Copyright © 2019 Rabbit Hole Fashion. All rights reserved.
//

import Foundation

struct Group: Equatable {
    var group: [[People]]
}

struct People: Equatable {
    var people: [Person]
}

struct Person: Equatable {
    var person: String
}
