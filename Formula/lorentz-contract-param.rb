class LorentzContractParam < Formula
  desc "Haskell to Michelson for Lorentz contract parameters"
  homepage "https://gitlab.com/michaeljklein/morley/tree/lorentz-contract-param"

  url "https://gitlab.com/michaeljklein/morley.git",
      :revision => "dd61b48945d6f49188f8e3e7bb46ea7d2f6f377e"
  version "0.3.0.2.3"

  head "https://gitlab.com/michaeljklein/morley.git", :branch => "lorentz-contract-param"

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
