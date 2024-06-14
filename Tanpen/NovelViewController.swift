//
//  NovelViewController.swift
//  Tanpen
//
//  Created by まつはる on 2024/05/29.
//

import UIKit

class NovelViewController: BaseViewController, UITableViewDataSource, UITableViewDelegate {
    private let tableView = UITableView()
    private let startWritingButton = UIButton(type: .system)
    private var novels: [Novel] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "短編工房"
        view.backgroundColor = .white
        
        setupTableView()
        setupStartWritingButton()
        loadNovels()

        // 通知の設定
        NotificationCenter.default.addObserver(self, selector: #selector(loadNovels), name: NSNotification.Name("novelUpdated"), object: nil)
    }

    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name("novelUpdated"), object: nil)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadNovels()
    }

    private func setupTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        view.addSubview(tableView)

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor) // ボタンとの衝突を回避
        ])
    }

    private func setupStartWritingButton() {
        startWritingButton.setTitle("書き始める", for: .normal)
        startWritingButton.addTarget(self, action: #selector(showPrompt), for: .touchUpInside)
        startWritingButton.translatesAutoresizingMaskIntoConstraints = false
        startWritingButton.backgroundColor = UIColor.systemOrange // ボタンの背景色を設定
        startWritingButton.setTitleColor(.white, for: .normal) // ボタンの文字色を設定
        startWritingButton.layer.cornerRadius = 10 // ボタンの角を丸める
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

    @objc private func loadNovels() {
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
}
