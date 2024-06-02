//
//  Novel.swift
//  Tanpen
//
//  Created by まつはる on 2024/05/29.
//

import Foundation

struct Novel: Codable {
    var title: String
    var content: String
    var prompt: String
    var wordCount: Int
    var keyword: String
}
