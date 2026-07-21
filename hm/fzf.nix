{ ... }:

{
  programs.fzf = {
    enable = true;

    changeDirWidget = {
      options = [ "--walker-skip .git,node_modules,target,.venv" "--preview 'tree -C {}'" ];
      command = "fd . --type d $HOME";
    };

    enableFishIntegration = true;
  };

}
