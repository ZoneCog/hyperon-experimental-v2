{pkgs}: {
  deps = [
    pkgs.docker
    pkgs.imagemagick
    pkgs.rustup
    pkgs.python312Packages.pytest
    pkgs.cmakeWithGui
    pkgs.nvidia-docker
  ];
}
