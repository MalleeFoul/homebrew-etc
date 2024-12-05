# Documentation: https://docs.brew.sh/Cask-Cookbook
#                https://docs.brew.sh/Adding-Software-to-Homebrew#cask-stanzas
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!
cask "zim" do
  version "0.75.2 264_"
  sha256 "53f8dc383fd6e9a39f4e452c0e399013c5b55b3e781d203fadbd759006da1fa0"

  url "https://gitlab.com/api/v4/projects/30529415/packages/generic/zim_macos/0.75.2%2B264/Zim-0.75.2+264_x86_64.dmg"
  name "zim"
  desc ""
  homepage "https://zim-wiki.org/index.html"

  # # Documentation: https://docs.brew.sh/Brew-Livecheck
  # livecheck do
  #   url ""
  #   strategy ""
  # end
  #
  # depends_on macos: ""

  app "zim.app"

  # Documentation: https://docs.brew.sh/Cask-Cookbook#stanza-zap
  zap trash: [
  "~/Library/Application Support/org.zim-wiki.Zim",
  "~/Library/Caches/org.zim-wiki.Zim",
]

end
