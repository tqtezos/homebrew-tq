class LorentzContractsSale < Formula
  desc "Haskell to Michelson for Lorentz Sale contract"
  homepage "https://github.com/tqtezos/lorentz-contracts-sale"

  url "https://github.com/tqtezos/lorentz-contracts-sale.git",
      :revision => "ef6b8cf379ac86c4efcb21d5b5c73434a8c967d9"
  version "0.1.0.1"

  head "https://github.com/tqtezos/lorentz-contracts-sale.git"

  bottle do
    root_url "https://dl.bintray.com/michaeljklein/bottles-tq/"
    cellar :any_skip_relocation
    sha256 "bbb7e57e69f18bf2fdeb515456d7f422c62559658afacf9658324234f5f390aa" => :mojave
    sha256 "31dfe79a70b1e7781446763e41e9f04e7c7ee06b43a3fbe126307137cdb8e91c" => :x86_64_linux
  end

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
