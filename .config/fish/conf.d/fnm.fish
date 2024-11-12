fnm env --use-on-cd | source

# fnm
set FNM_PATH "/Users/kenta_kanno/Library/Application Support/fnm"
if [ -d "$FNM_PATH" ]
  set PATH "$FNM_PATH" $PATH
  fnm env | source
end
