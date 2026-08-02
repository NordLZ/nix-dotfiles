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
          update = "nix flake update";
          rebuild = "sudo nixos-rebuild switch --flake ~/nixos-dotfiles";
        };
    };
    shellAliases = {
      kys = "poweroff";
      v = "nvim";
      cdot = "cd ~/nixos-dotfiles/";
    };
  };
}
