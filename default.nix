{ stdenv, lib, gcc, postgresql, uriparser, pkgconfig }:
let
  extension = "uri";
  version = "1";
in stdenv.mkDerivation {
  name = "pguri-${version}";
  src = ./.;
  buildInputs = [ postgresql gcc uriparser pkgconfig ];
  buildPhase = "USE_PGXS=1 make";
  installPhase = ''
    mkdir -p $out/bin # for buildEnv to setup proper symlinks
    install -D ${extension}.so -t $out/lib/
    install -D ${extension}--${version}.sql ${extension}.control -t $out/share/postgresql/extension
  '';
}
