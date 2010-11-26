
# CAUTION: This will over-write the brew installed node-0.2.x
#          So two formula (node and node3) will both install the 'node'
#          executable

require 'formula'

class Node3 <Formula
  url 'http://nodejs.org/dist/node-v0.3.1.tar.gz'
  head 'git://github.com/ry/node.git'
  homepage 'http://nodejs.org/'
  md5 '6b33fcb3fdeeb4e758082ca787c86864'

  # Stripping breaks dynamic loading
  skip_clean :all

  def options
    [["--debug", "Build with debugger hooks."]]
  end

  def install
    fails_with_llvm

    inreplace 'wscript' do |s|
      s.gsub! '/usr/local', HOMEBREW_PREFIX
      s.gsub! '/opt/local/lib', '/usr/lib'
    end

    args = ["--prefix=#{prefix}"]
    args << "--debug" if ARGV.include? '--debug'

    system "./configure", *args
    system "make install"
  end
end
