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

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        setupUI()
        displayNovel()
    }

    private func setupUI() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        contentLabel.translatesAutoresizingMaskIntoConstraints = false

        titleLabel.font = UIFont.boldSystemFont(ofSize: 24)
        titleLabel.textAlignment = .center

        contentLabel.font = UIFont.systemFont(ofSize: 18)
        contentLabel.numberOfLines = 0

        view.addSubview(titleLabel)
        view.addSubview(contentLabel)

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            contentLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            contentLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            contentLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            contentLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }

    private func displayNovel() {
        titleLabel.text = novel?.title
        contentLabel.text = novel?.content
    }
}
