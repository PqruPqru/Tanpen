//
//  NovelViewController.swift
//  Tanpen
//
//  Created by まつはる on 2024/05/29.
//

import UIKit

class NovelViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    private let tableView = UITableView()
    private let startWritingButton = UIButton(type: .system)
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
        startWritingButton.setTitle("Start Writing", for: .normal)
        startWritingButton.addTarget(self, action: #selector(showPrompt), for: .touchUpInside)
        startWritingButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(startWritingButton)

        NSLayoutConstraint.activate([
            startWritingButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            startWritingButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            startWritingButton.heightAnchor.constraint(equalToConstant: 50),
            startWritingButton.widthAnchor.constraint(equalToConstant: 200)
        ])
    }

    @objc private func showPrompt() {
        let promptVC = PromptViewController()
        navigationController?.pushViewController(promptVC, animated: true)
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
        return cell
    }

    // MARK: - UITableViewDelegate

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let novel = novels[indexPath.row]
        let detailVC = DetailViewController()
        detailVC.novel = novel
        navigationController?.pushViewController(detailVC, animated: true)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadNovels()
    }
}

