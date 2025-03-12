# Documentation: https://docs.brew.sh/Formula-Cookbook
#                https://rubydoc.brew.sh/Formula
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!
class Gimagereader < Formula
  desc "A Gtk/Qt front-end to tesseract-ocr."
  homepage "https://github.com/manisandro/gImageReader"
  url "https://github.com/manisandro/gImageReader/archive/refs/tags/v3.4.2.tar.gz"
  sha256 "a99e4e653a80e13e766b3b67606f1c2874961e28f3d95591b7ca9ddd9d7dc088"
  license "GPL-3.0"
  version "3.4.2"

  depends_on "cmake" => :build
  depends_on "tesseract"
  depends_on "qt"
  depends_on "sane-backends"
  depends_on "podofo"
  depends_on "libjpeg"
  depends_on "djvulibre"
  depends_on "intltool"
  depends_on "intltool"
  depends_on "libxml++"
  depends_on "poppler"
  depends_on "poppler-qt6"
  depends_on "qtspell"
  depends_on "json-glib"
  depends_on "quazip"
  
  
  # Additional dependency
  # resource "" do
  #   url ""
  #   sha256 ""
  # end

  def install
    args = [
      "-DINTERFACE_TYPE=qt6"
    ]
    
    system "cmake", "-S", ".", "-B", "build", *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  test do
    # `test do` will create, run in and delete a temporary directory.
    #
    # This test will fail and we won't accept that! For Homebrew/homebrew-core
    # this will need to be a test that verifies the functionality of the
    # software. Run the test with `brew test gImageReader`. Options passed
    # to `brew install` such as `--HEAD` also need to be provided to `brew test`.
    #
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system bin/"program", "do", "something"`.
    system "false"
  end
end
