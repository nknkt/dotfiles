#!/bin/bash

# Homebrew インストールスクリプト（現代的な構成）

set -e  # エラーが発生したら終了

# カラー出力用の設定
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

echo_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

echo_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

echo_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Homebrewのインストール確認
echo_info "Homebrewのインストール状況を確認中..."
if ! command -v brew &> /dev/null; then
    echo_info "Homebrewをインストールしています..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    # Apple Silicon Macの場合のPATH設定
    if [[ $(uname -m) == "arm64" ]]; then
        echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
        eval "$(/opt/homebrew/bin/brew shellenv)"
    fi
else
    echo_success "Homebrewは既にインストールされています"
fi

echo_info "brew doctor を実行中..."
brew doctor

echo_info "Homebrewを更新中..."
brew update

echo_info "既存のパッケージをアップグレード中..."
brew upgrade

# 開発ツール（必須）
essential_formulas=(
    git
    curl
    wget
    tree
    jq
    gh              # GitHub CLI
    starship        # モダンなプロンプト
    fish            # モダンなシェル
    fnm             # Node.jsバージョン管理（nodebrewの代替）
    exa             # lsの代替
    bat             # catの代替
    ripgrep         # grepの代替
    fd              # findの代替
    fzf             # ファジーファインダー
    peco            # インタラクティブフィルタ
    ghq             # リポジトリ管理
    httpie          # HTTPクライアント
)

# 開発ツール（オプション）
optional_formulas=(
    pandoc          # ドキュメント変換
    imagemagick     # 画像処理
    ffmpeg          # 動画処理
    sqlite          # データベース
)

# アプリケーション（必須）
essential_casks=(
    # ブラウザ
    google-chrome
    firefox

    # 開発ツール
    visual-studio-code
    iterm2

    # ユーティリティ
    alfred
    clipy
    karabiner-elements
    rectangle       # Spectacleの代替

    # コミュニケーション
    deepl

    # クラウドストレージ
    dropbox

    # システム管理
    onyx

    # 入力
    google-japanese-ime
)

# アプリケーション（オプション）
optional_casks=(
    # エディタ
    coteditor
    typora

    # 開発
    sourcetree

    # デザイン
    imageoptim

    # その他
    mamp
    masscode
    vivaldi
    spark
    transmit
)

# 古いアプリの代替案を表示
echo_warning "以下のアプリは代替案があります:"
echo_warning "  Spectacle → Rectangle (より活発にメンテナンスされている)"
echo_warning "  Flux → macOS標準のNight Shift機能"
echo_warning "  HyperSwitch → AltTab (https://alt-tab-macos.netlify.app/)"

# インストール関数
install_formulas() {
    local formulas=("$@")
    for formula in "${formulas[@]}"; do
        if brew list "$formula" &>/dev/null; then
            echo_info "$formula は既にインストールされています"
        else
            echo_info "$formula をインストール中..."
            brew install "$formula"
            echo_success "$formula のインストールが完了しました"
        fi
    done
}

install_casks() {
    local casks=("$@")
    for cask in "${casks[@]}"; do
        if brew list --cask "$cask" &>/dev/null; then
            echo_info "$cask は既にインストールされています"
        else
            echo_info "$cask をインストール中..."
            brew install --cask "$cask"
            echo_success "$cask のインストールが完了しました"
        fi
    done
}

# メインインストール処理
echo_info "必須パッケージをインストールしています..."
install_formulas "${essential_formulas[@]}"

echo_info "必須アプリケーションをインストールしています..."
install_casks "${essential_casks[@]}"

# オプションパッケージの確認
echo ""
echo_info "オプションパッケージをインストールしますか？"
echo_warning "オプションパッケージ: ${optional_formulas[*]}"
read -p "インストールしますか？ [y/N]: " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    install_formulas "${optional_formulas[@]}"
fi

echo ""
echo_info "オプションアプリケーションをインストールしますか？"
echo_warning "オプションアプリケーション: ${optional_casks[*]}"
read -p "インストールしますか？ [y/N]: " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    install_casks "${optional_casks[@]}"
fi

# クリーンアップ
echo_info "Homebrewをクリーンアップしています..."
brew cleanup

# 完了メッセージ
echo ""
echo_success "🎉 Homebrewのセットアップが完了しました！"
echo ""
echo_info "次の手順:"
echo_info "  1. ターミナルを再起動してください"
echo_info "  2. fishシェルを設定してください: chsh -s $(which fish)"
echo_info "  3. VS Codeでextensions syncを有効にしてください"
echo_info "  4. アプリケーションの個別設定を行ってください"
echo ""
