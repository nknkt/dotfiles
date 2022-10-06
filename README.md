## 初期環境の作成
### GItHub
#### dotfiles
- node(nodenv)
- photoshop
  - 設定
  - UI
  - ショートカット
- Illustrator
  - ショートカット
#### adobe script

- https://github.com/nknkt/photoshopScript
- https://github.com/nknkt/ps-rename-script

#### homebrew
dotfiles内に必要アプリをcaskでインストールできるシェルスクリプトをおいておく

##### dotfiles内で実行

```shell
 ~/dotfiles/homebrew_install.sh
```

- alfred
- clipy
- CotEditor
- DeepL
- Dropbox
- Firefox
- Flux
- HyperSwitch
- google-chrome
- google-japanese-ime
- sourcetree
- iterm2
- ImageOptim
- Karabiner-Elements
- KeyboardCleanTool
- MAMP
- OnyX
- Sourcetree
- Spark
- Spectacle
- Transmit
- Typora
- Visual-Studio-Code
- Vivaldi
- Xcode
### boostnote
別スニペットアプリに移行予定

### 手動で落とすapp
- [Display Menu](https://apps.apple.com/jp/app/display-menu/id549083868?mt=12)
- [SCONE Diff](https://sconeapp.com/diff/)
### font
Google Font
- [Fira Code](https://fonts.google.com/specimen/Fira+Code)
  - [GitHub](https://github.com/tonsky/FiraCode)
### vscode
個人のGitHubアカウントで管理 ⌘,→基本設定→同期
##### 同期できるもの

- 設定
- ショートカット
- スニペット
- プラグイン
- UI

### Mac自体の設定
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


