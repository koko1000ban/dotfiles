#!/usr/bin/env ruby

DEBUG = ARGV.first == "--dry-run"
DOTFILES_DIR = File.expand_path("../", __FILE__)

Dir.chdir DOTFILES_DIR

d = Dir
    .glob('*',File::FNM_DOTMATCH)
    .reject{|n| n =~ %r!^((\.svn)|(\.{1,2}|(\.git)|(\.gitmodules)|(\.DS_Store)))$! }
    .reject{|n| n =~ %r!^setup\.(sh|rb)!}

d.each do |f|
  file = Dir.pwd + '/' + f
  cmd="ln -sf #{file} ~/"
  if DEBUG
    warn cmd
  else
    system(cmd)
  end
end
