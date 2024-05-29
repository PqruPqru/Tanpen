//
//  NovelStorage.swift
//  Tanpen
//
//  Created by まつはる on 2024/05/29.
//

import Foundation

class NovelStorage {
    static let shared = NovelStorage()
    private let userDefaultsKey = "novels"

    func saveNovel(_ novel: Novel) {
        var novels = loadNovels()
        novels.append(novel)
        if let data = try? JSONEncoder().encode(novels) {
            UserDefaults.standard.set(data, forKey: userDefaultsKey)
        }
    }

    func loadNovels() -> [Novel] {
        if let data = UserDefaults.standard.data(forKey: userDefaultsKey),
           let novels = try? JSONDecoder().decode([Novel].self, from: data) {
            return novels
        }
        return []
    }
}
