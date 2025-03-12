# Documentation: https://docs.brew.sh/Formula-Cookbook
#                https://rubydoc.brew.sh/Formula
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!
class Enblend < Formula
  desc "Enblend blends away the seams in a panoramic image mosaic using a multi-resolution spline."
  homepage "http://enblend.sourceforge.net/"
  url "https://ixpeering.dl.sourceforge.net/project/enblend/enblend-enfuse/enblend-enfuse-4.2/enblend-enfuse-4.2.tar.gz"
  version "4.2"
  sha256 "8703e324939ebd70d76afd350e56800f5ea2c053a040a5f5218b2a1a4300bd48"
  license "GPL-2.0"
  
  depends_on "perl" => :build
  depends_on "texlive" => :build
  depends_on "boost" => :build
  depends_on "jpeg" => :build
  depends_on "openexr" => :build
  depends_on "malleefoul/etc/vigra" => :build
  depends_on "gsl" => :build
  depends_on "little-cms2" => :build
  depends_on "opencl-headers" => :build
  # depends_on "opencl-clhpp-headers" => :build
  depends_on "libclc" => :build
  # I need for "find OpenCL" to work
  depends_on "openexr" => :build
  depends_on "libpng" => :build
  depends_on "gperftools" => :build
  depends_on "dmalloc" => :build
  # one of these will work, idk which
  depends_on "libtiff" => :build
  depends_on "zlib" => :build
  depends_on "libxml2" => :build
  depends_on "dyld-headers" => :build
  # depends_on "" => :build
  # depends_on "" => :build
  # depends_on "" => :build
  # depends_on "" => :build
  # depends_on "" => :build
  # depends_on "" => :build
  # depends_on "" => :build
  # depends_on "" => :build
  # depends_on "" => :build
  # depends_on "" => :build
  # depends_on "" => :build


  def install
    # Remove unrecognized options if they cause configure to fail
    # https://rubydoc.brew.sh/Formula.html#std_configure_args-instance_method
    system "./configure", "--disable-silent-rules", *std_configure_args
    system "make", "install" # if this fails, try separate make/make install steps
  end

  test do
    # `test do` will create, run in and delete a temporary directory.
    #
    # This test will fail and we won't accept that! For Homebrew/homebrew-core
    # this will need to be a test that verifies the functionality of the
    # software. Run the test with `brew test enblend`. Options passed
    # to `brew install` such as `--HEAD` also need to be provided to `brew test`.
    #
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system bin/"program", "do", "something"`.
    system "false"
  end
end
