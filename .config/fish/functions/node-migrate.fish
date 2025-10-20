function node-migrate --description "Migrate from nodebrew to fnm"
    echo "Nodebrewからfnmに移行するヘルパースクリプト"
    echo ""

    # 現在のnodebrewのバージョンを確認
    if command -v nodebrew > /dev/null
        echo "現在のnodebrewバージョン:"
        nodebrew list
        echo ""

        echo "推奨される移行手順:"
        echo "1. 現在使用中のNode.jsバージョンを確認"
        echo "2. fnmで同じバージョンをインストール"
        echo "3. nodebrewをアンインストール"
        echo ""

        set current_version (node --version 2>/dev/null | string replace 'v' '')
        if test -n "$current_version"
            echo "現在のNode.jsバージョン: $current_version"
            echo "fnmでインストールするには:"
            echo "  fnm install $current_version"
            echo "  fnm use $current_version"
            echo "  fnm default $current_version"
        end
    else
        echo "nodebrewがインストールされていません"
    end

    echo ""
    echo "移行後、以下をアンインストールできます:"
    echo "  brew uninstall nodebrew"
    echo "  rm -rf ~/.nodebrew"
end