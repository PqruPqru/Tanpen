//
//  EditNovelViewController.swift
//  Tanpen
//
//  Created by まつはる on 2024/06/02.
//
import UIKit

class EditNovelViewController: UIViewController, UITextViewDelegate, UITextFieldDelegate {
    var novel: Novel?

    private let titleTextField = UITextField()
    private let contentTextView = UITextView()
    private let saveButton = UIButton(type: .system)
    private let containerView = UIView()
    private let wordCountLabel = UILabel()
    private let keywordLabel = UILabel()
    private let charCountLabel = UILabel()
    private let charCountContainer = UIView()
    private let scrollView = UIScrollView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupBackground()
        setupUI()
        displayNovel()
        contentTextView.delegate = self
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

        titleTextField.translatesAutoresizingMaskIntoConstraints = false
        contentTextView.translatesAutoresizingMaskIntoConstraints = false
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        wordCountLabel.translatesAutoresizingMaskIntoConstraints = false
        keywordLabel.translatesAutoresizingMaskIntoConstraints = false
        charCountLabel.translatesAutoresizingMaskIntoConstraints = false
        charCountContainer.translatesAutoresizingMaskIntoConstraints = false

        titleTextField.placeholder = "タイトルを入れよう！"
        titleTextField.borderStyle = .roundedRect

        contentTextView.font = UIFont.systemFont(ofSize: 18)
        contentTextView.layer.borderColor = UIColor.lightGray.cgColor
        contentTextView.layer.borderWidth = 1
        contentTextView.layer.cornerRadius = 8
        contentTextView.isScrollEnabled = true

        wordCountLabel.font = UIFont.systemFont(ofSize: 16)
        wordCountLabel.textAlignment = .center

        keywordLabel.font = UIFont.systemFont(ofSize: 16)
        keywordLabel.textAlignment = .center

        charCountLabel.font = UIFont.systemFont(ofSize: 14)
        charCountLabel.textAlignment = .right

        charCountContainer.backgroundColor = .white
        charCountContainer.layer.cornerRadius = 8
        charCountContainer.layer.borderColor = UIColor.lightGray.cgColor
        charCountContainer.layer.borderWidth = 1

        charCountContainer.addSubview(charCountLabel)
        containerView.addSubview(wordCountLabel)
        containerView.addSubview(keywordLabel)
        scrollView.addSubview(containerView)
        scrollView.addSubview(titleTextField)
        scrollView.addSubview(contentTextView)
        scrollView.addSubview(saveButton)
        scrollView.addSubview(charCountContainer)
        view.addSubview(scrollView)

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            containerView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20),
            containerView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            containerView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -40),

            wordCountLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 20),
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

            contentTextView.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 20),
            contentTextView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            contentTextView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -40),
            contentTextView.heightAnchor.constraint(equalToConstant: 200),

            charCountContainer.topAnchor.constraint(equalTo: contentTextView.bottomAnchor, constant: 10),
            charCountContainer.trailingAnchor.constraint(equalTo: contentTextView.trailingAnchor),
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
        
        setupButton(saveButton, title: "書き上げた！", color: .systemOrange, action: #selector(updateNovel))
    }

    private func setupButton(_ button: UIButton, title: String, color: UIColor, action: Selector) {
        button.setTitle(title, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = color
        button.layer.cornerRadius = 10
        button.contentEdgeInsets = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
        button.addTarget(self, action: action, for: .touchUpInside)
    }

    private func displayNovel() {
        titleTextField.text = novel?.title
        contentTextView.text = novel?.content
        wordCountLabel.text = "字数制限: \(novel?.wordCount ?? 0)"
        keywordLabel.text = "\(novel?.keyword ?? "")"
    }

    @objc private func updateNovel() {
        guard let title = titleTextField.text, !title.isEmpty,
              let content = contentTextView.text, !content.isEmpty else { return }

        if let wordCount = novel?.wordCount, content.count < wordCount - 50 || content.count > wordCount + 50 {
            let alert = UIAlertController(title: "お願い！", message: "指定された字数制限の前後50文字に収めてね！", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "はい！", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            return
        }

        let updatedNovel = Novel(title: title, content: content, prompt: novel?.prompt ?? "", wordCount: novel?.wordCount ?? 0, keyword: novel?.keyword ?? "")

        if let originalNovel = novel {
            NovelStorage.shared.updateNovel(original: originalNovel, updated: updatedNovel)
        }
        self.navigationController?.popToRootViewController(animated: true)
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
        if let wordCount = novel?.wordCount {
            let currentWordCount = contentTextView.text.count
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
        
