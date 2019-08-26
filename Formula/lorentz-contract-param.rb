class LorentzContractParam < Formula
  desc "Haskell to Michelson for Lorentz contract parameters"
  homepage "https://gitlab.com/michaeljklein/morley/tree/lorentz-contract-param"

  url "https://gitlab.com/michaeljklein/morley.git",
      :revision => "dd61b48945d6f49188f8e3e7bb46ea7d2f6f377e"
  version "0.3.0.2.3"

  head "https://gitlab.com/michaeljklein/morley.git"

  bottle do
    root_url "https://bintray.com/michaeljklein/bottles-tq"
    cellar :any_skip_relocation
    sha256 "ff052cf8f6134f384c2db7b66a79607a80afcff8f2f1e46f9d0c8c48a8e0ed42" => :mojave
  end

  depends_on "haskell-stack"

  def install
    ENV.deparallelize

    system "stack", "build"

    bin_path = File.join `stack path --local-install-root`.chomp, "bin/lorentz-contract-param"

    if File.exist?(bin_path) && File.executable?(bin_path)
      bin.mkpath
      bin.install bin_path
    else
      raise "#{bin_path} either missing or not executable"
    end
  end

  test do
    assert_predicate bin/"lorentz-contract-param", :exist?
  end
end
