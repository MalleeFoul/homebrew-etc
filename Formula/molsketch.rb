# Documentation: https://docs.brew.sh/Formula-Cookbook
#                https://rubydoc.brew.sh/Formula
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!
class Molsketch < Formula
  desc ""
  homepage ""
  url "https://github.com/hvennekate/Molsketch/archive/6402a208cbecdea8deac9321cca61e601d672531.zip"
  version "0.8.1"
  HEAD "https://github.com/hvennekate/Molsketch.git"
  sha256 "38f3048686fc7147fc3d972b1b4cb825cdb9de1549caf701b0fed281251e7860"
  license "GPL-2"

  depends_on "cmake" => :build
  depends_on "qt5" => :build
  depends_on "open-babel" => :build

  def install
    system "cmake", "-S", ".", "-B", "build", *std_cmake_args, "-DMSK_PREFIX='#{prefix}'"
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  # test do
  #   # `test do` will create, run in and delete a temporary directory.
  #   #
  #   # This test will fail and we won't accept that! For Homebrew/homebrew-core
  #   # this will need to be a test that verifies the functionality of the
  #   # software. Run the test with `brew test molsketch`. Options passed
  #   # to `brew install` such as `--HEAD` also need to be provided to `brew test`.
  #   #
  #   # The installed folder is not in the path, so use the entire path to any
  #   # executables being tested: `system "#{bin}/program", "do", "something"`.
  #   system "false"
  # end
end

