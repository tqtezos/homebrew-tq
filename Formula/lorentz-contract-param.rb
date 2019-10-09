class LorentzContractParam < Formula
  desc "Haskell to Michelson for Lorentz contract parameters"
  homepage "https://github.com/tqtezos/lorentz-contract-param"

  url "https://github.com/tqtezos/lorentz-contract-param.git",
      :revision => "7cab4e03917f907e5cbb1ee7cb9137c7c3c76fbd"
  version "1.2.0.1.3"

  head "https://github.com/tqtezos/lorentz-contract-param.git"

  # bottle do
  #   root_url "https://dl.bintray.com/michaeljklein/bottles-tq"
  #   cellar :any_skip_relocation
  #   rebuild 1 if OS.linux?
  #   sha256 "8776b29565eeb1ef4841526c2371eb1ff7b968b0b75ed833e64aaf5cc556a94b" => :mojave
  #   sha256 "76c96ae4b0b653b776acae40c711c127b5f426036b121c59813a2f86c1c31920" => :x86_64_linux
  # end

  unless OS.mac?
    resource "linux-stack" do
      url "https://github.com/commercialhaskell/stack/releases/download/v2.1.3/stack-2.1.3-linux-x86_64-static.tar.gz"
      sha256 "4e937a6ad7b5e352c5bd03aef29a753e9c4ca7e8ccc22deb5cd54019a8cf130c"
    end
  end

  depends_on "haskell-stack" if OS.mac?

  def install
    ENV.deparallelize

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
    system "stack", "test"
  end
end
