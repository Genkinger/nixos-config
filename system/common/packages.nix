{pkgs, ...}: {
  # environment.systemPackages = let
  #   development = with pkgs; [
  #     odin
  #     ols
  #     zig
  #     zls
  #     gcc
  #     alejandra
  #     clang-tools
  #     nil
  #     tree-sitter
  #     vscode-langservers-extracted
  #     marksman
  #     black
  #     rustup
  #     jdk17
  #     emacs-gtk
  #     highlight
  #     (python311.withPackages (ps: [
  #       ps.matplotlib
  #       ps.torch-bin
  #       ps.opencv4
  #       ps.python-lsp-server
  #       ps.rope
  #       ps.scikit-learn
  #       ps.pyflakes
  #       ps.pyglet
  #       ps.pyaudio
  #       ps.bokeh
  #       ps.pandas
  #       ps.scipy
  #       ps.click
  #       ps.seaborn
  #     ]))
  #     raylib
  #     unstable.helix
  #     cmake
  #   ];
  #   audio = with pkgs; [
  #     unstable.reaper
  #     renoise
  #     audacity
  #     pavucontrol
  #     qpwgraph
  #     vcv-rack
  #     libnghttp2
  #     nghttp2
  #     unstable.surge-XT
  #     unstable.helm
  #     unstable.yabridge
  #     unstable.zam-plugins
  #     unstable.oxefmsynth
  #     unstable.vital
  #     unstable.distrho
  #     unstable.dexed
  #     unstable.wolf-shaper
  #     unstable.bchoppr
  #     unstable.bshapr
  #     unstable.bslizr
  #     unstable.calf
  #     unstable.lsp-plugins
  #     unstable.airwindows-lv2
  #     unstable.dragonfly-reverb
  #     unstable.x42-plugins
  #     unstable.ChowKick
  #     unstable.ChowPhaser
  #     unstable.ChowCentaur
  #     unstable.CHOWTapeModel
  #     unstable.geonkick
  #     unstable.odin2
  #   ];
  #   media = with pkgs; [
  #     mpv
  #     ffmpeg
  #     feh
  #     zathura
  #   ];
  #   graphicalSoftware = with pkgs; [
  #     transmission_4-gtk
  #     inkscape
  #     discord
  #     bottles
  #     spotify
  #     xournalpp
  #     firefox
  #     pcmanfm
  #     gthumb
  #     libreoffice-fresh
  #     xarchiver
  #     prusa-slicer
  #     chromium
  #     prismlauncher
  #     flameshot
  #     ffmpegthumbnailer
  #   ];
  #   tools = with pkgs; [
  #     git
  #     pandoc
  #     unzip
  #     ripgrep
  #     htop
  #     wget
  #     fzf
  #     unrar
  #     arandr
  #     graphite2
  #     usbutils
  #     kitty
  #     kitty-themes
  #     xorg.xkill
  #     xclip
  #     virt-manager
  #     looking-glass-client
  #     scream
  #     oh-my-zsh
  #     ranger
  #     atool
  #     tmux
  #     zsh
  #     stow
  #   ];
  # in
  #   tools ++ audio ++ development ++ media ++ graphicalSoftware;
  environment.systemPackages = with pkgs; [
    git
    lazygit
    stow
    unstable.helix
    kitty
    just
    firefox
    pcmanfm
    unzip
    ripgrep
    htop
    fzf
    wget
    unrar
    arandr
    xorg.xkill
    xclip
    oh-my-zsh
    atool
    ranger
    zsh
    mpv
    ffmpeg
    vlc
    gthumb
    feh
    zathura
    discord
    flameshot
    pavucontrol
    bc
    helvum
    qpwgraph
    coppwr
  ];
}
