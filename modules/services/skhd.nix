{
  services.skhd = {
    enable = true;
    skhdConfig = builtins.replaceStrings [ "rhyper" ] [ "rcmd + rctrl + ralt + rshift" ] (
      builtins.readFile ./skhd.conf
    );
  };
}
