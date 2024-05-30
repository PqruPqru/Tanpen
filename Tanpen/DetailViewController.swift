//
//  DetailViewController.swift
//  Tanpen
//
//  Created by まつはる on 2024/05/30.
//

import UIKit

class DetailViewController: UIViewController {
    var novel: Novel?

    private let titleLabel = UILabel()
    private let contentLabel = UILabel()
    private let promptLabel = UILabel()
    private let wordCountLabel = UILabel()
    private let keywordLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        setupUI()
        displayNovel()
    }

    private func setupUI() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        contentLabel.translatesAutoresizingMaskIntoConstraints = false
        promptLabel.translatesAutoresizingMaskIntoConstraints = false
        wordCountLabel.translatesAutoresizingMaskIntoConstraints = false
        keywordLabel.translatesAutoresizingMaskIntoConstraints = false

        titleLabel.font = UIFont.boldSystemFont(ofSize: 24)
        titleLabel.textAlignment = .center

        contentLabel.font = UIFont.systemFont(ofSize: 18)
        contentLabel.numberOfLines = 0

        promptLabel.font = UIFont.systemFont(ofSize: 16)
        promptLabel.textAlignment = .center

        wordCountLabel.font = UIFont.systemFont(ofSize: 16)
        wordCountLabel.textAlignment = .center

        keywordLabel.font = UIFont.systemFont(ofSize: 16)
        keywordLabel.textAlignment = .center

        view.addSubview(titleLabel)
        view.addSubview(contentLabel)
        view.addSubview(promptLabel)
        view.addSubview(wordCountLabel)
        view.addSubview(keywordLabel)

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            promptLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            promptLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            promptLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            wordCountLabel.topAnchor.constraint(equalTo: promptLabel.bottomAnchor, constant: 10),
            wordCountLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            wordCountLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            keywordLabel.topAnchor.constraint(equalTo: wordCountLabel.bottomAnchor, constant: 10),
            keywordLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            keywordLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            contentLabel.topAnchor.constraint(equalTo: keywordLabel.bottomAnchor, constant: 20),
            contentLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            contentLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            contentLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }

    private func displayNovel() {
        titleLabel.text = novel?.title
        contentLabel.text = novel?.content
        promptLabel.text = "Prompt: \(novel?.prompt ?? "")"
        wordCountLabel.text = "Word Count: \(novel?.wordCount ?? 0)"
        keywordLabel.text = "Keyword: \(novel?.keyword ?? "")"
    }
}

