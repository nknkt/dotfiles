# Dotfiles

macOS開発環境の設定ファイル群です。

## 📋 含まれる設定

### 🎨 Adobe Creative Cloud
- **Photoshop** - ショートカット、アクション、ワークスペース
- **Illustrator** - ショートカット、カラー設定、ツールパネル

### 💻 VS Code
- エディタ設定（settings.json）
- キーバインド（keybindings.json）
- スニペット（HTML, CSS, SCSS, JavaScript, Markdown）
- 拡張機能リスト（extensions.txt）

### 🛠 ユーティリティ
- **Clipy** - クリップボード拡張
- **Rectangle** - ウィンドウ管理
- **MassCode** - コードスニペット管理

### 🔧 開発ツール
- **Homebrew** - パッケージ管理（Fish, Starship, fnm, exa, bat, ripgrep等）
- **Open With** - ブラウザからエディタを開く拡張機能のネイティブホスト

## 🚀 セットアップ

### 自動セットアップ（推奨）

```bash
# dotfilesをクローン
git clone https://github.com/nknkt/dotfiles.git ~/dotfiles
cd ~/dotfiles

# 自動セットアップスクリプトを実行
./install.sh
```

このスクリプトは以下を自動で行います：
- Homebrewのインストール・更新
- 必要なパッケージのインストール
- シンボリックリンクの作成

### 手動セットアップ

#### 1. Homebrewとパッケージのインストール
```bash
./homebrew_install.sh
```

#### 2. VS Code設定
```bash
# VS Code設定をシンボリックリンクで配置
cd ~/Library/Application\ Support/Code/User
ln -s ~/dotfiles/Code/settings.json settings.json
ln -s ~/dotfiles/Code/keybindings.json keybindings.json
ln -s ~/dotfiles/Code/snippets snippets

# 拡張機能のインストール（オプション）
cat ~/dotfiles/Code/extensions.txt | xargs -L 1 code --install-extension
```

#### 3. デフォルトシェルをfishに変更（オプション）
```bash
# fishをログインシェルに追加
echo $(which fish) | sudo tee -a /etc/shells

# デフォルトシェルを変更
chsh -s $(which fish)
```

## 📦 主要パッケージ

### 必須ツール（homebrew_install.shでインストール）
- `git` - バージョン管理
- `fish` - モダンなシェル
- `starship` - プロンプト
- `fnm` - Node.jsバージョン管理
- `exa` - lsの代替
- `bat` - catの代替
- `ripgrep` - grepの代替
- `fd` - findの代替
- `fzf` - ファジーファインダー
- `peco` - インタラクティブフィルタ
- `ghq` - リポジトリ管理
- `gh` - GitHub CLI

### アプリケーション
- Google Chrome / Firefox
- Visual Studio Code
- iTerm2
- Alfred
- Rectangle
- Clipy
- Karabiner-Elements
- DeepL
- その他（詳細は [homebrew_install.sh](homebrew_install.sh) を参照）

## 🎨 Adobe設定の適用

### Photoshop
設定ファイルを以下のディレクトリにコピー：
```bash
~/Library/Preferences/Adobe Photoshop 2022 Settings/
```
- アクション
- ショートカット（knn.kys）
- ワークスペース

### Illustrator
設定ファイルを以下のディレクトリにコピー：
```bash
~/Library/Preferences/Adobe Illustrator 26 Settings/ja_JP/
```
- ショートカット（mycustomshortcut.kys）
- カラー設定
- ツールパネルプリセット

