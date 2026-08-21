{pkgs, ...}: let
  expandSudo = [
    "systemctl"
    "journalctl"
    "mount"
    "umount"
  ];

  generatedAbbrs = builtins.listToAttrs (
    map (cmd: {
      name = cmd;
      value = "sudo ${cmd}";
    })
    expandSudo
  );
in {
  programs.nushell = {
    enable = true;
    settings = {
      show_banner = false;
      abbreviations =
        generatedAbbrs
        // {
          nix-update = "nix flake update";
          nix-rebuild = "sudo nixos-rebuild switch --flake ~/.nixos-dotfiles";
          nix-test = "sudo nixos-rebuild test --flake ~/.nixos-dotfiles";
        };
    };
    shellAliases = {
      kys = "poweroff";
      v = "nvim";
      lg = "lazygit";
      d = "edit-dotfiles";
      gs = "git status";
    };
    extraConfig = ''
      def --env edit-dotfiles [] {
        cd ~/.nixos-dotfiles
        nvim .
      }
    '';
  };
}
