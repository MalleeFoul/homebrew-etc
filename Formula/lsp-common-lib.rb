# Documentation: https://docs.brew.sh/Formula-Cookbook
#                https://rubydoc.brew.sh/Formula
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!
class LspCommonLib < Formula
  desc "Common library for basic language definitions used by LSP Project "
  homepage "https://github.com/lsp-plugins/lsp-common-lib"
  url "https://github.com/lsp-plugins/lsp-common-lib/releases/download/1.0.32/lsp-common-lib-src-1.0.32.tar.gz"
  version "1.0.32"
  sha256 "0a1b976e568bae6c739e01d51e572f4ce9f6d8646b6c5b9b121b6f193d26a8fe"
  license ""

  depends_on "make" => :build
  depends_on "gcc" => :build
  depends_on "pkg-config" => :build
  fails_with :clang


  patch :DATA

  def install # Okay, what the fuck. It fucking works if I use gmake instead of just make? That's fucking weird.
    system "gmake", "config", "PREFIX=#{prefix}"
    system "gmake"
    system "gmake", "install"
  end

  test do
    system "false"
  end
end

__END__
diff --git a/make/tools.mk b/make/tools.mk
index d101291..f7221b0 100644
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
