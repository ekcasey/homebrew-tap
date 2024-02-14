cask "testcontainers-desktop" do
  version "1.8.0"
  sha256 "0760cf82e922a67b54dffea458f15e5f023b732441b616b503c84f1d006fef84"

  url "https://app.testcontainers.cloud/download/testcontainers-desktop_#{version}_darwin_universal.dmg",
      user_agent: "brew-cask"
  name "Testcontainers Desktop"
  desc "Tescontainers desktop application for local testing and development"
  homepage "https://app.testcontainers.cloud/"

  livecheck do
    url "https://app.testcontainers.cloud/api/versions"
    strategy :page_match do |page|
      JSON.parse(page)["latest"]
    end
  end

  auto_updates true
  conflicts_with cask: "testcontainers-cloud-desktop"

  app "Testcontainers Desktop.app"

  postflight do
    system_command "open",
                   args: ["#{appdir}/Testcontainers Desktop.app"]
  end

  uninstall quit:   "com.atomicjar.desktop",
            delete: [
              "~/Library/Caches/AtomicJar/testcontainers.cloud.desktop/agent.lock",
              "~/Library/Caches/AtomicJar/testcontainers.cloud.desktop/tcc-notification.png",
            ]

  zap delete: "~/Library/LaunchAgents/testcontainers.desktop.plist",
      trash:  [
        "~/.config/testcontainers/cloud.properties",
        "~/.config/testcontainers/services",
        "~/Library/Caches/AtomicJar",
        "~/Library/Logs/AtomicJar",
      ]
end
