# Documentation: https://docs.brew.sh/Formula-Cookbook
#                https://rubydoc.brew.sh/Formula
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!
class Stoat < Formula
  desc ""
  homepage ""
  url "https://github.com/fundamental/stoat/archive/refs/tags/v1.1.tar.gz"
  sha256 "66bc2a446025e0040384917c951faacd6ac457615cfa11e56304e4b4db8d463b"
  license ""
  head "https://github.com/fundamental/stoat.git", branch: "master"

  depends_on "cmake" => :build
  depends_on "graphviz" => :build

  def install
    # ENV.deparallelize  # if your formula fails when building in parallel
    system "cmake", "-S", ".", "-B", "build", *std_cmake_args
    system "cmake", "--build", "build"
    system "make"
    system "make", "install"
    # system "cmake", "--install", "build"
  end

  test do
    # `test do` will create, run in and delete a temporary directory.
    #
    # This test will fail and we won't accept that! For Homebrew/homebrew-core
    # this will need to be a test that verifies the functionality of the
    # software. Run the test with `brew test stoat`. Options passed
    # to `brew install` such as `--HEAD` also need to be provided to `brew test`.
    #
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system "#{bin}/program", "do", "something"`.
    system "false"
  end
end
