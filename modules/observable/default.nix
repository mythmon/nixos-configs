{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    rambox
  ];
}