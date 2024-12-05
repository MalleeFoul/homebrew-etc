# Documentation: https://docs.brew.sh/Formula-Cookbook
#                https://rubydoc.brew.sh/Formula
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!
class Psximager < Formula
  desc "Tools for dumping and mastering PlayStation 1 (PSX) CD-ROM images"
  homepage "https://github.com/cebix/psximager"
  url "https://codeload.github.com/cebix/psximager/zip/refs/tags/v2.2"
  sha256 "87d41c1e1dc450fe6e76dd8e7684cc0b9e407a4b9378e3570c33e88bd4fde235"
  license ""
  
  depends_on "libcdio" => :build
  depends_on "libisofs" => :build
  depends_on "vcdimager" => :build
  depends_on "autoconf"
  depends_on "automake"


  def install
    system "./bootstrap"
    system "./configure", "--disable-silent-rules", *std_configure_args
    system "make", "install" # if this fails, try separate make/make install steps
  end 

# seems to work ig. Will make it good whenever I have time lol
  test do
    # `test do` will create, run in and delete a temporary directory.
    #
    # This test will fail and we won't accept that! For Homebrew/homebrew-core
    # this will need to be a test that verifies the functionality of the
    # software. Run the test with `brew test psximager`. Options passed
    # to `brew install` such as `--HEAD` also need to be provided to `brew test`.
    #
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system bin/"program", "do", "something"`.
    system "false"
  end
end
