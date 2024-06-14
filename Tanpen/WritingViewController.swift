//
//  WritingViewController.swift
//  Tanpen
//
//  Created by まつはる on 2024/05/29.
//
import UIKit

class WritingViewController: UIViewController, UITextViewDelegate, UITextFieldDelegate {
    
    var prompt: String?
    var wordCount: Int?
    var keyword: String?
    
    private let promptLabel = UILabel()
    private let wordCountLabel = UILabel()
    private let keywordLabel = UILabel()
    private let titleTextField = UITextField()
    private let textView = UITextView()
    private let saveButton = UIButton(type: .system)
    private let containerView = UIView()
    private let charCountLabel = UILabel()
    private let charCountContainer = UIView()
    private let scrollView = UIScrollView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupBackground()
        setupUI()
        displayPrompt()
        textView.delegate = self
        titleTextField.delegate = self
        setupGesture()
        setupKeyboardObservers()
    }

    private func setupBackground() {
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "アプリ背景画像２.jpeg")
        backgroundImage.contentMode = .scaleAspectFill
        view.addSubview(backgroundImage)
        view.sendSubviewToBack(backgroundImage)
    }

    private func setupUI() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.backgroundColor = .white
        containerView.layer.cornerRadius = 10
        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.shadowOpacity = 0.2
        containerView.layer.shadowOffset = CGSize(width: 0, height: 2)
        containerView.layer.shadowRadius = 4

        promptLabel.translatesAutoresizingMaskIntoConstraints = false
        wordCountLabel.translatesAutoresizingMaskIntoConstraints = false
        keywordLabel.translatesAutoresizingMaskIntoConstraints = false
        titleTextField.translatesAutoresizingMaskIntoConstraints = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        charCountLabel.translatesAutoresizingMaskIntoConstraints = false
        charCountContainer.translatesAutoresizingMaskIntoConstraints = false

        promptLabel.font = UIFont.systemFont(ofSize: 18)
        promptLabel.textAlignment = .center
        promptLabel.numberOfLines = 0

        wordCountLabel.font = UIFont.systemFont(ofSize: 16)
        wordCountLabel.textAlignment = .center

        keywordLabel.font = UIFont.systemFont(ofSize: 16)
        keywordLabel.textAlignment = .center

        titleTextField.placeholder = "タイトル"
        titleTextField.borderStyle = .roundedRect

        textView.font = UIFont.systemFont(ofSize: 18)
        textView.layer.borderColor = UIColor.lightGray.cgColor
        textView.layer.borderWidth = 1
        textView.layer.cornerRadius = 8
        textView.isScrollEnabled = true

        charCountLabel.font = UIFont.systemFont(ofSize: 14)
        charCountLabel.textAlignment = .right

        charCountContainer.backgroundColor = .white
        charCountContainer.layer.cornerRadius = 8
        charCountContainer.layer.borderColor = UIColor.lightGray.cgColor
        charCountContainer.layer.borderWidth = 1

        charCountContainer.addSubview(charCountLabel)
        containerView.addSubview(promptLabel)
        containerView.addSubview(wordCountLabel)
        containerView.addSubview(keywordLabel)
        scrollView.addSubview(containerView)
        scrollView.addSubview(titleTextField)
        scrollView.addSubview(textView)
        scrollView.addSubview(charCountContainer)
        scrollView.addSubview(saveButton)
        view.addSubview(scrollView)

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            containerView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20),
            containerView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            containerView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -40),
            
            promptLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 20),
            promptLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            promptLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),

            wordCountLabel.topAnchor.constraint(equalTo: promptLabel.bottomAnchor, constant: 10),
            wordCountLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            wordCountLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),

            keywordLabel.topAnchor.constraint(equalTo: wordCountLabel.bottomAnchor, constant: 10),
            keywordLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            keywordLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            keywordLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -20),

            titleTextField.topAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 20),
            titleTextField.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            titleTextField.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -40),
            titleTextField.heightAnchor.constraint(equalToConstant: 40),

            textView.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 20),
            textView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            textView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -40),
            textView.heightAnchor.constraint(equalToConstant: 200),

            charCountContainer.topAnchor.constraint(equalTo: textView.bottomAnchor, constant: 10),
            charCountContainer.trailingAnchor.constraint(equalTo: textView.trailingAnchor),
            charCountContainer.widthAnchor.constraint(equalToConstant: 100),
            charCountContainer.heightAnchor.constraint(equalToConstant: 30),

            charCountLabel.centerYAnchor.constraint(equalTo: charCountContainer.centerYAnchor),
            charCountLabel.leadingAnchor.constraint(equalTo: charCountContainer.leadingAnchor, constant: 10),
            charCountLabel.trailingAnchor.constraint(equalTo: charCountContainer.trailingAnchor, constant: -10),

            saveButton.topAnchor.constraint(equalTo: charCountContainer.bottomAnchor, constant: 20),
            saveButton.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            saveButton.heightAnchor.constraint(equalToConstant: 50),
            saveButton.widthAnchor.constraint(equalToConstant: 200),
            saveButton.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -20)
        ])
        
        setupButton(saveButton, title: "書き上げた！", color: .systemOrange, action: #selector(saveNovel))
    }

    private func setupButton(_ button: UIButton, title: String, color: UIColor, action: Selector) {
        button.setTitle(title, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = color
        button.layer.cornerRadius = 10
        button.contentEdgeInsets = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
        button.addTarget(self, action: action, for: .touchUpInside)
    }

    private func displayPrompt() {
        promptLabel.text = "お題: \(prompt ?? "")"
        wordCountLabel.text = "字数制限: \(wordCount ?? 0)"
        keywordLabel.text = "\(keyword ?? "")"
    }

    @objc private func saveNovel() {
        guard let title = titleTextField.text, !title.isEmpty,
              let contentText = textView.text, !contentText.isEmpty else { return }

        if let wordCount = wordCount, contentText.count < wordCount - 50 || contentText.count > wordCount + 50 {
            let alert = UIAlertController(title: "お願い！", message: "指定された字数制限の前後50文字に収めてね！", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "はい！", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            return
        }

        let newNovel = Novel(title: title, content: contentText, prompt: prompt ?? "", wordCount: wordCount ?? 0, keyword: keyword ?? "")
        NovelStorage.shared.saveNovel(newNovel)
        NotificationCenter.default.post(name: NSNotification.Name("novelUpdated"), object: nil)
        navigationController?.popViewController(animated: true)
    }

    func textViewDidChange(_ textView: UITextView) {
        checkWordCount()
        charCountLabel.text = "文字数: \(textView.text.count)"
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        checkWordCount()
        textField.resignFirstResponder()
    }

    private func checkWordCount() {
        if let wordCount = wordCount {
            let currentWordCount = textView.text.count
            if currentWordCount >= wordCount - 50 && currentWordCount <= wordCount + 50 {
                saveButton.isEnabled = true
            } else {
                saveButton.isEnabled = false
            }
        }
    }

    private func setupGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }

    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }

    private func setupKeyboardObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    @objc private func keyboardWillShow(notification: NSNotification) {
        if let userInfo = notification.userInfo, let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
            let keyboardHeight = keyboardFrame.height
            scrollView.contentInset.bottom = keyboardHeight
            scrollView.scrollIndicatorInsets.bottom = keyboardHeight
        }
    }

    @objc private func keyboardWillHide(notification: NSNotification) {
        scrollView.contentInset.bottom = 0
        scrollView.scrollIndicatorInsets.bottom = 0
    }
}
