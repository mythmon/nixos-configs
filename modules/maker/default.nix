{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    freecad-wayland
    openscad-unstable
    kicad
    prusa-2-9-1-pr.prusa-slicer
  ];
}
