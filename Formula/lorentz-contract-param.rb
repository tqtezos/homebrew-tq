class LorentzContractParam < Formula
  desc "Haskell to Michelson for Lorentz contract parameters"
  homepage "https://github.com/tqtezos/lorentz-contract-param"

  url "https://github.com/tqtezos/lorentz-contract-param.git",
      :revision => "428d233ae3586d8b681f4ee4faac7196143de5cc"
  version "1.2.0.1.4"

  head "https://github.com/tqtezos/lorentz-contract-param.git"

  bottle do
    root_url "https://dl.bintray.com/michaeljklein/bottles-tq"
    cellar :any_skip_relocation
    sha256 "76e959f1de7f507014be7b93d00a1985a6ed26c06d934e151b26c033bdcbe40c" => :mojave
    sha256 "cc14e6c6b356073a2da22c66882e6951f84394211152f2b5b5c584e6ecb63284" => :x86_64_linux
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
    ["lorentz-contract-param",
     "lorentz-contract-storage",
     "lorentz-contract"].each do |bin_name|
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
    assert_predicate bin/"lorentz-contract-param", :exist?
    assert_predicate bin/"lorentz-contract-storage", :exist?
    assert_predicate bin/"lorentz-contract", :exist?
    if OS.mac?
      system "stack", "test"
    end
  end
end
