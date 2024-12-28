# Documentation: https://docs.brew.sh/Formula-Cookbook
#                https://rubydoc.brew.sh/Formula
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!
class Vigra < Formula
  desc "a generic C++ library for image analysis"
  homepage "http://ukoethe.github.io/vigra/"
  url "https://github.com/ukoethe/vigra/archive/refs/tags/Version-1-12-1.tar.gz"
  sha256 "8836a40a340f96ed2abf53780e883c5bf58002eb182cfccb4255b553ca48db33"
  license "NOASSERTION"

  depends_on "cmake" => :build
  depends_on "jpeg" => :build
  depends_on "libtiff" => :build
  depends_on "libpng" => :build
  depends_on "openexr" => :build
  depends_on "hdf5" => :build
  depends_on "fftw" => :build
  depends_on "doxygen" => :build
  depends_on "python" => :build
  depends_on "boost-python3" => :build
  depends_on "sphinx-doc" => :build
  depends_on "numpy" => :build
  depends_on "pytest" => :build
  # depends_on "boost" => :build
  # depends_on "" => :build
  # depends_on "" => :build
  # depends_on "" => :build
  # depends_on "" => :build
  # depends_on "" => :build
  # depends_on "" => :build
  
  patch :DATA
    

  def install
    system "cmake", "-S", ".", "-B", "build", *std_cmake_args, "-DVIGRANUMPY_INSTALL_DIR=#{libdir}/python3.12/site-packages"
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  test do
    # `test do` will create, run in and delete a temporary directory.
    #
    # This test will fail and we won't accept that! For Homebrew/homebrew-core
    # this will need to be a test that verifies the functionality of the
    # software. Run the test with `brew test vigra`. Options passed
    # to `brew install` such as `--HEAD` also need to be provided to `brew test`.
    #
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system bin/"program", "do", "something"`.
    system "false"
  end
end

__END__
diff --git a/CMakeLists.txt b/CMakeLists.txt
index 493cbd7..5f012b8 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -338,16 +338,16 @@ CONFIGURE_FILE(${PROJECT_SOURCE_DIR}/config/package-src.cmake.in
                 ${PROJECT_BINARY_DIR}/package-src.cmake
                 @ONLY IMMEDIATE)
 
-add_custom_target(PACKAGE_SRC_TAR
-                   COMMAND ${CMAKE_COMMAND} -P package-src.cmake
-                   WORKING_DIRECTORY "${PROJECT_BINARY_DIR}"
-                   COMMENT "Creating ${PROJECT_BINARY_DIR}/vigra-${vigra_version}-src.tar.gz")
-
-ADD_DEPENDENCIES(PACKAGE_SRC_TAR check)
-ADD_DEPENDENCIES(PACKAGE_SRC_TAR doc_cpp)
-IF(WITH_VIGRANUMPY AND PYTHON_SPHINX)
-    ADD_DEPENDENCIES(PACKAGE_SRC_TAR doc_python)
-ENDIF()
+# add_custom_target(PACKAGE_SRC_TAR
+#                    COMMAND ${CMAKE_COMMAND} -P package-src.cmake
+#                    WORKING_DIRECTORY "${PROJECT_BINARY_DIR}"
+#                    COMMENT "Creating ${PROJECT_BINARY_DIR}/vigra-${vigra_version}-src.tar.gz")
+
+# ADD_DEPENDENCIES(PACKAGE_SRC_TAR check)
+# ADD_DEPENDENCIES(PACKAGE_SRC_TAR doc_cpp)
+# IF(WITH_VIGRANUMPY AND PYTHON_SPHINX)
+#     ADD_DEPENDENCIES(PACKAGE_SRC_TAR doc_python)
+# ENDIF()
 
 ##################################################
 #
