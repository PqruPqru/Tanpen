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
    private let contentTextView = UITextView()
    private let wordCountLabel = UILabel()
    private let keywordLabel = UILabel()
    private let promptLabel = UILabel()
    private let shareButton = UIButton(type: .system)
    private let editButton = UIButton(type: .system)
    private let deleteButton = UIButton(type: .system)
    private let buttonStackView = UIStackView() // ボタンをまとめるためのスタックビュー
    private let titleContainerView = UIView()
    private let contentContainerView = UIView()
    private let scrollView = UIScrollView()
    private let containerView = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupBackground()
        setupUI()
        displayNovel()
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
        titleContainerView.translatesAutoresizingMaskIntoConstraints = false
        contentContainerView.translatesAutoresizingMaskIntoConstraints = false
        buttonStackView.translatesAutoresizingMaskIntoConstraints = false

        containerView.backgroundColor = .white
        containerView.layer.cornerRadius = 10
        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.shadowOpacity = 0.2
        containerView.layer.shadowOffset = CGSize(width: 0, height: 2)
        containerView.layer.shadowRadius = 4

        titleContainerView.backgroundColor = .white
        titleContainerView.layer.cornerRadius = 10
        titleContainerView.layer.shadowColor = UIColor.black.cgColor
        titleContainerView.layer.shadowOpacity = 0.2
        titleContainerView.layer.shadowOffset = CGSize(width: 0, height: 2)
        titleContainerView.layer.shadowRadius = 4

        contentContainerView.backgroundColor = .white
        contentContainerView.layer.cornerRadius = 10
        contentContainerView.layer.shadowColor = UIColor.black.cgColor
        contentContainerView.layer.shadowOpacity = 0.2
        contentContainerView.layer.shadowOffset = CGSize(width: 0, height: 2)
        contentContainerView.layer.shadowRadius = 4

        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = UIFont.boldSystemFont(ofSize: 24)
        titleLabel.textAlignment = .center

        contentTextView.translatesAutoresizingMaskIntoConstraints = false
        contentTextView.font = UIFont.systemFont(ofSize: 18)
        contentTextView.isEditable = false
        contentTextView.isScrollEnabled = true
        contentTextView.layer.borderColor = UIColor.lightGray.cgColor
        contentTextView.layer.borderWidth = 1
        contentTextView.layer.cornerRadius = 8

        wordCountLabel.translatesAutoresizingMaskIntoConstraints = false
        wordCountLabel.font = UIFont.systemFont(ofSize: 16)
        wordCountLabel.textAlignment = .center

        keywordLabel.translatesAutoresizingMaskIntoConstraints = false
        keywordLabel.font = UIFont.systemFont(ofSize: 16)
        keywordLabel.textAlignment = .center

        promptLabel.translatesAutoresizingMaskIntoConstraints = false
        promptLabel.font = UIFont.systemFont(ofSize: 16)
        promptLabel.textAlignment = .center

        setupButton(shareButton, title: "共有", action: #selector(shareNovel), imageName: "square.and.arrow.up")
        setupButton(editButton, title: "編集", action: #selector(editNovel))
        setupButton(deleteButton, title: "削除", action: #selector(deleteNovel))

        buttonStackView.axis = .horizontal
        buttonStackView.distribution = .fillEqually
        buttonStackView.spacing = 10
        buttonStackView.addArrangedSubview(shareButton)
        buttonStackView.addArrangedSubview(editButton)
        buttonStackView.addArrangedSubview(deleteButton)

        view.addSubview(scrollView)
        scrollView.addSubview(containerView)
        containerView.addSubview(titleContainerView)
        containerView.addSubview(contentContainerView)
        containerView.addSubview(buttonStackView)
        titleContainerView.addSubview(titleLabel)
        contentContainerView.addSubview(contentTextView)
        containerView.addSubview(wordCountLabel)
        containerView.addSubview(keywordLabel)
        containerView.addSubview(promptLabel)

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            containerView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            containerView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),

            titleContainerView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 20),
            titleContainerView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            titleContainerView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),

            titleLabel.topAnchor.constraint(equalTo: titleContainerView.topAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: titleContainerView.leadingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: titleContainerView.trailingAnchor, constant: -10),
            titleLabel.bottomAnchor.constraint(equalTo: titleContainerView.bottomAnchor, constant: -10),

            contentContainerView.topAnchor.constraint(equalTo: titleContainerView.bottomAnchor, constant: 20),
            contentContainerView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            contentContainerView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),

            contentTextView.topAnchor.constraint(equalTo: contentContainerView.topAnchor, constant: 10),
            contentTextView.leadingAnchor.constraint(equalTo: contentContainerView.leadingAnchor, constant: 10),
            contentTextView.trailingAnchor.constraint(equalTo: contentContainerView.trailingAnchor, constant: -10),
            contentTextView.bottomAnchor.constraint(equalTo: contentContainerView.bottomAnchor, constant: -10),
            contentTextView.heightAnchor.constraint(equalToConstant: 200),

            wordCountLabel.topAnchor.constraint(equalTo: contentContainerView.bottomAnchor, constant: 20),
            wordCountLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            wordCountLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),

            keywordLabel.topAnchor.constraint(equalTo: wordCountLabel.bottomAnchor, constant: 10),
            keywordLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            keywordLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),

            promptLabel.topAnchor.constraint(equalTo: keywordLabel.bottomAnchor, constant: 10),
            promptLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            promptLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),

            buttonStackView.topAnchor.constraint(equalTo: promptLabel.bottomAnchor, constant: 20),
            buttonStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            buttonStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            buttonStackView.heightAnchor.constraint(equalToConstant: 50),
            buttonStackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -20)
        ])
    }

    private func setupButton(_ button: UIButton, title: String, action: Selector, imageName: String? = nil) {
        button.setTitle(title, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor.systemOrange
        button.layer.cornerRadius = 10
        button.addTarget(self, action: action, for: .touchUpInside)

        if let imageName = imageName {
            let image = UIImage(systemName: imageName)
            button.setImage(image, for: .normal)
            button.tintColor = .white
            button.imageView?.contentMode = .scaleAspectFit
            button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -10, bottom: 0, right: 0)
        }
    }

    private func displayNovel() {
        titleLabel.text = novel?.title
        contentTextView.text = novel?.content
        wordCountLabel.text = "字数制限: \(novel?.wordCount ?? 0)"
        keywordLabel.text = "\(novel?.keyword ?? "")"
        promptLabel.text = "お題: \(novel?.prompt ?? "")"
    }

    @objc private func shareNovel() {
        guard let title = novel?.title, let content = novel?.content else { return }
        let shareText = "タイトル: \(title)\n\n\(content)"
        let activityViewController = UIActivityViewController(activityItems: [shareText], applicationActivities: nil)
        present(activityViewController, animated: true, completion: nil)
    }

    @objc private func editNovel() {
        let editVC = EditNovelViewController()
        editVC.novel = novel
        navigationController?.pushViewController(editVC, animated: true)
    }

    @objc private func deleteNovel() {
        let alert = UIAlertController(title: "注意", message: "この作品をどうする？", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "くしゃくしゃにする", style: .destructive, handler: { _ in
            self.confirmDeleteNovel()
        }))
        alert.addAction(UIAlertAction(title: "まだ保管する", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }

    private func confirmDeleteNovel() {
        guard let novel = novel else { return }
        NovelStorage.shared.deleteNovel(novel)
        navigationController?.popViewController(animated: true)
    }
}







// UIColor extension to define a custom dark blue color
//extension UIColor {
//    static func darkBlueColor() -> UIColor {
//        return UIColor(red: 0/255, green: 0/255, blue: 139/255, alpha: 1.0) // Dark blue color
//    }
//}




//guard let　は次の関数の値がnilではない場合に実行する
//オプショナル型は、nilを含む
