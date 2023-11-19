# Documentation: https://docs.brew.sh/Formula-Cookbook
#                https://rubydoc.brew.sh/Formula
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!
class LspDspLib < Formula
  desc ""
  homepage ""
  url "https://github.com/lsp-plugins/lsp-dsp-lib/archive/refs/tags/1.0.19.zip"
  sha256 "11e4c8da6c4f6761a00e8dc80fa9b8f4c1493f240fc095cb3b9c446a2d075bac"
  license ""

  # depends_on "cmake" => :build
  depends_on "make" => :build
  depends_on "malleefoul/etc/lsp-common-lib" => :build
  fails_with :clang

  def install
    # ENV.deparallelize  # if your formula fails when building in parallel
    # Remove unrecognized options if warned by configure
    # https://rubydoc.brew.sh/Formula.html#std_configure_args-instance_method
    system "make", "config", "PREFIX=#{prefix}", "LIBDIR=#{lib}"
    system "make", "fetch"
    system "make"
    system "make", "install"
    
    # system "./configure", *std_configure_args, "--disable-silent-rules"
    # system "cmake", "-S", ".", "-B", "build", *std_cmake_args
  end

  test do
    # `test do` will create, run in and delete a temporary directory.
    #
    # This test will fail and we won't accept that! For Homebrew/homebrew-core
    # this will need to be a test that verifies the functionality of the
    # software. Run the test with `brew test lsp-dsp-lib`. Options passed
    # to `brew install` such as `--HEAD` also need to be provided to `brew test`.
    #
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system "#{bin}/program", "do", "something"`.
    system "false"
  end
end
