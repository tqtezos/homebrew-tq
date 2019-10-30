class LorentzContractParam < Formula
  desc "Haskell to Michelson for Lorentz contract parameters"
  homepage "https://github.com/tqtezos/lorentz-contract-param"

  url "https://github.com/tqtezos/lorentz-contract-param.git",
      :revision => "428d233ae3586d8b681f4ee4faac7196143de5cc"
  version "1.2.0.1.4"

  head "https://github.com/tqtezos/lorentz-contract-param.git"

  # bottle do
  #   root_url "https://dl.bintray.com/michaeljklein/bottles-tq"
  #   cellar :any_skip_relocation
  #   sha256 "84b7a58fcfca547ae608804e2ddd464c9809918d6e8bfdacf06291cef587163c" => :mojave
  #   sha256 "2cd7a349c6c7a14bd186cc826a36b8db50d2e111bc0d880f6e57f4ea148d68ca" => :x86_64_linux
  # end

  unless OS.mac?
    resource "linux-stack" do
      url "https://github.com/commercialhaskell/stack/releases/download/v1.9.3/stack-1.9.3-linux-x86_64-static.tar.gz"
      sha256 "c9bf6d371b51de74f4bfd5b50965966ac57f75b0544aebb59ade22195d0b7543"
    end
  end

  depends_on "haskell-stack" => "1.9.3" if OS.mac?

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
    if OS.mac?
      system "stack", "test"
    end
  end
end
