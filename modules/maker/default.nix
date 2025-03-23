{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    kicad
    prusa-2-9-1-pr.prusa-slicer
  ];
}
