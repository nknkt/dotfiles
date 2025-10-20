#!/bin/bash

# ========================================
# Dotfiles 自動セットアップスクリプト
# ========================================

set -e  # エラー時に終了

# カラー出力用の定数
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
NC='\033[0m' # No Color

# ログ出力関数
log_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

log_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

log_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

log_step() {
    echo -e "${PURPLE}[STEP]${NC} $1"
}

# スクリプトのディレクトリを取得
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$DOTFILES_DIR"

echo -e "${GREEN}"
echo "=========================================="
echo "    🚀 Dotfiles セットアップ開始"
echo "=========================================="
echo -e "${NC}"

# 1. Homebrewのインストール・更新
log_step "1. Homebrew環境のセットアップ"
if command -v brew &> /dev/null; then
    log_info "Homebrewは既にインストールされています"
    log_info "homebrew_install.shを実行してパッケージを更新しますか？"
    read -p "実行しますか？ [y/N]: " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        bash "$DOTFILES_DIR/homebrew_install.sh"
    fi
else
    log_info "Homebrewをインストールして必要なパッケージをセットアップします"
    bash "$DOTFILES_DIR/homebrew_install.sh"
fi

# 2. dotfilesのシンボリックリンク作成
log_step "2. dotfilesのシンボリックリンク作成"

# 除外するファイル・ディレクトリ
excluded_files=(
    ".git"
    ".gitignore"
    ".github"
    ".DS_Store"
    "README.md"
    "install.sh"
    "homebrew_install.sh"
    "open_with_mac.py"
    "imgs"
)

# dotfilesのシンボリックリンクを作成
for item in .??* */; do
    # ディレクトリの場合は末尾の/を削除
    item=${item%/}

    # 除外リストに含まれているかチェック
    skip_item=false
    for excluded in "${excluded_files[@]}"; do
        if [[ "$item" == "$excluded" ]]; then
            skip_item=true
            break
        fi
    done

    if $skip_item; then
        continue
    fi

    # .node-gyp や .yarnrc などの個別ファイルとディレクトリを処理
    if [[ -f "$item" ]] || [[ -d "$item" ]]; then
        target="$HOME/$item"

        # 既存のファイル/ディレクトリをバックアップ
        if [[ -e "$target" ]] && [[ ! -L "$target" ]]; then
            backup_name="${target}.backup.$(date +%Y%m%d_%H%M%S)"
            log_warning "既存の $item をバックアップします: $backup_name"
            mv "$target" "$backup_name"
        fi

        # シンボリックリンクを作成
        if ln -sfn "$DOTFILES_DIR/$item" "$target"; then
            log_success "シンボリックリンクを作成: $item"
        else
            log_error "シンボリックリンクの作成に失敗: $item"
        fi
    fi
done

# 3. Git設定
log_step "3. Git設定"
if ! git config --global user.name &> /dev/null; then
    log_info "Gitのユーザー名を設定してください:"
    read -p "Name: " git_user_name
    git config --global user.name "$git_user_name"
fi

if ! git config --global user.email &> /dev/null; then
    log_info "Gitのメールアドレスを設定してください:"
    read -p "Email: " git_user_email
    git config --global user.email "$git_user_email"
fi

# 4. Fishシェルの設定
log_step "4. Fishシェルの設定"
if command -v fish &> /dev/null; then
    current_shell=$(echo $SHELL)
    fish_path=$(which fish)

    if [[ "$current_shell" != "$fish_path" ]]; then
        log_info "デフォルトシェルをfishに変更しますか？"
        read -p "変更しますか？ [y/N]: " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            # /etc/shellsにfishを追加（必要に応じて）
            if ! grep -q "$fish_path" /etc/shells; then
                echo "$fish_path" | sudo tee -a /etc/shells
            fi
            chsh -s "$fish_path"
            log_success "デフォルトシェルをfishに変更しました"
        fi
    else
        log_success "既にfishがデフォルトシェルです"
    fi
else
    log_warning "fishがインストールされていません"
fi

# 5. macOSの設定
log_step "5. macOSの設定（オプション）"
log_info "macOSの設定を最適化しますか？（キーリピート、マウス速度など）"
read -p "設定しますか？ [y/N]: " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    # マウススピード
    defaults write "Apple Global Domain" com.apple.mouse.scaling 10
    log_success "マウススピードを設定しました"

    # キーリピート
    defaults write -g InitialKeyRepeat -int 10
    defaults write -g KeyRepeat -int 1
    log_success "キーリピート速度を設定しました"

    # Finderアニメーション無効化
    defaults write com.apple.finder DisableAllAnimations -boolean true
    killall Finder 2>/dev/null || true
    log_success "Finderアニメーションを無効化しました"

    # セキュリティ設定（任意のアプリダウンロード許可）
    log_info "任意のアプリのダウンロードを許可しますか？"
    read -p "許可しますか？ [y/N]: " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        sudo spctl --master-disable
        log_success "任意のアプリのダウンロードを許可しました"
    fi
fi

# 完了メッセージ
echo ""
echo -e "${GREEN}"
echo "=========================================="
echo "    🎉 セットアップ完了！"
echo "=========================================="
echo -e "${NC}"

log_info "次の手順:"
echo "  1. ターミナルを再起動してください"
echo "  2. VS Codeでextensions syncを有効にしてください"
echo "  3. 各アプリケーションの個別設定を行ってください"
echo "  4. Node.js環境を移行する場合は 'node-migrate' コマンドを実行してください"
echo ""

log_info "困った時は:"
echo "  - README.mdを確認してください"
echo "  - 設定を元に戻す場合は.backup.xxxファイルを使用してください"
echo ""