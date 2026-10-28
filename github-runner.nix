{
  services.github-runners."kyogre" = {
    enable = true;
    user = "jon";
    group = "users";
    name = "onprem-datafangst";
    tokenFile = "/home/jon/secrets/github-runner-pat.token";
    url = "https://github.com/orcalabs";
    replace = true;
    # workDir = "/home/jon/github-runner-workspace/repos";
    # serviceOverrides = {
    #   ReadWritePaths = [
    #     "/home/jon/github-runner-workspace"
    #   ];
    #   ProtectHome = false;
    #   ProtectUsers = false;
    # };
    # extraEnvironment = {
    #   CUSTOM_RUNNER_ROOT = "/home/jon/github-runner-workspace";
    #   CUSTOM_RUNNER_WORK_DIR = "$CUSTOM_RUNNER_ROOT/repos";
    #   SECRETS_PATH = "/home/jon/secrets";
    # };
  };
}
