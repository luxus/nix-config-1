{
  accounts.email.accounts.luxus = {
    primary = true;
    flavor = "gmail.com";
    realName = "Kai Loehnert";
    address = "luxuspur@gmail.com";
    userName = "luxuspur@gmail.com";
    notmuch.enable = true;

    lieer.enable = true;
    lieer.sync.enable = true;
  };

  programs.notmuch = {
    enable = true;
    new.tags = [ "new" ];
    search.excludeTags = [ "trash" "spam" ];
  };
  programs.lieer.enable = true;
  services.lieer.enable = true;
  programs.afew = {
    enable = true;

    # https://afew.readthedocs.io/en/latest/configuration.html
    extraConfig = ''
      [KillThreadsFilter]
      [ArchiveSentMailsFilter]
    '';
    # [ListMailsFilter]
    # [SpamFilter]
    # [InboxFilter]
  };
}
