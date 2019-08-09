class LorentzContractParam < Formula
  desc "Haskell to Michelson for Lorentz contract parameters"
  homepage "https://gitlab.com/michaeljklein/morley/tree/lorentz-contract-param"

  url "https://gitlab.com/michaeljklein/morley.git",
      :revision => "3c3480ab5b70be007cd4bb8a06a5ffc6f48f168b"
  version "0.3.0.2.2"

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
