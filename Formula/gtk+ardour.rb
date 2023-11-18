class Gtkxardour < Formula
  homepage 'http://gtk.org/'
  url 'http://ardour.org/files/deps/gtk+-2.24.23-quartz-ardour5.tar.bz2'
  # sha256 'a0a406e27e9b5e7d6b2c4334212706ed5cdcd41e713e66c9ae950655dd61517c'
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

 


# patch do #includes gtkdkd-quartz.patch and GdkQuartzWindow.patch
#   url "https://github.com/MalleeFoul/homebrew-etc/raw/main/patches/gtk%2Bardour.diff"
#   sha256 "c57af68ae5d0fbbc847aa4cb657d79ef52778e71fdf7dbab783d02b79855c5c2" 
# end
# 






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