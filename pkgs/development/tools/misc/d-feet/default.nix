{ stdenv, pkgconfig, fetchurl, itstool, intltool, libxml2, glib, gtk3, gnome_icon_theme, pango, gdk_pixbuf, atk, pep8, python, makeWrapper, pygobject3, gobjectIntrospection, libwnck3 }:

let
  version = "${major}.8";
  major = "0.3";
in

stdenv.mkDerivation rec {
  name = "d-feet-${version}";

  src = fetchurl {
    url = "http://download.gnome.org/sources/d-feet/${major}/d-feet-${version}.tar.xz";
    sha256 = "e8423feb18fdff9b1465bf8442b78994ba13c12f8fa3b08e6a2f05768b4feee5";
  };

  buildInputs = [
    pkgconfig libxml2 itstool intltool glib gtk3 pep8 python makeWrapper pygobject3 libwnck3
  ];

  # TODO: shouldn't this be created automagicaly?
  gi_typelib_path = stdenv.lib.concatStringsSep ":" (
    map (pkg: "${pkg}/lib/girepository-1.0") [ gtk3 pango gdk_pixbuf atk gobjectIntrospection libwnck3 ]);

  postInstall =
    ''
      wrapProgram $out/bin/d-feet \
        --prefix PYTHONPATH : "$(toPythonPath $out):$(toPythonPath ${pygobject3})" \
        --prefix GI_TYPELIB_PATH : "${gi_typelib_path}" \
        --prefix LD_LIBRARY_PATH : "${gtk3}/lib:${atk}/lib:${libwnck3}/lib" \
        --prefix XDG_DATA_DIRS : "${gnome_icon_theme}/share:$out/share"
    '';

  meta = {
    description = "D-Feet is an easy to use D-Bus debugger";

    longDescription = ''
      D-Feet can be used to inspect D-Bus interfaces of running programs
      and invoke methods on those interfaces.
    '';

    homepage = https://wiki.gnome.org/action/show/Apps/DFeet;
  };
}
