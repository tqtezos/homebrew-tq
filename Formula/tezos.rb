class Tezos < Formula
  @all_bins = []

  class << self
    attr_accessor :all_bins
  end

  desc "Platform for distributed consensus with meta-consensus capability"
  homepage "https://gitlab.com/tezos/tezos"

  url "https://gitlab.com/tezos/tezos.git",
      :revision => "a7d357bb290eab43c92ec2245811e9af959d1d4c",
      :branch   => "mainnet",
      :shallow  => false
  version "005_PsBabyM1"

  head "https://gitlab.com/tezos/tezos.git", :branch => "babylonnet"

  # bottle do
  #   root_url "https://dl.bintray.com/michaeljklein/bottles-tq"
  #   cellar :any
  #   rebuild 2 if OS.mac?
  #   rebuild 3 if OS.linux?
  #   sha256 "9f5eda43d650d7de741259c106c901c3a9b9364230f8606c0d584fa0b9ebd1db" => :mojave
  #   sha256 "52bc29b5ad8b270227f276bda540d483af8f846cc7a88d7fcca34b215a85dfd0" => :x86_64_linux
  # end
    # cellar :any
    # sha256 "2977a2d6578a57ef4e65aa577a1bb6aa5af54f2a02026e869e09289af9d78df5" => :mojave
  # end

  depends_on "opam" => :build

  build_dependencies = %w[pkg-config rsync wget]
  build_dependencies.each do |dependency|
    depends_on dependency => :build
  end

  dependencies = %w[gmp hidapi libev]
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
