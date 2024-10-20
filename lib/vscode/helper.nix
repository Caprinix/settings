{ lib, inputs, ... }:
let
  getMixin =
    name:
    let
      mixinPath = ./mixins/${name}.nix;
    in
    if lib.pathExists mixinPath then import mixinPath else { };
  getMixinExtensions =
    name:
    let
      mixin = getMixin name;
    in
    if lib.attrsets.hasAttr "extensions" mixin then mixin.extensions else [ ];
  getMixinSettings =
    name:
    let
      mixin = getMixin name;
    in
    if lib.attrsets.hasAttr "settings" mixin then mixin.settings else { };
  getCombinedMixinExtensions =
    mixins: lib.lists.unique (lib.lists.flatten (map getMixinExtensions mixins));
  getCombinedMixinSettings =
    mixins:
    lib.attrsets.foldAttrs (mixin: acc: lib.attrsets.recursiveUpdate acc mixin) { } (
      map getMixinSettings mixins
    );
  extensionStringToPackage =
    pkgs: string:
    let
      stringParts = lib.splitString "." string;
    in
    pkgs.vscode-marketplace.${lib.elemAt stringParts 0}.${lib.elemAt stringParts 1};
in
{
  inherit
    getMixin
    getMixinExtensions
    getMixinSettings
    getCombinedMixinExtensions
    getCombinedMixinSettings
    extensionStringToPackage
    ;
}
