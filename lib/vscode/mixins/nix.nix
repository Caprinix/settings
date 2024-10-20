{
  settings = {
    "nix.enableLanguageServer" = true;
    "nix.formatterPath" = [
      "nix"
      "fmt"
      "--"
      "-"
    ];
    "nix.serverPath" = "nixd";
    "nix.serverSettings" = {
      "nixd" = {
        formatting = {
          command = [
            "nix"
            "fmt"
            "--"
            "-"
          ];
        };
      };
    };
  };
  extensions = [
    "jnoortheen.nix-ide"
  ];
}
