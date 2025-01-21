{
  description = "vala-dbus-binding-tool";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    self,
    nixpkgs,
    flake-utils,
  }:
    flake-utils.lib.eachDefaultSystem (
      system: let
        pkgs = nixpkgs.legacyPackages.${system};

        vala-dbus-binding-tool = pkgs.stdenv.mkDerivation {
          name = "vala-dbus-binding-tool";
          src = ./.;

          nativeBuildInputs = with pkgs; [
            autoconf
            automake
            git
            glib
            gobject-introspection
            gnum4
            libgee
            libtool
            libxml2
            pkg-config
            vala
          ];

          buildPhase = ''
            ./autogen.sh
            make
          '';
        };
      in {
        packages.default = vala-dbus-binding-tool;
      }
    );
}
