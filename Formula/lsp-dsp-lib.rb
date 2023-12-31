# Documentation: https://docs.brew.sh/Formula-Cookbook
#                https://rubydoc.brew.sh/Formula
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!
class LspDspLib < Formula
  desc ""
  homepage ""
  url "https://github.com/lsp-plugins/lsp-dsp-lib/archive/refs/tags/1.0.19.tar.gz"
  sha256 "54ee7781a7980b4a0b4fa800af4d54eac153298a13600dfe68a5d0102718c406"
  license ""

  depends_on "make" => :build
  depends_on "gcc" => :build
  depends_on "pkg-config" => :build
  # depends_on "llvm"
  depends_on "malleefoul/etc/lsp-common-lib" => :build

  fails_with :clang

  patch :DATA
  def install
    system "gmake", "config", "PREFIX=#{prefix}", "LSP_COMMON_LIB_PATH=#{Formula["lsp-common-lib"].prefix}"
    system "gmake"
    system "gmake", "install"
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

__END__
diff --git a/make/tools.mk b/make/tools.mk
index 393707f..c9c3806 100644
--- a/make/tools.mk
+++ b/make/tools.mk
@@ -62,7 +62,7 @@ GIT                ?= $(X_GIT_TOOL)
 INSTALL            ?= $(X_INSTALL_TOOL)
 
 # Patch flags and tools for (cross) build
-FLAG_RELRO          = -Wl,-z,relro,-z,now
+#~ FLAG_RELRO          = -Wl,-z,relro,-z,now
 FLAG_STDLIB         = 
 CFLAGS_EXT          = $(ARCHITECTURE_CFLAGS)
 CXXFLAGS_EXT        = $(ARCHITECTURE_CFLAGS)
@@ -162,8 +162,8 @@ CXXDEFS            += -DLSP_INSTALL_PREFIX=\\\"$(PREFIX)\\\"
 
 INCLUDE            :=
 LDFLAGS            := $(LDFLAGS_EXT) -r
-EXE_FLAGS          := $(EXE_FLAGS_EXT) $(FLAG_RELRO) -Wl,--gc-sections
-SO_FLAGS           := $(SO_FLAGS_EXT) $(FLAG_RELRO) -Wl,--gc-sections -shared $(FLAG_STDLIB) -fPIC 
+EXE_FLAGS          := $(EXE_FLAGS_EXT) $(FLAG_RELRO) -Wl,-dead_strip
+SO_FLAGS           := $(SO_FLAGS_EXT) $(FLAG_RELRO) -Wl,-dead_strip -shared $(FLAG_STDLIB) -fPIC 
 
 # Define flags for host build
 HOST_CFLAGS        := $(CFLAGS)
