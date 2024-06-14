//
//  PromptViewController.swift
//  Tanpen
//
//  Created by まつはる on 2024/05/29.

import UIKit

class PromptViewController: BaseViewController {
    private let promptLabel = UILabel()
    private let wordCountLabel = UILabel()
    private let keywordLabel = UILabel()
    private let regenerateButton = UIButton(type: .system)
    private let startWritingButton = UIButton(type: .system)
    private let containerView = UIView() // 追加: 白塗りつぶしの枠

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        generateRandomPrompt()
    }

    private func setupUI() {
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
        regenerateButton.translatesAutoresizingMaskIntoConstraints = false
        startWritingButton.translatesAutoresizingMaskIntoConstraints = false

        promptLabel.textAlignment = .center
        promptLabel.numberOfLines = 0
        promptLabel.font = UIFont.systemFont(ofSize: 24)
        
        wordCountLabel.textAlignment = .center
        wordCountLabel.font = UIFont.systemFont(ofSize: 20)
        
        keywordLabel.textAlignment = .center
        keywordLabel.font = UIFont.systemFont(ofSize: 20)
        
        setupButton(regenerateButton, title: "条件リセット！")
        setupButton(startWritingButton, title: "これで書く！")

        view.addSubview(containerView)
        containerView.addSubview(promptLabel)
        containerView.addSubview(wordCountLabel)
        containerView.addSubview(keywordLabel)
        view.addSubview(regenerateButton)
        view.addSubview(startWritingButton)

        NSLayoutConstraint.activate([
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -100),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            containerView.heightAnchor.constraint(greaterThanOrEqualToConstant: 150),

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

            regenerateButton.topAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 20),
            regenerateButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            regenerateButton.heightAnchor.constraint(equalToConstant: 44),
            regenerateButton.widthAnchor.constraint(equalToConstant: 200),

            startWritingButton.topAnchor.constraint(equalTo: regenerateButton.bottomAnchor, constant: 20),
            startWritingButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            startWritingButton.heightAnchor.constraint(equalToConstant: 44),
            startWritingButton.widthAnchor.constraint(equalToConstant: 200)
        ])
    }

    private func setupButton(_ button: UIButton, title: String) {
        button.setTitle(title, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor.systemOrange
        button.layer.cornerRadius = 10
        button.contentEdgeInsets = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
        button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
    }

    @objc private func buttonTapped(_ sender: UIButton) {
        if sender == regenerateButton {
            regeneratePrompt()
        } else if sender == startWritingButton {
            startWriting()
        }
    }

    private func generateRandomPrompt() {
         let prompts = ["3分間に起きた出来事", "多分コメディだと思う話", "消えたペットを探す冒険", "古びた日記に隠された秘密", "魔法のアイテムを見つけた日常", "幼馴染と再会して始まる新たな旅", "不可解な夢の謎を解く", "異世界に迷い込んだ普通の高校生", "街角のカフェでの出会いと別れ", "現実世界で起こる超常現象", "失われた記憶を取り戻すための冒険", "家族の中に隠された秘密", "古代の遺物を巡るミステリー", "不思議な本屋での発見", "日常に潜む魔法使い", "忘れられた手紙の謎", "平凡な一日に起こる奇跡", "過去の亡霊に導かれる", "失われた王国を求めて", "友人との再会と謎の事件", "不思議な時計が刻む時間", "日常から異世界への入り口", "隠された才能の発見", "古い屋敷に隠された財宝", "学校の怪談の真相", "夢と現実が交錯する", "予知夢が示す未来", "秘密の地下室への探検", "魔法の鏡に映るもう一つの世界", "行方不明の友人を探す旅", "謎の手紙が導く冒険", "未来を予見する不思議な力", "日常に現れた幽霊", "公園で見つけた魔法の石", "隣人の家に隠された秘密", "突然の超能力の目覚め", "謎の訪問者がもたらす試練", "忘れられた地下鉄の駅", "夢の中で出会う人物", "古びた写真が語る真実", "異次元からのメッセージ", "謎の影に追われる日常", "街の噂の真相を探る", "一冊の本が導く冒険", "奇妙な隣人の正体", "学校の裏庭に広がる異世界", "図書館に隠された秘密の扉", "古びたラジオからの不思議な声", "失われた街を探す旅", "祖父の遺品に隠された謎", "不思議な力を持つ友人", "ミステリー小説の中に迷い込む", "毎日同じ夢を見る理由", "古代文明の遺跡を探検", "異世界の王子との出会い", "予知能力を持つ猫", "忘れ去られた町の秘密", "魔法の植物を育てる", "未来からの手紙", "謎の彫刻が導く冒険", "異世界へのポータルを開く鍵", "一夜だけの不思議な出来事"]
//        約60種類
         let keywords = ["りんご", "マグマ", "人魚", "木の棒", "宇宙船", "トランポリン", "時間旅行", "サイボーグ", "モンスター", "ゼリー状", "透明人間", "逆さま", "ナノテクノロジー", "テレポート", "迷彩", "電子レンジ", "砂時計", "ワープ", "自動販売機", "ダブル", "エイリアン", "パラレルワールド", "吸血鬼", "サメ", "迷路", "暗号", "超能力", "バイオハザード", "フラクタル", "バーチャルリアリティ", "ロボット", "人工知能", "ホログラム", "ドローン", "重力", "反重力", "遺伝子", "ミュータント", "スーパーヒーロー", "クローン", "秘密", "幻想", "夢", "魔法", "冒険", "王国", "竜", "精霊", "闇", "光", "運命", "伝説", "謎", "星", "翼", "銀河", "彷徨", "永遠", "封印", "影", "密室", "亡霊", "守護", "恋", "希望", "破滅", "再生", "嵐", "旋律", "心", "奇跡", "記憶", "鏡", "時空", "異次元", "忍者", "海賊", "勇者", "未来", "タイムトラベル", "テレパシー", "飛行船", "メカニック", "宇宙服", "遺伝子操作", "仮想現実", "古典", "量子力学", "量子コンピュータ", "ハッキング", "デジタル", "バイオテクノロジー", "ニューロン", "ナノマシン", "電脳",  "ウイルス", "ホロレンズ", "ディストピア", "未来都市", "アンドロイド", "タイムマシン", "メカニック", "サイバー", "クラウド", "夢", "飛行", "心霊", "祭り", "虹", "時計", "星空", "迷宮", "太陽", "手紙", "影", "波", "森", "火山", "鉱山", "風", "雨", "滝", "洞窟", "湖", "島", "砂漠", "平原",  "火", "氷", "氷河", "温泉", "峠", "山脈", "霧", "草原", "森林", "雪", "流星", "彗星", "空気", "稲妻", "紅葉", "花火", "花畑", "蝶", "蛍", "青空", "流砂", "砂嵐", "月光", "星屑", "朝焼け", "夕焼け", "黄昏", "夜明け", "昼下がり", "夕暮れ", "夜中", "深夜", "早朝", "午後", "午前", "正午", "夕方", "曇り", "晴れ", "曇天", "晴天", "雲", "霧雨", "台風", "吹雪",  "雷雨", "豪雨", "曇り空", "光線", "風景", "山景", "海景", "湖景", "林景", "花景", "街景", "村景", "郊外", "田舎", "都市", "都会", "田園", "牧場", "農村", "漁村", "港町", "山岳", "河川", "湖畔", "森林浴", "洞窟探検", "漂流", "遠足", "登山", "キャンプ", "釣り", "狩猟", "漂流", "旅行", "冒険", "探検", "遠征", "航海", "飛行", "旅路", "旅行記", "探検記", "航海記", "冒険譚", "冒険記", "後日談", "日記", "記録", "メモ", "覚醒", "追想", "思い出", "追想", "記憶", "記録", "回顧", "回想", "追憶", "思い出", "道具", "機械", "車", "飛行機", "船", "電車", "自転車", "バイク", "スマートフォン", "コンピュータ", "テレビ", "ラジオ", "ストロボカメラ", "時計", "電球", "冷蔵庫", "洗濯機", "エアコン", "電子レンジ", "掃除機", "アイロン", "ヘアドライヤー", "トースター", "コンロ", "オーブン", "ミキサー", "扇風機", "エレベーター", "エスカレーター", "自動ドア", "カーテン", "ブラインド", "ロボット掃除機", "電動自転車", "電動キックボード", "カレーライス", "ドローン", "プロジェクター", "3Dプリンター", "スマートウォッチ", "電子ペーパー", "電子書籍",  "電子楽器", "VRヘッドセット", "ARグラス", "リモコン", "デジタルカメラ", "スマートセンサー", "作曲家", "温度計", "スマートファン", "加湿器", "空気清浄機", "体重計",]
//        約150種類
         let randomPrompt = prompts.randomElement() ?? "コメディ"
         let randomKeyword = keywords.randomElement() ?? "りんご"
         let randomWordCount = Int.random(in: 300...1000)
        
        promptLabel.text = randomPrompt
        wordCountLabel.text = "字数制限: \(randomWordCount)"
        keywordLabel.text = "キーワード: \(randomKeyword)"
    }

    @objc private func regeneratePrompt() {
        generateRandomPrompt()
    }

    @objc private func startWriting() {
        let writingVC = WritingViewController()
        writingVC.prompt = promptLabel.text
        writingVC.wordCount = Int(wordCountLabel.text?.components(separatedBy: ": ").last ?? "")
        writingVC.keyword = keywordLabel.text
        navigationController?.pushViewController(writingVC, animated: true)
    }
}
