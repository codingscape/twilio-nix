{ config, pkgs, ... }:

{
  environment.systemPackages = [ pkgs.direnv ];

  services.lorri = {
    enable = true;
    logFile = "/var/tmp/lorri.log";
  };
}
