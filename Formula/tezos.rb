class Tezos < Formula
  @all_bins = []

  class << self
    attr_accessor :all_bins
  end

  desc "Platform for distributed consensus with meta-consensus capability"
  homepage "https://gitlab.com/tezos/tezos"

  url "https://gitlab.com/tezos/tezos.git",
      :revision => "20ce5a625781c6abbaaefdb9e7c8896aba799a7a"
  version "004_Pt24m4xi"

  head "https://gitlab.com/tezos/tezos.git", :branch => "alphanet"

  bottle do
    root_url "https://dl.bintray.com/michaeljklein/bottles-tq"
    cellar :any
    sha256 "84c55df7aa9accb9c3f2ff79a4d7045a15d4d56c5518faf4ffec3cc94fbd3294" => :mojave
  end

  depends_on "opam" => "2.0.3"

  dependencies = %w[gmp hidapi libev pkg-config rsync wget]
  dependencies.each do |dependency|
    depends_on dependency
  end

  def install
    ENV.deparallelize

    system "opam",
           "init",
           "--bare",
           "--debug",
           "--auto-setup",
           "--disable-sandboxing"

    system "make", "build-deps"
    system ["eval $(opam env)", "make", "make install"].join(" && ")

    bin.mkpath # ensure bin folder exists
    executable_file_paths = Dir["./*"].select do |file_path|
      File.file?(file_path) && File.executable?(file_path)
    end
    executable_file_paths.each do |file_path|
      file_name = File.basename file_path
      self.class.all_bins << file_name
      bin.install file_name
    end

    system prepend_path_in_profile("~/tezos")

    bash_completion.install "src/bin_client/bash-completion.sh"
  end

  test do
    system "#{bin}/tezos-client", "man"

    self.class.all_bins.each do |file_name|
      assert_predicate bin/file_name, :exist?
    end
  end
end
