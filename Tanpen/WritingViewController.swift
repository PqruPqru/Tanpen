//
//  WritingViewController.swift
//  Tanpen
//
//  Created by まつはる on 2024/05/29.
//

import UIKit

class WritingViewController: UIViewController {
    private let textView = UITextView()
    private let saveButton = UIButton(type: .system)
    private let backButton = UIButton(type: .system)
    var prompt: String?
    var wordCount: Int?
    var keyword: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        setupTextView()
        setupButtons()
        setupConstraints()
    }

    private func setupTextView() {
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = UIFont.systemFont(ofSize: 18)
        textView.text = prompt ?? "Start writing your story here..."
        view.addSubview(textView)
    }

    private func setupButtons() {
        saveButton.setTitle("Save", for: .normal)
        saveButton.addTarget(self, action: #selector(saveNovel), for: .touchUpInside)
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(saveButton)

        backButton.setTitle("Back to Prompt", for: .normal)
        backButton.addTarget(self, action: #selector(backToPrompt), for: .touchUpInside)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(backButton)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            textView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            textView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            textView.bottomAnchor.constraint(equalTo: saveButton.topAnchor, constant: -20),

            saveButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            saveButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),

            backButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            backButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }

    @objc private func saveNovel() {
        guard let content = textView.text, !content.isEmpty else { return }
        let novel = Novel(title: "New Novel", content: content)
        NovelStorage.shared.saveNovel(novel)
        navigationController?.popToRootViewController(animated: true)
    }

    @objc private func backToPrompt() {
        navigationController?.popViewController(animated: true)
    }
}
