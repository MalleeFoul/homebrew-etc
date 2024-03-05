# Documentation: https://docs.brew.sh/Formula-Cookbook
#                https://rubydoc.brew.sh/Formula
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!
class Parlatype < Formula
  desc "GNOME audio player for transcription"
  homepage "https://www.parlatype.org"
  url "https://github.com/gkarsay/parlatype/releases/download/v4.0/parlatype-4.0.tar.gz"
  version "4.0"
  sha256 "0f24df07a7d5afa30d306c7d56d145b7deba6eb9ce1952c2604599c638b4bc9c"
  license "GPL-3.0"
  head "https://github.com/gkarsay/parlatype.git"

  depends_on "meson" => :build
  depends_on "ninja" => :build
  depends_on "gettext" => :build
  depends_on "gobject-introspection" => :build
  depends_on "yelp-tools"
  depends_on "gtk4"
  depends_on "glib"
  depends_on "libadwaita"
  depends_on "iso-codes"
  depends_on "gstreamer"
  depends_on "desktop-file-utils"
  depends_on "gtk-doc"
  depends_on "cmu-pocketsphinx"

  def install
    system "meson", "setup", "build", *std_meson_args
    system "meson", "compile", "-C", "build", "--verbose"
    system "meson", "install", "-C", "build"
  end

  test do
    # `test do` will create, run in and delete a temporary directory.
    #
    # This test will fail and we won't accept that! For Homebrew/homebrew-core
    # this will need to be a test that verifies the functionality of the
    # software. Run the test with `brew test parlatype`. Options passed
    # to `brew install` such as `--HEAD` also need to be provided to `brew test`.
    #
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system "#{bin}/program", "do", "something"`.
    system "false"
  end
end
