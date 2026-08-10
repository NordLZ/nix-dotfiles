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
          gs = "git status";
        };
    };
    shellAliases = {
      kys = "poweroff";
      v = "nvim";
      rebuild = "sudo nixos-rebuild switch --flake ~/.nixos-dotfiles";
      lg = "lazygit";
      d = "edit-dotfiles";
    };
    extraConfig = ''
      def --env edit-dotfiles [] {
        cd ~/.nixos-dotfiles
        nvim .
      }
    '';
  };
}
