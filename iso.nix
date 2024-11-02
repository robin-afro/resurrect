{ config, pkgs, ... }: {
  imports = [
    <nixpkgs/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix>
    <nixpkgs/nixos/modules/installer/cd-dvd/channel.nix>
  ];

  # Include KDE Plasma
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    autoLogin.enable = true;
    autoLogin.user = "nixos";
  };

  services.desktopManager.plasma6.enable = true;

  # Utilities
  programs.partition-manager.enable = true;
  environment.systemPackages = with pkgs; [ konsole dolphin vim firefox ];

  # Set a user for the session (default NixOS live user)
  users.users.nixos = {
    isNormalUser = true;
    initialPassword = "nixos";
    home = "/home/nixos";
    shell = pkgs.bash;
  };

  # Override .config
  environment.etc."skel/.config".source = ./user_config/.config;
}

