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
    private let shareButton = UIButton(type: .system)
    private let editButton = UIButton(type: .system)
    private let deleteButton = UIButton(type: .system)
    private let segmentedControl = UISegmentedControl(items: ["字数制限", "キーワード"])

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        setupUI()
        displayNovel()
    }

    private func setupUI() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        contentTextView.translatesAutoresizingMaskIntoConstraints = false
        wordCountLabel.translatesAutoresizingMaskIntoConstraints = false
        keywordLabel.translatesAutoresizingMaskIntoConstraints = false
        shareButton.translatesAutoresizingMaskIntoConstraints = false
        editButton.translatesAutoresizingMaskIntoConstraints = false
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false

        titleLabel.font = UIFont.boldSystemFont(ofSize: 24)
        titleLabel.textAlignment = .center

        contentTextView.font = UIFont.systemFont(ofSize: 18)
        contentTextView.isEditable = false
        contentTextView.isScrollEnabled = true
        contentTextView.layer.borderColor = UIColor.lightGray.cgColor
        contentTextView.layer.borderWidth = 1
        contentTextView.layer.cornerRadius = 8

        wordCountLabel.font = UIFont.systemFont(ofSize: 16)
        wordCountLabel.textAlignment = .center

        keywordLabel.font = UIFont.systemFont(ofSize: 16)
        keywordLabel.textAlignment = .center

        shareButton.setTitle("共有", for: .normal)
        if let shareImage = UIImage(systemName: "square.and.arrow.up") {
            shareButton.setImage(shareImage, for: .normal)
            shareButton.imageView?.contentMode = .scaleAspectFit
            shareButton.tintColor = .darkBlueColor()
        }
        shareButton.layer.borderColor = UIColor.darkBlueColor().cgColor
        shareButton.layer.borderWidth = 1
        shareButton.layer.cornerRadius = 5
        shareButton.setTitleColor(.darkBlueColor(), for: .normal)
        shareButton.contentEdgeInsets = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
        shareButton.addTarget(self, action: #selector(shareNovel), for: .touchUpInside)

        editButton.setTitle("編集", for: .normal)
        editButton.layer.borderColor = UIColor.darkBlueColor().cgColor
        editButton.layer.borderWidth = 1
        editButton.layer.cornerRadius = 5
        editButton.setTitleColor(.darkBlueColor(), for: .normal)
        editButton.contentEdgeInsets = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
        editButton.addTarget(self, action: #selector(editNovel), for: .touchUpInside)

        deleteButton.setTitle("削除", for: .normal)
        deleteButton.layer.borderColor = UIColor.darkBlueColor().cgColor
        deleteButton.layer.borderWidth = 1
        deleteButton.layer.cornerRadius = 5
        deleteButton.setTitleColor(.darkBlueColor(), for: .normal)
        deleteButton.contentEdgeInsets = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
        deleteButton.addTarget(self, action: #selector(deleteNovel), for: .touchUpInside)

        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: #selector(segmentedControlChanged), for: .valueChanged)

        view.addSubview(segmentedControl)
        view.addSubview(wordCountLabel)
        view.addSubview(titleLabel)
        view.addSubview(contentTextView)
        view.addSubview(keywordLabel)
        view.addSubview(shareButton)
        view.addSubview(editButton)
        view.addSubview(deleteButton)

        NSLayoutConstraint.activate([
            segmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            segmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            segmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            wordCountLabel.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 20),
            wordCountLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            wordCountLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            titleLabel.topAnchor.constraint(equalTo: wordCountLabel.bottomAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            keywordLabel.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 20),
            keywordLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            keywordLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            contentTextView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            contentTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            contentTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            contentTextView.bottomAnchor.constraint(equalTo: shareButton.topAnchor, constant: -20),

            shareButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            shareButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            shareButton.heightAnchor.constraint(equalToConstant: 44), // 追加: 共有ボタンの高さを設定

            editButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            editButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            editButton.heightAnchor.constraint(equalTo: shareButton.heightAnchor), // 追加: 共有ボタンと同じ高さに設定

            deleteButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            deleteButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            deleteButton.heightAnchor.constraint(equalTo: shareButton.heightAnchor) // 追加: 共有ボタンと同じ高さに設定
        ])
    }

    private func displayNovel() {
        titleLabel.text = novel?.title
        contentTextView.text = novel?.content
        updateSegmentedControl()
    }

    @objc private func segmentedControlChanged() {
        updateSegmentedControl()
    }

    private func updateSegmentedControl() {
        let selectedIndex = segmentedControl.selectedSegmentIndex
        wordCountLabel.isHidden = selectedIndex != 0
        keywordLabel.isHidden = selectedIndex != 1
        if selectedIndex == 0 {
            wordCountLabel.text = "字数制限: \(novel?.wordCount ?? 0)"
        } else {
            keywordLabel.text = novel?.keyword
        }
    }

    @objc private func shareNovel() {
        guard let title = novel?.title, let content = novel?.content else { return }
        let shareText = "Title: \(title)\n\n\(content)"
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
extension UIColor {
    static func darkBlueColor() -> UIColor {
        return UIColor(red: 0/255, green: 0/255, blue: 139/255, alpha: 1.0) // Dark blue color
    }
}



//guard let　は次の関数の値がnilではない場合に実行する
//オプショナル型は、nilを含む
