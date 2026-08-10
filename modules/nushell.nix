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
        };
    };
    shellAliases = {
      kys = "poweroff";
      v = "nvim";
      rebuild = "sudo nixos-rebuild switch --flake ~/.nixos-dotfiles";
      gs = "git status";
      lg = "lazygit";
    };
  };
}