### Adobe Script（別リポジトリ）
- [Photoshop Scripts](https://github.com/nknkt/photoshopScript)
- [PS Rename Script](https://github.com/nknkt/ps-rename-script)

## 📱 アプリ個別設定

### Clipy
1. Clipyを起動
2. 環境設定 → スニペット
3. インポート・エクスポート → [clipy/snippets.xml](clipy/snippets.xml) をインポート

### Rectangle
1. Rectangleを起動
2. 設定 → Import → [rectangle/RectangleConfig.json](rectangle/RectangleConfig.json) を選択

または手動でショートカットを設定：
- Left Half: `⌃⌥←`
- Right Half: `⌃⌥→`
- Top Half: `⌃⌥↑`
- Bottom Half: `⌃⌥↓`
- Maximize: `⌃⌥F`

### MassCode
スニペット管理ツール。[masscode/db.json](masscode/db.json) に設定が保存されています。

**注意:** [v3.12.1](https://github.com/massCodeIO/massCode/releases/tag/v3.12.1) を使用しています。v4系は互換性の問題と起動の遅さがあるため、安定版の3系を継続利用しています。

### Open With
ブラウザからVS Codeなどのエディタを直接開く拡張機能のネイティブホスト。
[open_with_mac.py](open_with_mac.py) がネイティブメッセージングホストとして機能します。

## ⚙️ macOS設定

### マウススピード向上
```bash
defaults write "Apple Global Domain" com.apple.mouse.scaling 10
```

### キーリピート高速化
```bash
defaults write -g InitialKeyRepeat -int 10
defaults write -g KeyRepeat -int 1
```

### Finderアニメーション無効化
```bash
defaults write com.apple.finder DisableAllAnimations -boolean true
killall Finder
```

### 解除する場合
```bash
defaults delete com.apple.finder DisableAllAnimations
killall Finder
```

### アプリのダウンロード許可
```bash
sudo spctl --master-disable
```

## 🔤 フォント

推奨フォント：
- [Fira Code](https://github.com/tonsky/FiraCode) - プログラミング用リガチャフォント

```bash
# Homebrew Caskでインストール可能
brew install --cask font-fira-code
brew install --cask font-hack-nerd-font
```

## 🛟 トラブルシューティング

### VS Code設定が反映されない場合
```bash
# シンボリックリンクを確認
ls -la ~/Library/Application\ Support/Code/User/settings.json

# 再作成する場合
cd ~/Library/Application\ Support/Code/User
rm settings.json keybindings.json
ln -s ~/dotfiles/Code/settings.json settings.json
ln -s ~/dotfiles/Code/keybindings.json keybindings.json
```

### fishシェルが起動しない場合
```bash
# /etc/shellsに追加されているか確認
cat /etc/shells | grep fish

# 手動で追加
echo $(which fish) | sudo tee -a /etc/shells
```

## 📁 ディレクトリ構造

```
dotfiles/
├── adobe/                    # Adobe製品設定
│   ├── Illustrator/          # Illustrator設定
│   │   ├── ja_JP/           # 日本語設定
│   │   │   ├── mycustomshortcut.kys
│   │   │   ├── AI カラー設定
│   │   │   ├── New Document Profiles/
│   │   │   ├── ツール/
│   │   │   └── 変更されたワークスペース/
│   │   └── UserDictionaries/
│   └── Photoshop/           # Photoshop設定
│       ├── knn.kys          # カスタムショートカット
│       ├── action/          # アクション
│       └── WorkSpaces/      # ワークスペース
├── clipy/                   # Clipy設定
│   └── snippets.xml         # スニペット
├── Code/                    # VS Code設定
│   ├── settings.json        # エディタ設定
│   ├── keybindings.json     # キーバインド
│   ├── extensions.txt       # 拡張機能リスト
│   └── snippets/            # スニペット
│       ├── css.json
│       ├── html.json
│       ├── javascript.json
│       ├── scss.json
│       └── markdown.json
├── masscode/                # MassCode設定
│   └── db.json              # スニペットデータベース
├── rectangle/               # Rectangle設定
│   └── RectangleConfig.json # ウィンドウ管理設定
├── imgs/                    # README用画像
├── homebrew_install.sh      # Homebrewセットアップ
├── install.sh               # 自動セットアップ
├── open_with_mac.py         # Open With拡張機能ホスト
└── README.md                # このファイル
```

## 🔗 手動インストール推奨アプリ

- [Display Menu](https://apps.apple.com/jp/app/display-menu/id549083868) - ディスプレイ設定
- [AltTab](https://alt-tab-macos.netlify.app/) - ウィンドウスイッチャー
- [SCONE Diff](https://sconeapp.com/diff/) - Diffツール

## 📝 更新履歴

- 2026-03: README構成を実際のディレクトリ構造に合わせて更新
- 2024-12: 現代的な構成に全面リニューアル