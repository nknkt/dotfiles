function peco_cd
    # 現在のディレクトリにサブディレクトリがある場合
    if count (ls -1d */ 2>/dev/null) >/dev/null
        set selected_dir (ls -1d */ | peco --prompt="CD> ")
        if test -n "$selected_dir"
            cd $selected_dir
            commandline -f repaint
        end
    else
        echo "No subdirectories found in current directory."
    end
end