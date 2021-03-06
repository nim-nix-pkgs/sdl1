{
  description = ''SDL 1.2 wrapper for Nim.'';

  inputs.flakeNimbleLib.owner = "riinr";
  inputs.flakeNimbleLib.ref   = "master";
  inputs.flakeNimbleLib.repo  = "nim-flakes-lib";
  inputs.flakeNimbleLib.type  = "github";
  inputs.flakeNimbleLib.inputs.nixpkgs.follows = "nixpkgs";
  
  inputs."sdl1-master".dir   = "master";
  inputs."sdl1-master".owner = "nim-nix-pkgs";
  inputs."sdl1-master".ref   = "master";
  inputs."sdl1-master".repo  = "sdl1";
  inputs."sdl1-master".type  = "github";
  inputs."sdl1-master".inputs.nixpkgs.follows = "nixpkgs";
  inputs."sdl1-master".inputs.flakeNimbleLib.follows = "flakeNimbleLib";
  
  outputs = { self, nixpkgs, flakeNimbleLib, ...}@inputs:
  let 
    lib  = flakeNimbleLib.lib;
    args = ["self" "nixpkgs" "flakeNimbleLib"];
  in lib.mkProjectOutput {
    inherit self nixpkgs;
    meta = builtins.fromJSON (builtins.readFile ./meta.json);
    refs = builtins.removeAttrs inputs args;
  };
}