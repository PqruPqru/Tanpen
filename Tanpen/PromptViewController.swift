//
//  PromptViewController.swift
//  Tanpen
//
//  Created by まつはる on 2024/05/29.
//
import UIKit

class PromptViewController: UIViewController {
    private let promptLabel = UILabel()
    private let wordCountLabel = UILabel()
    private let keywordLabel = UILabel()
    private let regenerateButton = UIButton()
    private let startWritingButton = UIButton()

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
        regenerateButton.translatesAutoresizingMaskIntoConstraints = false
        startWritingButton.translatesAutoresizingMaskIntoConstraints = false

        promptLabel.textAlignment = .center
        promptLabel.numberOfLines = 0
        promptLabel.font = UIFont.systemFont(ofSize: 24)
        
        wordCountLabel.textAlignment = .center
        wordCountLabel.font = UIFont.systemFont(ofSize: 20)
        
        keywordLabel.textAlignment = .center
        keywordLabel.font = UIFont.systemFont(ofSize: 20)
        
        regenerateButton.setTitle("Regenerate", for: .normal)
        regenerateButton.setTitleColor(.systemBlue, for: .normal)
        regenerateButton.addTarget(self, action: #selector(regeneratePrompt), for: .touchUpInside)

        startWritingButton.setTitle("Start Writing", for: .normal)
        startWritingButton.setTitleColor(.systemBlue, for: .normal)
        startWritingButton.addTarget(self, action: #selector(startWriting), for: .touchUpInside)

        view.addSubview(promptLabel)
        view.addSubview(wordCountLabel)
        view.addSubview(keywordLabel)
        view.addSubview(regenerateButton)
        view.addSubview(startWritingButton)

        NSLayoutConstraint.activate([
            promptLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            promptLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -100),
            promptLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            promptLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            wordCountLabel.topAnchor.constraint(equalTo: promptLabel.bottomAnchor, constant: 20),
            wordCountLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            keywordLabel.topAnchor.constraint(equalTo: wordCountLabel.bottomAnchor, constant: 20),
            keywordLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            regenerateButton.topAnchor.constraint(equalTo: keywordLabel.bottomAnchor, constant: 20),
            regenerateButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            startWritingButton.topAnchor.constraint(equalTo: regenerateButton.bottomAnchor, constant: 20),
            startWritingButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
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

    @objc private func regeneratePrompt() {
        generateRandomPrompt()
    }

    @objc private func startWriting() {
        let writingVC = WritingViewController()
        writingVC.prompt = promptLabel.text
        writingVC.wordCount = Int(wordCountLabel.text?.components(separatedBy: ": ").last ?? "")
        writingVC.keyword = keywordLabel.text
        navigationController?.pushViewController(writingVC, animated: true)
    }
}

