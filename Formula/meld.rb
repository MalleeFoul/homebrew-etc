# Documentation: https://docs.brew.sh/Formula-Cookbook
#                https://rubydoc.brew.sh/Formula
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!
class Meld < Formula
  desc "Meld is a visual diff and merge tool targeted at developers."
  homepage "https://gitlab.gnome.org/GNOME/meld"
  url "https://gitlab.gnome.org/GNOME/meld/-/archive/3.22.2/meld-3.22.2.tar.gz"
  sha256 "074b9aa988fb824b0d31d0760df0f0c9c6b0138cca948668a19adbfd03b003f0"
  license ""

  depends_on "meson" => :build
  depends_on "ninja" => :build
  depends_on "glib" => :build
  depends_on "pango" => :build
  depends_on "python@3.13" => :build
  depends_on "cairo" => :build
  depends_on "py3cairo" => :build
  depends_on "pygobject3" => :build
  depends_on "gtk+3" => :build
  depends_on "gsettings-desktop-schemas" => :build
  depends_on "gettext" => :build
  depends_on "harfbuzz"
  depends_on "fribidi"
  depends_on "gdk-pixbuf"
  

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
    # software. Run the test with `brew test meld`. Options passed
    # to `brew install` such as `--HEAD` also need to be provided to `brew test`.
    #
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system bin/"program", "do", "something"`.
    system "false"
  end
end
