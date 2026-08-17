{
  description = "Portable neovim config";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs = {
    self,
    nixpkgs,
  }: let
    systems = ["x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin"];
    forAllSystems = f: nixpkgs.lib.genAttrs systems (system: f nixpkgs.legacyPackages.${system});
  in {
    packages = forAllSystems (pkgs: {
      default = let
        # Any CLI tools/LSPs/formatters your config expects at runtime
        extraPackages = with pkgs; [
          neovim
          ripgrep
          nil
          nixpkgs-fmt
          nodejs
          gcc
          luaPackages.tree-sitter-cli
          lua-language-server
          alejandra
        ];

        # Make ~/.config/nvim resolve to this flake's source, so init.lua
        # and lua/ requires work exactly like a normal ~/.config/nvim would.
        nvimConfigHome = pkgs.runCommand "nvim-xdg-config" {} ''
          mkdir -p $out
          ln -s ${self} $out/nvim
        '';
      in
        pkgs.symlinkJoin {
          name = "nvim";
          paths = [pkgs.neovim];
          buildInputs = [pkgs.makeWrapper];
          postBuild = ''
            wrapProgram $out/bin/nvim \
              --set XDG_CONFIG_HOME "${nvimConfigHome}" \
              --prefix PATH : ${pkgs.lib.makeBinPath extraPackages}
          '';
        };
    });

    apps = forAllSystems (pkgs: {
      default = {
        type = "app";
        program = "${self.packages.${pkgs.system}.default}/bin/nvim";
      };
    });
  };
}
