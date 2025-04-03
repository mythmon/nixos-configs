{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    freecad-wayland
    kicad
    prusa-2-9-1-pr.prusa-slicer
  ];
}
