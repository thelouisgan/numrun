//
//  numrun.swift
//  numrun
//
//  Created by Louis Gan on 26/12/2023.
//

import Foundation

struct numrunDTO: Identifiable, Codable {
    var id: String
    let score: Int
    let userAnswer: String?
    let answer: Int
}
