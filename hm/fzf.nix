{ ... }:

{
  programs.fzf = {
    enable = true;

    changeDirWidgetOptions = [ "--walker-skip .git,node_modules,target,.venv" "--preview 'tree -C {}'" ];
    changeDirWidgetCommand = "fd . --type d $HOME";
    enableFishIntegration = true;
  };

}
