# Documentation: https://docs.brew.sh/Formula-Cookbook
#                https://rubydoc.brew.sh/Formula
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!
class Gtkxardour < Formula
  desc "GUI toolkit"
  homepage "https://gtk.org/"
  url "http://ardour.org/files/deps/gtk+-2.24.23-quartz-ardour5.tar.bz2"
  sha256 "467ce1fb75d23b509efab6642fa0b4ada3984bc2618465daeb4ba1a0bc4ed87b"
  license "LGPL-2.0-or-later"

  depends_on "gobject-introspection" => :build
  depends_on "pkg-config" => [:build, :test]
  depends_on "atk"
  depends_on "gdk-pixbuf"
  depends_on "hicolor-icon-theme"
  depends_on "pango"

  def backend
    backend = "quartz"
  # depends_on "cmake" => :build

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

  test do
    # `test do` will create, run in and delete a temporary directory.
    #
    # This test will fail and we won't accept that! For Homebrew/homebrew-core
    # this will need to be a test that verifies the functionality of the
    # software. Run the test with `brew test gtk+quartz`. Options passed
    # to `brew install` such as `--HEAD` also need to be provided to `brew test`.
    #
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system "#{bin}/program", "do", "something"`.
    system "false"
  end
end
