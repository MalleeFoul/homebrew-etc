# Documentation: https://docs.brew.sh/Formula-Cookbook
#                https://rubydoc.brew.sh/Formula
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!
class Hugin < Formula
  desc "Panorama photo stitcher"
  homepage "https://hugin.sourceforge.io/"
  url "https://sourceforge.net/projects/hugin/files/hugin/hugin-2024.0/hugin-2024.0.1.tar.bz2/download"
  version "2024.0.1"
  sha256 "13ec0cdeeb4eb63149c833768d3e374e7cf5a6a8d8d02d50885ce496f05ba7e4"
  license "GPL-2.0"
  head "http://hg.code.sf.net/p/hugin/hugin hugin-hugin", using: :hg

  depends_on "cmake" => :build
  depends_on "wxwidgets" => :build
  depends_on "malleefoul/etc/vigra" => :build
  depends_on "flann" => :build
  depends_on "lapack" => :build
  depends_on "libepoxy" => :build
  depends_on "glew" => :build
  depends_on "freeglut" => :build
  depends_on "libtiff" => :build
  depends_on "libpano" => :build
  depends_on "jpeg" => :build
  depends_on "libpng" => :build
  depends_on "exiv2" => :build
  depends_on "openexr" => :build
  depends_on "gettext" => :build
  depends_on "sqlite" => :build
  depends_on "little-cms2" => :build
  depends_on "fftw" => :build
  depends_on "libxi" => :build
  depends_on "libxmu" => :build
  depends_on "python-setuptools" => :build
  depends_on "swig" => :build
  depends_on "exiftool" => :build
  depends_on "argparse" => :build
  depends_on "libomp" => :build
# just in case I forget something :3
  # depends_on "" => :build
  # depends_on "" => :build
  # depends_on "" => :build
  
  

  def install
    system "cmake", "-S", ".", "-B", "build", *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  test do
    # `test do` will create, run in and delete a temporary directory.
    #
    # This test will fail and we won't accept that! For Homebrew/homebrew-core
    # this will need to be a test that verifies the functionality of the
    # software. Run the test with `brew test hugin`. Options passed
    # to `brew install` such as `--HEAD` also need to be provided to `brew test`.
    #
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system bin/"program", "do", "something"`.
    system "false"
  end
end
