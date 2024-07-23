require_relative "../kdelib/cmake"

class Kf6Knotifications < Formula
  desc "Abstraction for system notifications"
  homepage "https://api.kde.org/frameworks/knotifications/html/index.html"
  url "https://invent.kde.org/frameworks/knotifications/-/archive/v6.4.0/knotifications-v6.4.0.tar.gz"
  version "6.4.0"
  sha256 "a65e80f5f04b3b17f899899c76a3eb71169091e9ba3b25ffe8261c6cf26fb4fa"
  head "https://invent.kde.org/frameworks/knotifications.git", branch: "master"


  depends_on "cmake" => [:build, :test]
  depends_on "doxygen" => :build
  depends_on "extra-cmake-modules" => [:build, :test]
  depends_on "graphviz" => :build
  depends_on "ninja" => :build
  
  depends_on "malleefoul/etc/kf6-kcodecs"
  depends_on "malleefoul/etc/kf6-kconfig"
  depends_on "malleefoul/etc/kf6-kcoreaddons"
  depends_on "malleefoul/etc/kf6-kwindowsystem"
  depends_on "kde-mac/kde/phonon"
  depends_on "libcanberra"

  def install
    # setBadgeLabelText method is deprecated since 5.12
    args = %w[
      -DCMAKE_C_FLAGS_RELEASE=-DNDEBUG
      -DQT_DISABLE_DEPRECATED_BEFORE=0x050b00
      -DCMAKE_CXX_FLAGS_RELEASE=-DNDEBUG
      -DQT_DISABLE_DEPRECATED_BEFORE=0x050b00
    ]

    system "cmake", *args, *kde_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
    prefix.install "build/install_manifest.txt"
  end
  
  def caveats
    <<~EOS
      You need to take some manual steps in order to make this formula work:
        "$(brew --repo kde-mac/kde)/tools/do-caveats.sh"
    EOS
  end

  test do
    (testpath/"CMakeLists.txt").write("find_package(KF6Notifications REQUIRED)")
    system "cmake", ".", "-Wno-dev"
  end
end
