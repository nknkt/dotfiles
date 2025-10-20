# Dotfiles

現代的なmacOS開発環境の設定ファイル群です。

## 📋 含まれる設定

### 🐚 シェル環境
- **Fish Shell** - モダンで使いやすいインタラクティブシェル（メイン）
- **Starship** - 高速でカスタマイズ可能なプロンプト
- bash/zsh - 互換性のための最小限設定

### 🛠 開発ツール
- **VS Code** - エディタ設定、キーバインド、スニペット
- **Git** - エイリアス、LFS設定
- **Node.js** - fnmによるバージョン管理
- **Homebrew** - パッケージ管理

### 🎨 アプリケーション
- Adobe Creative Suite設定（Photoshop, Illustrator）
- Clipy（クリップボード拡張）
- Rectangle（ウィンドウ管理）
- その他便利なmacOSアプリ

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
- Git設定
- Fishシェルの設定
- macOS設定の最適化

### 手動セットアップ

#### 1. Homebrewとパッケージのインストール
```bash
./homebrew_install.sh
```

#### 2. 設定ファイルのシンボリックリンク作成
```bash
# 必要に応じて既存ファイルをバックアップ
mv ~/.gitconfig ~/.gitconfig.backup
mv ~/.config ~/.config.backup

# シンボリックリンクを作成
ln -s ~/dotfiles/.gitconfig ~/.gitconfig
ln -s ~/dotfiles/.config ~/.config
ln -s ~/dotfiles/.zshrc ~/.zshrc
ln -s ~/dotfiles/.bashrc ~/.bashrc
```

#### 3. VS Code設定
VS Code設定は自動的にシンボリックリンクで管理されます。

#### 4. デフォルトシェルをfishに変更
```bash
# fishをログインシェルに追加
echo $(which fish) | sudo tee -a /etc/shells

# デフォルトシェルを変更
chsh -s $(which fish)
```

## 📦 主要パッケージ

### 必須ツール
- `git` - バージョン管理
- `fish` - メインシェル
- `starship` - プロンプト
- `fnm` - Node.jsバージョン管理
- `exa` - lsの代替
- `bat` - catの代替
- `ripgrep` - grepの代替
- `fzf` - ファジーファインダー
- `peco` - インタラクティブフィルタ

### アプリケーション
- Google Chrome / Firefox
- Visual Studio Code
- iTerm2
- Alfred
- Rectangle（Spectacleの代替）
- Clipy
- DeepL
- その他（詳細は `homebrew_install.sh` を参照）

## 🔧 Node.js環境の移行

nodebrewからfnmに移行する場合：

```bash
# 移行ヘルパーを実行
node-migrate

# 現在のバージョンをfnmでインストール
fnm install 18.17.0  # 例
fnm use 18.17.0
fnm default 18.17.0

# 古いnodebrewを削除
brew uninstall nodebrew
rm -rf ~/.nodebrew
```

## ⚙️ macOS設定

以下の設定を手動で適用できます：

```bash
# マウススピード向上
defaults write "Apple Global Domain" com.apple.mouse.scaling 10

# キーリピート高速化
defaults write -g InitialKeyRepeat -int 10
defaults write -g KeyRepeat -int 1

# Finderアニメーション無効化
defaults write com.apple.finder DisableAllAnimations -boolean true
killall Finder

# 任意のアプリダウンロード許可
sudo spctl --master-disable
```

## 📱 アプリ個別設定

### Clipy
スニペットを開く → インポート・エクスポート → `clipy/snippets.xml`

### Rectangle
Spectacleからの移行推奨。より活発にメンテナンスされています。

### 手動インストール推奨アプリ
- [Display Menu](https://apps.apple.com/jp/app/display-menu/id549083868)
- [AltTab](https://alt-tab-macos.netlify.app/)（HyperSwitchの代替）

## 🔤 フォント

推奨フォント：
- [Fira Code](https://github.com/tonsky/FiraCode) - プログラミング用
- [Hack Nerd Font](https://nerdfonts.com/) - ターミナル用

```bash
# Homebrew Caskでインストール可能
brew install --cask font-fira-code
brew install --cask font-hack-nerd-font
```

## 🛟 トラブルシューティング

### 設定を元に戻したい場合
バックアップファイル（`.backup.YYYYMMDD_HHMMSS`）から復元：

```bash
rm ~/.gitconfig
mv ~/.gitconfig.backup.20231210_143000 ~/.gitconfig
```

### VS Code設定が反映されない場合
```bash
# VS Code設定を再リンク
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

## 🤝 開発に関して

### ディレクトリ構造
```
dotfiles/
├── .config/          # アプリ設定
│   ├── fish/         # Fish Shell設定
│   ├── git/          # Git設定
│   └── starship.toml # Starship設定
├── Code/             # VS Code設定
├── adobe/            # Adobe製品設定
├── clipy/            # Clipy設定
├── install.sh        # 自動セットアップ
├── homebrew_install.sh # Homebrew設定
└── README.md         # このファイル
```

### 個別Adobe設定
Adobe関連の設定は別リポジトリで管理：
- [Photoshop Scripts](https://github.com/nknkt/photoshopScript)
- [PS Rename Script](https://github.com/nknkt/ps-rename-script)

## 📝 更新履歴

- 2024-12: 現代的な構成に全面リニューアル
  - nodebrewからfnmに移行
  - Spectacle → Rectangle
  - 古いHomebrewコマンド修正
  - VS Code設定最新化
  - 自動セットアップスクリプト改善



### adobe script

別リポリトジで管理

- https://github.com/nknkt/photoshopScript
- https://github.com/nknkt/ps-rename-script



## アプリ設定


#### Clipy

スニペットを開く→インポート・エクスポート



#### HyperSwitch

keyをoptionに（⌘+tabと使い分けるため）
Run HyperSwitch in the backgroudにチェック

![hyper-switch](/Users/kenta_kanno/dotfiles/imgs/hyper-switch.png)

##### 代価候補

[AltTab](https://alt-tab-macos.netlify.app/)



#### Specatacle

![specatacle](/Users/kenta_kanno/dotfiles/imgs/specatacle.png)



#### 手動で落とすapp

- [Display Menu](https://apps.apple.com/jp/app/display-menu/id549083868?mt=12)
- [SCONE Diff](https://sconeapp.com/diff/)



## font

Google Font
- [Fira Code](https://fonts.google.com/specimen/Fira+Code)
  - [GitHub](https://github.com/tonsky/FiraCode)



## vscode

個人のGitHubアカウントで管理 ⌘,→基本設定→同期
##### 同期できるもの

- 設定
- ショートカット
- スニペット
- プラグイン
- UI



## Mac自体の設定

#### マウススピード

```shell
defaults write "Apple Global Domain" com.apple.mouse.scaling 10
```



#### キーリピート

```shell
defaults write -g InitialKeyRepeat -int 10
defaults write -g KeyRepeat -int 1
```



#### Finderアニメ停止

```shell
defaults write com.apple.finder DisableAllAnimations -boolean true
killall Finder
```

##### ※解除

```shell
defaults delete com.apple.finder DisableAllAnimations
killall Finder
```



#### アプリのダウンロードの許可

```shell
sudo spctl --master-disable
```