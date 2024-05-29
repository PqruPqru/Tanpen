//
//  PromptViewController.swift
//  Tanpen
//
//  Created by まつはる on 2024/05/29.
//
import Foundation
import UIKit

class PromptViewController: UIViewController {
    private let promptLabel = UILabel()
    private let wordCountLabel = UILabel()
    private let keywordLabel = UILabel()
    private let closeButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        generateRandomPrompt()
    }

    private func setupUI() {
        promptLabel.translatesAutoresizingMaskIntoConstraints = false
        wordCountLabel.translatesAutoresizingMaskIntoConstraints = false
        keywordLabel.translatesAutoresizingMaskIntoConstraints = false
        closeButton.translatesAutoresizingMaskIntoConstraints = false

        promptLabel.textAlignment = .center
        promptLabel.numberOfLines = 0
        promptLabel.font = UIFont.systemFont(ofSize: 24)
        
        wordCountLabel.textAlignment = .center
        wordCountLabel.font = UIFont.systemFont(ofSize: 20)
        
        keywordLabel.textAlignment = .center
        keywordLabel.font = UIFont.systemFont(ofSize: 20)
        
        closeButton.setTitle("Close", for: .normal)
        closeButton.setTitleColor(.systemBlue, for: .normal)
        closeButton.addTarget(self, action: #selector(closePrompt), for: .touchUpInside)

        view.addSubview(promptLabel)
        view.addSubview(wordCountLabel)
        view.addSubview(keywordLabel)
        view.addSubview(closeButton)

        NSLayoutConstraint.activate([
            promptLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            promptLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -80),
            promptLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            promptLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            wordCountLabel.topAnchor.constraint(equalTo: promptLabel.bottomAnchor, constant: 20),
            wordCountLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            keywordLabel.topAnchor.constraint(equalTo: wordCountLabel.bottomAnchor, constant: 20),
            keywordLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            closeButton.topAnchor.constraint(equalTo: keywordLabel.bottomAnchor, constant: 40),
            closeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }

    private func generateRandomPrompt() {
        let prompts = ["3分間に起きた出来事", "コメディ", "ちょっと怖いと思うお話"]
        let keywords = ["りんご", "マグマ", "人魚", "木の棒"]
        let randomPrompt = prompts.randomElement() ?? "コメディ"
        let randomKeyword = keywords.randomElement() ?? "りんご"
        let randomWordCount = Int.random(in: 300...1000)
        
        promptLabel.text = randomPrompt
        wordCountLabel.text = "Word count: \(randomWordCount)"
        keywordLabel.text = "Keyword: \(randomKeyword)"
    }

    @objc private func closePrompt() {
        dismiss(animated: true, completion: nil)
    }
}

