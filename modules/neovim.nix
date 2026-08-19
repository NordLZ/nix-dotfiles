{pkgs, ...}: {
  # System neovim package + core dev utilities needed for treesitter & LSP
  home.packages = with pkgs; [
    neovim
    ripgrep
    nil
    nixpkgs-fmt
    nodejs
    gcc
    luaPackages.tree-sitter-cli
    lua-language-server
    alejandra
    nixd
  ];
}
