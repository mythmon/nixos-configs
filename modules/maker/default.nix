{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    # kicad fails to install for some reason
    # kicad
    prusa-slicer
  ];
}
