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

 


patch do #includes gtkdkd-quartz.patch and GdkQuartzWindow.patch
  url "https://github.com/MalleeFoul/homebrew-etc/raw/main/patches/ardour+gtk.diff"
  # sha256 "1c04fe9e8aa8c8ed7ca5b1b1d35fcd4e47a7abf41be701902503648dda84852f" 
end






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