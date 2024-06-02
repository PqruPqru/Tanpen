//
//  DetailViewController.swift
//  Tanpen
//
//  Created by まつはる on 2024/05/30.
//

import UIKit

class DetailViewController: UIViewController, UITabBarDelegate {
    var novel: Novel?

    private let titleLabel = UILabel()
    private let contentLabel = UILabel()
    private let shareButton = UIButton(type: .system)
    private let editButton = UIButton(type: .system)
    private let deleteButton = UIButton(type: .system)
    private let tabBar = UITabBar()
    private let wordCountItem = UITabBarItem(title: "字数制限", image: nil, tag: 0)
    private let keywordItem = UITabBarItem(title: "キーワード", image: nil, tag: 1)
    private let tabContentLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        setupUI()
        displayNovel()
    }

    private func setupUI() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        contentLabel.translatesAutoresizingMaskIntoConstraints = false
        shareButton.translatesAutoresizingMaskIntoConstraints = false
        editButton.translatesAutoresizingMaskIntoConstraints = false
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        tabBar.translatesAutoresizingMaskIntoConstraints = false
        tabContentLabel.translatesAutoresizingMaskIntoConstraints = false

        titleLabel.font = UIFont.boldSystemFont(ofSize: 24)
        titleLabel.textAlignment = .center

        contentLabel.font = UIFont.systemFont(ofSize: 18)
        contentLabel.numberOfLines = 0
        contentLabel.textAlignment = .center

        shareButton.setTitle("共有", for: .normal)
        shareButton.addTarget(self, action: #selector(shareNovel), for: .touchUpInside)

        editButton.setTitle("編集", for: .normal)
        editButton.addTarget(self, action: #selector(editNovel), for: .touchUpInside)

        deleteButton.setTitle("削除", for: .normal)
        deleteButton.addTarget(self, action: #selector(deleteNovel), for: .touchUpInside)

        tabBar.items = [wordCountItem, keywordItem]
        tabBar.delegate = self

        tabContentLabel.font = UIFont.systemFont(ofSize: 18)
        tabContentLabel.textAlignment = .center

        view.addSubview(titleLabel)
        view.addSubview(contentLabel)
        view.addSubview(tabBar)
        view.addSubview(tabContentLabel)
        view.addSubview(shareButton)
        view.addSubview(editButton)
        view.addSubview(deleteButton)

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            contentLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            contentLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            contentLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            tabBar.topAnchor.constraint(equalTo: contentLabel.bottomAnchor, constant: 20),
            tabBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tabBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),

            tabContentLabel.topAnchor.constraint(equalTo: tabBar.bottomAnchor, constant: 20),
            tabContentLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tabContentLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),

            shareButton.topAnchor.constraint(equalTo: tabContentLabel.bottomAnchor, constant: 20),
            shareButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            editButton.topAnchor.constraint(equalTo: shareButton.bottomAnchor, constant: 20),
            editButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            deleteButton.topAnchor.constraint(equalTo: editButton.bottomAnchor, constant: 20),
            deleteButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            deleteButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }

    private func displayNovel() {
        titleLabel.text = novel?.title
        contentLabel.text = novel?.content
        tabBar.selectedItem = wordCountItem
        updateTabContent()
    }

    private func updateTabContent() {
        guard let selectedItem = tabBar.selectedItem else { return }
        switch selectedItem {
        case wordCountItem:
            tabContentLabel.text = "字数制限: \(novel?.wordCount ?? 0)"
        case keywordItem:
            tabContentLabel.text = novel?.keyword
        default:
            break
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
        let alert = UIAlertController(title: "確認", message: "この作品をどうする？", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "くしゃくしゃにする", style: .destructive, handler: { _ in
            self.confirmDeleteNovel()
        }))
        alert.addAction(UIAlertAction(title: "保管しておく", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }

    private func confirmDeleteNovel() {
        guard let novel = novel else { return }
        NovelStorage.shared.deleteNovel(novel)
        navigationController?.popViewController(animated: true)
    }

    // UITabBarDelegate
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        updateTabContent()
    }
}


//guard let　は次の関数の値がnilではない場合に実行する
//オプショナル型は、nilを含む
