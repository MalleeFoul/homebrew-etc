class Gtkxardour < Formula
  homepage "http://gtk.org/"
  url 'http://ardour.org/files/deps/gtk+-2.24.23-quartz-ardour5.tar.bz2'
  sha256 "467ce1fb75d23b509efab6642fa0b4ada3984bc2618465daeb4ba1a0bc4ed87b"
  keg_only "different version of Gtk+"
  desc "GUI toolkit"


  depends_on "pkg-config" => :build
  depends_on "glib"
  depends_on "jpeg"
  depends_on "libtiff"
  depends_on "malleefoul/etc/gdk-pixbuf@2.31" => :build
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
                          "--with-included-loaders=yes",
                          "--prefix=#{prefix}",
                          "--enable-relocation",
                          "--with-gdktarget=quartz",
                          "--disable-glibtest",
                          "--enable-introspection=yes",
                          "--disable-visibility"
    system "make install"
  end
end