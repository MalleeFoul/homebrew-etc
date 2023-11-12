class Gtkxardour < Formula
  desc "GUI toolkit"
  homepage "https://gtk.org/"
  url "https://download.gnome.org/sources/gtk+/2.24/gtk+-2.24.33.tar.xz"
  sha256 "ac2ac757f5942d318a311a54b0c80b5ef295f299c2a73c632f6bfb1ff49cc6da"
  license "LGPL-2.0-or-later"
  revision 1
  keg_only "boooo"

  # From https://blog.gtk.org/2020/12/16/gtk-4-0/:
  # "It does mean, however, that GTK 2 has reached the end of its life.
  # We will do one final 2.x release in the coming days, and we encourage
  # everybody to port their GTK 2 applications to GTK 3 or 4."
  #
  # TODO: Deprecate and remove livecheck once `gtk+` has no active dependents
  livecheck do
    skip "GTK 2 was declared end of life in 2020-12"
  end


  depends_on "gobject-introspection" => :build
  depends_on "pkg-config" => [:build, :test]
  depends_on "atk"
  depends_on "gdk-pixbuf"
  depends_on "hicolor-icon-theme"
  depends_on "pango"

  on_linux do
    depends_on "cairo"
    depends_on "libxcomposite"
    depends_on "libxcursor"
    depends_on "libxdamage"
    depends_on "libxfixes"
    depends_on "libxinerama"
    depends_on "libxrandr"
  end

  # Fix -flat_namespace being used on Big Sur and later.
  patch do
    url "https://raw.githubusercontent.com/Homebrew/formula-patches/03cf8088210822aa2c1ab544ed58ea04c897d9c4/libtool/configure-big_sur.diff"
    sha256 "35acd6aebc19843f1a2b3a63e880baceb0f5278ab1ace661e57a502d9d78c93c"
  end

# patch do
#  url "https://git.ardour.org/ardour/ardour/raw/commit/4ca457bb9ec920e2206aa17f449e1ff561242d42/tools/patches/gtkdnd-quartz.patch"
#    sha256 "b9bbdcd06302da0155534a9c5155b1c11b86834c700c504e635626defa181b00"
#  end

  # patch do
  # url "https://git.ardour.org/ardour/ardour/raw/commit/4ca457bb9ec920e2206aa17f449e1ff561242d42/tools/patches/gtk-osx.patch"
  # sha256 "3b67114cd3ac0510c5638b08f0b36c94a6932ebdf6fc630d8e5414f632ab8b78"
  # end

  # Patch to allow Eiffel Studio to run in Cocoa / non-X11 mode, as well as Freeciv's freeciv-gtk2 client
  # See:
  # - https://gitlab.gnome.org/GNOME/gtk/-/issues/580
  # referenced from
  # - https://bugzilla.gnome.org/show_bug.cgi?id=757187
  # referenced from
  # - https://bugzilla.gnome.org/show_bug.cgi?id=557780
  # - Homebrew/homebrew-games#278

  def backend
    backend = "quartz"
    on_linux do
      backend = "x11"
    end
    backend
  end

  def install
    system "./configure", *std_configure_args,
                          "--disable-silent-rules",
                          "--enable-static",
                          "--disable-glibtest",
                          "--enable-introspection=yes",
                          "--with-gdktarget=#{backend}",
                          "--disable-visibility"
    system "make", "install"

    inreplace bin/"gtk-builder-convert", %r{^#!/usr/bin/env python$}, "#!/usr/bin/python"

    # Prevent a conflict between this and `gtk+3`
    libexec.install bin/"gtk-update-icon-cache"
    bin.install_symlink libexec/"gtk-update-icon-cache" => "gtk2-update-icon-cache"
  end

  def caveats
    <<~EOS
      To avoid a conflict with `gtk+3` formula, `gtk-update-icon-cache` is installed at
        #{opt_libexec}/gtk-update-icon-cache
      A versioned symlink `gtk2-update-icon-cache` is linked for convenience.
    EOS
  end

  test do
    (testpath/"test.c").write <<~EOS
      #include <gtk/gtk.h>

      int main(int argc, char *argv[]) {
        GtkWidget *label = gtk_label_new("Hello World!");
        return 0;
      }
    EOS
    flags = shell_output("pkg-config --cflags --libs gtk+-2.0").chomp.split
    system ENV.cc, "test.c", "-o", "test", *flags
    system "./test"
  end
end
