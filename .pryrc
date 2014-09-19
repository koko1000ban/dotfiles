# encoding: utf-8

$LOAD_PATH.push Dir.pwd

Pry.config.editor = "s"
Pry.config.color = true

# Prompt with ruby version
Pry.prompt = [
  proc { |obj, nest_level| "#{RUBY_VERSION} (#{obj}):#{nest_level} > " },
  proc { |obj, nest_level| "#{RUBY_VERSION} (#{obj}):#{nest_level} * " }
]

# Toys methods
# Stealed from https://gist.github.com/807492
class Array
  def self.toy(n=10, &block)
    block_given? ? Array.new(n,&block) : Array.new(n) {|i| i+1}
  end
end

class Hash
  def self.toy(n=10)
    Hash[Array.toy(n).zip(Array.toy(n){|c| (96+(c+1)).chr})]
  end
end

begin
  require 'hirb'
  # https://github.com/cldwalker/hirb/issues/46#issuecomment-1870823
  # old_print = Pry.config.print
  # Pry.config.print = proc do |*args|
  #   Hirb::View.view_or_page_output(args[1]) || old_print.call(*args)
  # end
  # Pry.config.print = proc do |output, value|
  #   Hirb::View.view_or_page_output(value) || Pry::DEFAULT_PRINT.call(output, value)
  # end
  # Hirb.enable
  Hirb.enable :pager=>false
rescue LoadError
  warn "no hirb.. "
end

# old_load_pathes = $LOAD_PATH
# def append_load_path(*paths)
#   paths = paths.reject{|path| $LOAD_PATH.include?(path)}
#   $LOAD_PATH.unshift(*paths)
# end

Pry.hooks = {
  before_session: ->(*args) {
   self.extend Rails::ConsoleMethods if defined?(Rails::ConsoleMethods)
 }
}

Pry.config.hooks.add_hook(:when_started, :bundler_setup_my) do
  puts "hello"
  if File.exist? File.expand_path("./Gemfile")
    puts "load bundler conf.."
    require 'bundler/setup'
  end
end

# Load plugins (only those I whitelist)
Pry.config.should_load_plugins = false
Pry.plugins["doc"].activate!

# Launch Pry with access to the entire Rails stack.
# If you have Pry in your Gemfile, you can pass: ./script/console --irb=pry instead.
# If you don't, you can load it through the lines below :)
rails = File.join Dir.getwd, 'config', 'environment.rb'

if File.exist?(rails) && ENV['SKIP_RAILS'].nil?
  require rails

  if Rails.version[0..0] == "2"
    require 'console_app'
    require 'console_with_helpers'
  elsif Rails.version[0..0] == "3"
    require 'rails/console/app'
    require 'rails/console/helpers'
  else
    warn "[WARN] cannot load Rails console commands (Not on Rails2 or Rails3?)"
  end
end



# for Rails 3.2+
if defined?(Rails) && Rails.env
  require "rails/console/app"
  require "rails/console/helpers"
  extend Rails::ConsoleMethods

  def debug_find_asset_path(path)
    ActionView::Base.new.asset_path(path)
  end
end

# refs: https://github.com/pry/pry/wiki/FAQ#wiki-awesome_print
if defined? AwesomePrint
  begin
    require 'awesome_print'
    Pry.config.print = proc { |output, value| Pry::Helpers::BaseHelpers.stagger_output("=> #{value.ai}", output) }
    # Pry.config.print = proc { |output, value| output.puts value.ai } #ページングなし
  rescue LoadError => err
    puts "no awesome_print :("
    puts err
  end
end

if defined?(PryDebugger)
  Pry.commands.alias_command 'c', 'continue'
  Pry.commands.alias_command 's', 'step'
  Pry.commands.alias_command 'n', 'next'
  Pry.commands.alias_command 'f', 'finish'
end