    function peco_cd
      set selected_dir (ls -1d */ | peco)
      if [ $selected_dir ]
        cd $selected_dir
        commandline -f repaint
      end
    end