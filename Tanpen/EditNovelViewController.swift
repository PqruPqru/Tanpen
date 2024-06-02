//
//  EditNovelViewController.swift
//  Tanpen
//
//  Created by まつはる on 2024/06/02.
//

import UIKit

class EditNovelViewController: UIViewController {
    var novel: Novel?

    private let titleTextField = UITextField()
    private let contentTextView = UITextView()
    private let saveButton = UIButton(type: .system)

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        setupUI()
        displayNovel()
        setupNavigationBar()
    }

    private func setupUI() {
        titleTextField.translatesAutoresizingMaskIntoConstraints = false
        contentTextView.translatesAutoresizingMaskIntoConstraints = false
        saveButton.translatesAutoresizingMaskIntoConstraints = false

        titleTextField.placeholder = "Title"
        titleTextField.borderStyle = .roundedRect

        contentTextView.font = UIFont.systemFont(ofSize: 18)
        contentTextView.layer.borderColor = UIColor.lightGray.cgColor
        contentTextView.layer.borderWidth = 1
        contentTextView.layer.cornerRadius = 8

        saveButton.setTitle("上書き保存", for: .normal)
        saveButton.addTarget(self, action: #selector(saveNovel), for: .touchUpInside)

        view.addSubview(titleTextField)
        view.addSubview(contentTextView)
        view.addSubview(saveButton)

        NSLayoutConstraint.activate([
            titleTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            titleTextField.heightAnchor.constraint(equalToConstant: 40),

            contentTextView.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 20),
            contentTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            contentTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            contentTextView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -60),

            saveButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            saveButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            saveButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }

    private func setupNavigationBar() {
        let barButtonItem = UIBarButtonItem(customView: saveButton)
        navigationItem.rightBarButtonItem = barButtonItem
    }

    private func displayNovel() {
        titleTextField.text = novel?.title
        contentTextView.text = novel?.content
    }

    @objc private func saveNovel() {
        guard let originalNovel = novel,
              let title = titleTextField.text, !title.isEmpty,
              let content = contentTextView.text, !content.isEmpty else { return }

        // 新しいNovelインスタンスを作成して更新
        let updatedNovel = Novel(title: title, content: content, prompt: originalNovel.prompt, wordCount: originalNovel.wordCount, keyword: originalNovel.keyword)
        NovelStorage.shared.updateNovel(original: originalNovel, updated: updatedNovel)

        // 更新通知を送信
        NotificationCenter.default.post(name: NSNotification.Name("novelUpdated"), object: nil)
        self.navigationController?.popToRootViewController(animated: true)
    }
}

//import UIKit
//
//class EditNovelViewController: UIViewController {
//    var novel: Novel?
//
//    private let titleTextField = UITextField()
//    private let contentTextView = UITextView()
//    private let wordCountTextField = UITextField()
//    private let keywordTextField = UITextField()
//    private let saveButton = UIButton(type: .system)
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view.backgroundColor = .white
//
//        setupUI()
//        displayNovel()
//        setupNavigationBar()
//    }
//
//    private func setupUI() {
//        titleTextField.translatesAutoresizingMaskIntoConstraints = false
//        contentTextView.translatesAutoresizingMaskIntoConstraints = false
////        wordCountTextField.translatesAutoresizingMaskIntoConstraints = false
////        keywordTextField.translatesAutoresizingMaskIntoConstraints = false
//
//        titleTextField.placeholder = "Title"
//        titleTextField.borderStyle = .roundedRect
//
//        contentTextView.font = UIFont.systemFont(ofSize: 18)
//        contentTextView.layer.borderColor = UIColor.lightGray.cgColor
//        contentTextView.layer.borderWidth = 1
//        contentTextView.layer.cornerRadius = 8
//
////        wordCountTextField.placeholder = "文字数"
////        wordCountTextField.borderStyle = .roundedRect
////        wordCountTextField.keyboardType = .numberPad
////
////        keywordTextField.placeholder = "キーワード"
////        keywordTextField.borderStyle = .roundedRect
//
//        view.addSubview(titleTextField)
//        view.addSubview(contentTextView)
//        view.addSubview(wordCountTextField)
//        view.addSubview(keywordTextField)
//
//        NSLayoutConstraint.activate([
//            titleTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
//            titleTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
//            titleTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
//            titleTextField.heightAnchor.constraint(equalToConstant: 40),
//
//            contentTextView.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 20),
//            contentTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
//            contentTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
//            contentTextView.heightAnchor.constraint(equalToConstant: 200),
//
////            wordCountTextField.topAnchor.constraint(equalTo: contentTextView.bottomAnchor, constant: 20),
////            wordCountTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
////            wordCountTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
////            wordCountTextField.heightAnchor.constraint(equalToConstant: 40),
////
////            keywordTextField.topAnchor.constraint(equalTo: wordCountTextField.bottomAnchor, constant: 20),
////            keywordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
////            keywordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
////            keywordTextField.heightAnchor.constraint(equalToConstant: 40)
//        ])
//    }
//
//    private func setupNavigationBar() {
//        saveButton.setTitle("上書き保存", for: .normal)
//        saveButton.addTarget(self, action: #selector(saveNovel), for: .touchUpInside)
//
//        let barButtonItem = UIBarButtonItem(customView: saveButton)
//        navigationItem.rightBarButtonItem = barButtonItem
//        
//    }
//
//    private func displayNovel() {
//        titleTextField.text = novel?.title
//        contentTextView.text = novel?.content
//        wordCountTextField.text = "\(novel?.wordCount ?? 0)"
//        keywordTextField.text = novel?.keyword
//    }
//
//    @objc private func saveNovel() {
//        guard let originalNovel = novel,
//              let title = titleTextField.text, !title.isEmpty,
//              let content = contentTextView.text, !content.isEmpty,
//              let wordCountText = wordCountTextField.text, let wordCount = Int(wordCountText),
//              let keyword = keywordTextField.text else { return }
//        
//        // 新しいNovelインスタンスを作成して更新
//        let updatedNovel = Novel(title: title, content: content, prompt: originalNovel.prompt, wordCount: wordCount, keyword: keyword)
//        NovelStorage.shared.updateNovel(original: originalNovel, updated: updatedNovel)
//        
//        // 更新通知を送信
//        NotificationCenter.default.post(name: NSNotification.Name("novelUpdated"), object: nil)
//        
        
