# Documentation: https://docs.brew.sh/Formula-Cookbook
#                https://rubydoc.brew.sh/Formula
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!
class QtspellQt5 < Formula
  desc "Spell checking for Qt text widgets"
  homepage "https://github.com/manisandro/qtspell"
  url "https://github.com/manisandro/qtspell/archive/refs/tags/1.0.1.tar.gz"
  sha256 "03bb9ef504dff352e162b91e9da89fb34d236e01da54799db69388dc9ceea4c2"
  license "GPL-3.0"

  depends_on "cmake" => :build
  depends_on "qt@5" => :build
  depends_on "gcc" => :build
  depends_on "gettext" => :build # for libintl
  depends_on "enchant"
  
  keg_only "it conflicts with qtspell"

  # Additional dependency
  # resource "" do
  #   url ""
  #   sha256 ""
  # end

  def install
    
    args = ["-DQT_VER=5"]
    ENV.prepend "LDFLAGS", "-L#{Formula["gettext"].opt_lib}"
    ENV.prepend "CPPFLAGS", "-I#{Formula["gettext"].opt_include}"
    ENV.append "LDFLAGS", "-lintl"

    
    system "cmake", "-S", ".", "-B", "build", *std_cmake_args, *args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  test do
    # `test do` will create, run in and delete a temporary directory.
    #
    # This test will fail and we won't accept that! For Homebrew/homebrew-core
    # this will need to be a test that verifies the functionality of the
    # software. Run the test with `brew test QtSpell`. Options passed
    # to `brew install` such as `--HEAD` also need to be provided to `brew test`.
    #
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system bin/"program", "do", "something"`.
    system "false"
  end
end
