{
  description = "finalmouse xlat development nix flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    flake-utils.url = "github:numtide/flake-utils";

    flake-compat = {
      url = "github:edolstra/flake-compat";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, flake-compat, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system: {
      # use nix-shell or nix develop to access this shell
      devShell =
        let
          pkgs = import nixpkgs {
            inherit system;

            config.allowUnfreePredicate = pkg: builtins.elem (nixpkgs.lib.getName pkg) [
              "segger-jlink"
            ];

            config.segger-jlink.acceptLicense = true;
            config.permittedInsecurePackages = [
              "segger-jlink-qt4-810"
            ];
          };
        in
        with pkgs;
        mkShell {
          buildInputs = [
            nixpkgs-fmt
            act # type act to run github actions
            cmake
            ninja
            gcc-arm-embedded
            segger-jlink # JLinkExe to flash to a JLink enabled board

            # I haven't used this myself but in theory you could use this
            # to cross flash to j-link if you could extract the firmware
            # from segger's reflash tool
            stlink-tool
          ];
        };
    });
}
