{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    kicad
    prusa-slicer
  ];
}
