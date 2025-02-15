{ pkgs, ... }: {
  programs.git = {
    enable = true;
    delta = {
      enable = true;
      options = {
        navigate = true;
        syntax-theme = "Nord";
      };
    };
    package = pkgs.gitFull;
    lfs.enable = false;
    userEmail = "luxuspur@gmail.com";
    userName = "luxus";
    extraConfig = {
      diff.colorMoved = "default";
      difftool.prompt = true;
      github.user = "luxus";
      init.defaultBranch = "main";
      merge.conflictstyle = "zdiff3";
      mergetool.prompt = true;
      pull.ff = "only";
      credential.helper = "${pkgs.gitAndTools.gitFull}/bin/git-credential-libsecret";
      diff.tool = "diffsitter";
      # difftool.prompt = false;
      difftool.difftastic.cmd = "/home/luxus/.cargo/bin/difftastic \"$LOCAL\" \"$REMOTE\"";
      difftool.diffsitter.cmd = "/home/luxus/.cargo/bin/diffsitter \"$LOCAL\" \"$REMOTE\"";
    };

    aliases = {
      st = "status";
      co = "checkout";
      ci = "commit";
      br = "branch";
      lg = "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit";
      recent = "for-each-ref --sort=-committerdate --format='%(committerdate:short): %(refname:short)' refs/heads/";
    };

    ignores = [
      "*~"
      "*.swp"
      # exclude nix-build result
      "result"
      "result-*"
    ];
  };
}
