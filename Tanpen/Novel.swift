//
//  Novel.swift
//  Tanpen
//
//  Created by まつはる on 2024/05/29.
//

import Foundation

struct Novel: Codable {
    let title: String
    let content: String
    let prompt: String
    let wordCount: Int
    let keyword: String
}
