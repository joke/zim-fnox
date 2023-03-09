(( ${+commands[fnox]} )) && () {
  local command=${commands[fnox]}

  # generating activation file
  local activatefile=$1/fnox-activate.zsh
  if [[ ! -e $activatefile || $activatefile -ot $command ]]; then
    $command activate zsh >| $activatefile
    zcompile -UR $activatefile
  fi

  source $activatefile
  source <($command hook-env -s zsh)

  # generating completions
  local compfile=$1/functions/_fnox
  if [[ ! -e $compfile || $compfile -ot $command ]]; then
    $command complete --shell zsh >| $compfile
    print -u2 -PR "* Detected a new version 'fnox'. Regenerated completions."
  fi
} ${0:h}
