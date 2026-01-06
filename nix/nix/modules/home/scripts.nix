{ pkgs, lib }:

let
  scriptsDir = builtins.toString (builtins.getEnv "HOME") + "/dotfiles/scripts";

  # recursively get all files under scriptsDir
  flattenScripts =
    dir:
    let
      entries = builtins.attrNames (builtins.readDir dir);
    in
    lib.concatMap (
      entry:
      let
        full = dir + "/" + entry;
      in
      if builtins.pathIsDir full then flattenScripts full else [ full ]
    ) entries;

  allFiles = flattenScripts scriptsDir;

  # filter only executable files
  executables = builtins.filter (f: (builtins.elem "x" (builtins.stat f).permissions)) allFiles;

  # generate Home Manager binaries
  scriptBinaries = lib.genAttrs executables (
    f:
    let
      # strip .sh suffix if present
      baseName = lib.strings.replace ".sh" "" (builtins.basename f);
    in
    pkgs.writeShellScriptBin baseName (builtins.readFile f)
  );
in
scriptBinaries
