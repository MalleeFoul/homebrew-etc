class Gtkxardour < Formula
  homepage 'http://gtk.org/'
  url 'http://ftp.gnome.org/pub/gnome/sources/gtk+/2.24/gtk+-2.24.23.tar.xz'
  sha256 'a0a406e27e9b5e7d6b2c4334212706ed5cdcd41e713e66c9ae950655dd61517c'
  keg_only "different version of Gtk+"
  desc "GUI toolkit"


  depends_on "pkg-config" => :build
  depends_on "glib"
  depends_on "jpeg"
  depends_on "libtiff"
  depends_on "gdk-pixbuf"
  depends_on "pango"
  depends_on "jasper" => :optional
  depends_on "atk"
  depends_on "cairo"
  depends_on "libx11" => :build
  depends_on "gobject-introspection"

  # patch :p2 do
  #   url "https://github.com/Ardour/ardour/raw/master/tools/patches/gtk-osx.patch"
  #   sha256 "3b67114cd3ac0510c5638b08f0b36c94a6932ebdf6fc630d8e5414f632ab8b78"
  # end

# patch do
#   url "https://github.com/Ardour/ardour/raw/master/tools/patches/gtkdnd-quartz.patch"
#   sha256 "b9bbdcd06302da0155534a9c5155b1c11b86834c700c504e635626defa181b00"
# end

patch do #includes gtkdkd-quartz.patch and GdkQuartzWindow.patch
  url ""
  sha256 "1ccfa44a09cddb450fe8fb3e19b271b8c64951cffbd0abd8c250438591617ead" 






  fails_with :llvm do
    build 2326
    cause "Undefined symbols when linking"
  end



  def install
    system "./configure", "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}",
                          "--enable-relocation",
                          "--with-gdktarget=quartz",
                          "--disable-glibtest",
                          "--enable-introspection=yes",
                          "--disable-visibility"
    system "make install"
  end
end