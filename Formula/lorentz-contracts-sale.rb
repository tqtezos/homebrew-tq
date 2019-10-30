class LorentzContractsSale < Formula
  desc "Haskell to Michelson for Lorentz Sale contract and parameters"
  homepage "https://github.com/tqtezos/lorentz-contracts-sale"

  url "https://github.com/tqtezos/lorentz-contracts-sale.git",
      :revision => "a5e924b354df1389e4a775be2028a150eb4cb668"
  version "0.1.0.0"

  head "https://github.com/tqtezos/lorentz-contracts-sale.git"

  unless OS.linux?
    resource "mac-stack" do
      url "https://github.com/commercialhaskell/stack/releases/download/v1.9.3/stack-1.9.3-osx-x86_64.tar.gz"
      sha256 "05ff745b88fb24911aa6b7e2b2e7098f04c2fdf769f00f921d44ffecbc417bc2"
    end
  end

  unless OS.mac?
    resource "linux-stack" do
      url "https://github.com/commercialhaskell/stack/releases/download/v1.9.3/stack-1.9.3-linux-x86_64-static.tar.gz"
      sha256 "c9bf6d371b51de74f4bfd5b50965966ac57f75b0544aebb59ade22195d0b7543"
    end
  end

  # depends_on "haskell-stack" => "1.9.3" if OS.mac?

  def install
    ENV.deparallelize

    if OS.mac?
      (buildpath/"mac-stack").install resource("mac-stack")
      ENV.append_path "PATH", "#{buildpath}/mac-stack"
    end
    if OS.linux?
      (buildpath/"linux-stack").install resource("linux-stack")
      ENV.append_path "PATH", "#{buildpath}/linux-stack"
    end

    system "stack", "build"

    bin_path_root = File.join `stack path --local-install-root`.chomp, "bin"
    ["lorentz-contracts-sale"].each do |bin_name|
      bin_path = File.join bin_path_root, bin_name
      if File.exist?(bin_path) && File.executable?(bin_path)
        bin.mkpath
        bin.install bin_path
      else
        raise "#{bin_path} either missing or not executable"
      end
    end
  end

  test do
    assert_predicate bin/"lorentz-contracts-sale", :exist?
  end
end
