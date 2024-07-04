{ config, lib, pkgs, ... }:

{
  programs.starship.enable = true;

  # $git_branch\
  # $git_state\
  # $git_status\
  # $python\

  # [git_branch]
  # format = "[$branch]($style)"
  # style = "bright-black"

  # [git_status]
  # format = "[[(*$conflicted$untracked$modified$staged$renamed$deleted)](218) ($ahead_behind$stashed)]($style)"
  # style = "cyan"
  # conflicted = "​"
  # untracked = "​"
  # modified = "​"
  # staged = "​"
  # renamed = "​"
  # deleted = "​"
  # stashed = "≡"

  # [git_state]
  # format = '\([$state( $progress_current/$progress_total)]($style)\) '
  # style = "bright-black"


  # [python]
  # format = "[$virtualenv]($style) "
  # style = "bright-black"

  # $username\
  # $hostname\
  # 1password ssh keys
  xdg.configFile."starship.toml".text = ''
    format = """
    $directory\
    $git_branch $cmd_duration\
    $line_break\
    $character"""

    [directory]
    style = "cyan"

    [git_branch]
    format = "[$symbol$branch]($style)"
    symbol = " "
    style = "green"

    [character]
    success_symbol = "[❯](green)"
    error_symbol = "[❯](red)"
    vimcmd_symbol = "[❮](green)"

    [cmd_duration]
    format = "[$duration]($style) "
    style = "yellow"

    [python]
    format = "[$virtualenv]($style) "
    style = "bright-blue"
  '';


}
