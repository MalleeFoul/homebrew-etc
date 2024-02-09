# Documentation: https://docs.brew.sh/Formula-Cookbook
#                https://rubydoc.brew.sh/Formula
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!
class Tipp10 < Formula
  desc "Open source GUI touch typing program"
  homepage "https://www.tipp10.com/en/"
  url "https://gitlab.com/tipp10/tipp10/-/archive/v3.3.1/tipp10-v3.3.1.tar.gz"
  version "3.3.1"
  sha256 "d3912d37c51c60696c1167981b38b82ac77a5dc4f829a22de58c96851d6f960b"
  license "GPL-2.0-or-later"
  head "https://gitlab.com/tipp10/tipp10.git", branch: "master"

  depends_on "cmake" => :build
  depends_on "qt" => :build
  depends_on "vulkan-headers" => :build
  def install
    system "cmake", "-S", ".", "-B", "build", *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

end
