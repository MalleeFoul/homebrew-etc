# Documentation: https://docs.brew.sh/Formula-Cookbook
#                https://rubydoc.brew.sh/Formula
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!
class Sf2dlib < Formula
  desc "Simple and Fast 2D library for the Nintendo 3DS (using ctrulib)"
  homepage "https://github.com/xerpi/sf2dlib/tree/master"
  version "1.0"
  license "MIT"
  sha256 "7c0ef86582ee52b345a537fd18a708e2529f43c1a4b5c1fe07abe14d1f2321ed"
  url "https://github.com/acmiyaguchi/sf2dlib/archive/refs/heads/latest.zip"

  # depends_on "cmake" => :build

  def install
    # ENV.deparallelize  # if your formula fails when building in parallel
    # Remove unrecognized options if warned by configure
    # https://rubydoc.brew.sh/Formula.html#std_configure_args-instance_method
    system "cd", "libsf2d"
    system "make"
    system "make", "install"
    # system "cmake", "-S", ".", "-B", "build", *std_cmake_args
  end

  test do
    # `test do` will create, run in and delete a temporary directory.
    #
    # This test will fail and we won't accept that! For Homebrew/homebrew-core
    # this will need to be a test that verifies the functionality of the
    # software. Run the test with `brew test sf2dlib`. Options passed
    # to `brew install` such as `--HEAD` also need to be provided to `brew test`.
    #
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system "#{bin}/program", "do", "something"`.
    system "false"
  end
end
