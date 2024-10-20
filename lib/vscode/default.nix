{ lib, inputs, ... }:
{
  vscode = {
    helper = import ./helper.nix { inherit lib inputs; };
  };
}
