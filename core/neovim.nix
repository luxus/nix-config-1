{ config, pkgs, libs, ... }:
{
programs.neovim = {
  enable = true;
  #package = pkgs.eovim-nightly;
#  extraPackages = with pkgs; [
      # used to compile tree-sitter grammar
#      tree-sitter

      # installs different langauge servers for neovim-lsp
      # have a look on the link below to figure out the ones for your languages
      # https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md
 #     nodePackages.typescript nodePackages.typescript-language-server
 #     gopls
  #    nodePackages.pyright
  #    rust-analyzer
 # ];
};
}
