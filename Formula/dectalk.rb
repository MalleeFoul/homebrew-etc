# Documentation: https://docs.brew.sh/Formula-Cookbook
#                https://rubydoc.brew.sh/Formula
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!
class Dectalk < Formula
  desc "Modern builds for the 90s/00s DECtalk text-to-speech application. "
  homepage "https://dectalk.github.io/dectalk/dectalk.htm"
  url "https://github.com/dectalk/dectalk/archive/refs/tags/2023-10-30.zip"
  sha256 "ad07202f8093d0a295acbfc1b8662f43bd2c1a100c237ab9089d134aa99f09f1"

  depends_on "autoconf" => :build

  def install
    # ENV.deparallelize  # if your formula fails when building in parallel
    # Remove unrecognized options if warned by configure
    # https://rubydoc.brew.sh/Formula.html#std_configure_args-instance_method

    system "cd", "src/"
    # system "autoreconf", "-si"
    system "./configure", *std_configure_args, "--disable-silent-rules"
    system "make", "install" # if this fails, try separate make/make install steps
  end

  test do
    # `test do` will create, run in and delete a temporary directory.
    #
    # This test will fail and we won't accept that! For Homebrew/homebrew-core
    # this will need to be a test that verifies the functionality of the
    # software. Run the test with `brew test DECtalk`. Options passed
    # to `brew install` such as `--HEAD` also need to be provided to `brew test`.
    #
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system "#{bin}/program", "do", "something"`.
    system "false"
  end
end
