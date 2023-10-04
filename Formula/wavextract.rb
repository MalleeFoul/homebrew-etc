# Documentation: https://docs.brew.sh/Formula-Cookbook
#                https://rubydoc.brew.sh/Formula
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!
class Wavextract < Formula
  desc ""
  homepage ""
  url "https://github.com/vfspirit/wavextract/archive/refs/tags/v1.0.1.tar.gz"
  sha256 "6aa61883d8989d88543e390a35dd0b6fd04cbc8e8de3b0effd48715577314eda"
  license ""

  depends_on "cmake" => :build

  def install
    # ENV.deparallelize  # if your formula fails when building in parallel
    system "cmake", "-S", ".", "-B", "build", *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  test do
    # `test do` will create, run in and delete a temporary directory.
    #
    # This test will fail and we won't accept that! For Homebrew/homebrew-core
    # this will need to be a test that verifies the functionality of the
    # software. Run the test with `brew test wavextract`. Options passed
    # to `brew install` such as `--HEAD` also need to be provided to `brew test`.
    #
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system "#{bin}/program", "do", "something"`.
    system "false"
  end
end
