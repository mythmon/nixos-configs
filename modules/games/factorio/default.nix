{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    yafc-ce
  ];
}
