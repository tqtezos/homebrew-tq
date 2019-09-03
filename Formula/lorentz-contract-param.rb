class LorentzContractParam < Formula
  desc "Haskell to Michelson for Lorentz contract parameters"
  homepage "https://gitlab.com/michaeljklein/morley/tree/lorentz-contract-param"

  url "https://gitlab.com/michaeljklein/morley.git",
      :revision => "7262ada0e63f39154c6b9eb546b5f16f756a867b"
  version "0.3.0.2.4"

  head "https://gitlab.com/michaeljklein/morley.git"

  bottle do
    root_url "https://dl.bintray.com/michaeljklein/bottles-tq"
    cellar :any_skip_relocation
    rebuild 2
    sha256 "631ab9934cc8c27217359b7a3125a1438048bd2a60434667f6965a92f61a5e09" => :mojave
  end

  depends_on "haskell-stack"

  def install
    ENV.deparallelize

    system "stack", "build"

    bin_path_root = File.join `stack path --local-install-root`.chomp, "bin"
    ["lorentz-contract-param",
     "lorentz-contract-storage",
     "lorentz-contracts"].each do |bin_name|
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
  end
end
