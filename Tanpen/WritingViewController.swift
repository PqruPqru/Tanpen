//
//  WritingViewController.swift
//  Tanpen
//
//  Created by まつはる on 2024/05/29.
//
import UIKit

class WritingViewController: UIViewController {
    private let titleTextField = UITextField()
    private let textView = UITextView()
    var prompt: String?
    var wordCount: Int?
    var keyword: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        setupTitleTextField()
        setupTextView()
        setupNavigationBar()
    }

    private func setupTitleTextField() {
        titleTextField.translatesAutoresizingMaskIntoConstraints = false
        titleTextField.placeholder = "Enter title here"
        titleTextField.font = UIFont.systemFont(ofSize: 24)
        titleTextField.borderStyle = .roundedRect
        view.addSubview(titleTextField)
        
        NSLayoutConstraint.activate([
            titleTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            titleTextField.heightAnchor.constraint(equalToConstant: 40)
        ])
    }

    private func setupTextView() {
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = UIFont.systemFont(ofSize: 18)
        textView.text = prompt ?? "Start writing your story here..."
        view.addSubview(textView)
        
        NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 20),
            textView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            textView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            textView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }

    private func setupNavigationBar() {
        self.title = "Write Your Novel"
        let saveButton = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveNovel))
        navigationItem.rightBarButtonItem = saveButton
    }

    @objc private func saveNovel() {
        guard let title = titleTextField.text, !title.isEmpty,
              let content = textView.text, !content.isEmpty else { return }
        let novel = Novel(title: title, content: content)
        NovelStorage.shared.saveNovel(novel)
        navigationController?.popToRootViewController(animated: true)
    }
}
