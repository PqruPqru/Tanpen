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
    private let wordCountLabel = UILabel()
    private let keywordLabel = UILabel()
    private let shareButton = UIButton(type: .system)

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        setupUI()
        displayNovel()
    }

    private func setupUI() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        contentLabel.translatesAutoresizingMaskIntoConstraints = false
        wordCountLabel.translatesAutoresizingMaskIntoConstraints = false
        keywordLabel.translatesAutoresizingMaskIntoConstraints = false
        shareButton.translatesAutoresizingMaskIntoConstraints = false

        titleLabel.font = UIFont.boldSystemFont(ofSize: 24)
        titleLabel.textAlignment = .center

        contentLabel.font = UIFont.systemFont(ofSize: 18)
        contentLabel.numberOfLines = 0

        wordCountLabel.font = UIFont.systemFont(ofSize: 16)
        wordCountLabel.textAlignment = .center

        keywordLabel.font = UIFont.systemFont(ofSize: 16)
        keywordLabel.textAlignment = .center

        shareButton.setTitle("Share", for: .normal)
        shareButton.addTarget(self, action: #selector(shareNovel), for: .touchUpInside)

        view.addSubview(titleLabel)
        view.addSubview(contentLabel)
        view.addSubview(wordCountLabel)
        view.addSubview(keywordLabel)
        view.addSubview(shareButton)

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            wordCountLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            wordCountLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            wordCountLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            keywordLabel.topAnchor.constraint(equalTo: wordCountLabel.bottomAnchor, constant: 10),
            keywordLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            keywordLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            contentLabel.topAnchor.constraint(equalTo: keywordLabel.bottomAnchor, constant: 20),
            contentLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            contentLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            shareButton.topAnchor.constraint(equalTo: contentLabel.bottomAnchor, constant: 20),
            shareButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            shareButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }

    private func displayNovel() {
        titleLabel.text = novel?.title
        contentLabel.text = novel?.content
        wordCountLabel.text = "Word Count: \(novel?.wordCount ?? 0)"
        keywordLabel.text = "Keyword: \(novel?.keyword ?? "")"
    }

    @objc private func shareNovel() {
        guard let title = novel?.title, let content = novel?.content else { return }
        let shareText = "Title: \(title)\n\n\(content)"
        let activityViewController = UIActivityViewController(activityItems: [shareText], applicationActivities: nil)
        present(activityViewController, animated: true, completion: nil)
    }
}
