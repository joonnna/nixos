{ ... }:

{
  programs = {
    nushell = {
      enable = true;
      extraConfig = ''
        $env.PATH = ($env.PATH |
        split row (char esep) |
        prepend /home/jon/.apps |
        append /usr/bin/env
        )

        $env.config.edit_mode = "vi";
        # $env.config.hints.enable = true
        # $env.config.completions.always_hint = "true"
        let fish_completer = {|spans|
            fish --command $"complete '--do-complete=($spans | str replace --all "'" "\\'" | str join ' ')'"
            | from tsv --flexible --noheaders --no-infer
            | rename value description
            | update value {|row|
              let value = $row.value
              let need_quote = ['\' ',' '[' ']' '(' ')' ' ' '\t' "'" '"' "`"] | any {$in in $value}
              if ($need_quote and ($value | path exists)) {
                let expanded_path = if ($value starts-with ~) {$value | path expand --no-symlink} else {$value}
                $'"($expanded_path | str replace --all "\"" "\\\"")"'
              } else {$value}
            }
        }
        let carapace_completer = {|spans|
            carapace $spans.0 nushell ...$spans | from json
        }

        $env.config = ($env.config
            | upsert completions {
                # case_sensitive: false
                # algorithm: "fuzzy"
                external: { enable: true, completer: $carapace_completer }
                # quick: true
                # partial: false
                # this is the important one:
                # always_hint: true
            }
        )

        #   $env.config = ($env.config | upsert edit_mode vi
        #       | upsert completion {
        #           case_sensitive: false
        #           algorithm: "prefix"
        #           external: {
        #               enable: true
        #           }
        #       }
        #       | upsert history {
        #           max_size: 100_000
        #           sync: true
        #           file_format: "plaintext"
        #       }
        #       | upsert show_banner false
        #       | upsert hints {
        #           enable: true
        #           max_lines: 1
        #       })
        # '';
    };
  };
}
