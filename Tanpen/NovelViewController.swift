//
//  NovelViewController.swift
//  Tanpen
//
//  Created by まつはる on 2024/05/29.
//

import UIKit

class NovelViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    private let tableView = UITableView()
    private var novels: [Novel] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Novels"
        view.backgroundColor = .white

        setupTableView()
        setupStartWritingButton()
        loadNovels()
    }

    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.frame = view.bounds
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        view.addSubview(tableView)
    }

    private func setupStartWritingButton() {
        let startWritingButton = UIBarButtonItem(title: "Start Writing", style: .plain, target: self, action: #selector(showPrompt))
        navigationItem.rightBarButtonItem = startWritingButton
    }

    @objc private func showPrompt() {
        let promptVC = PromptViewController()
        promptVC.modalPresentationStyle = .fullScreen
        present(promptVC, animated: true, completion: nil)
    }

    private func loadNovels() {
        novels = NovelStorage.shared.loadNovels()
        tableView.reloadData()
    }

    // MARK: - UITableViewDataSource

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return novels.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let novel = novels[indexPath.row]
        cell.textLabel?.text = novel.title
        cell.detailTextLabel?.text = novel.content
        return cell
    }
}
