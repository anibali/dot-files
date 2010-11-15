# .irbrc
# ------
# Requirements:
# * hirb
# * awesome_print

require 'rubygems'

# Enable tab completion
require 'irb/completion'

# Enable saving of history
require 'irb/ext/save-history'
IRB.conf[:SAVE_HISTORY] = 100
IRB.conf[:HISTORY_FILE] = "#{ENV['HOME']}/.irb-save-history"

# Enable nice formatting of database records
begin
  require 'hirb'
  Hirb.enable(:pager => false)
rescue LoadError
end

# Enable pretty colours
begin
  require 'ap'
  IRB::Irb.class_eval do
    def output_value
      ap @context.last_value
    end
  end
rescue LoadError
end

# Enable 'ri_' methods (rebuild index with `fastri-server -b`)
module Kernel
  def r(arg)
    puts `fri "#{arg}"`
  end
  private :r
end

class Object
  def puts_ri_documentation_for(obj, meth)
    case self
    when Module
      candidates = ancestors.map{|klass| "#{klass}::#{meth}"}
      candidates.concat(class << self; ancestors end.map{|k| "#{k}##{meth}"})
    else
      candidates = self.class.ancestors.map{|klass|  "#{klass}##{meth}"}
    end
    candidates.each do |candidate|
      #puts "TRYING #{candidate}"
      desc = `fri -L '#{candidate}'`
      unless desc.chomp == "nil"
        puts desc
        return true
      end
    end
    false
  end
  private :puts_ri_documentation_for

  def method_missing(meth, *args, &block)
    if md = /ri_(.*)/.match(meth.to_s)
      unless puts_ri_documentation_for(self,md[1])
        "Ri doesn't know about ##{meth}"
      end
    else
      super
    end
  end

  def ri_(meth)
    unless puts_ri_documentation_for(self,meth.to_s)
      "Ri doesn't know about ##{meth}"
    end
  end
end

RICompletionProc = proc{|input|
  bind = IRB.conf[:MAIN_CONTEXT].workspace.binding
  case input
  when /(\s*(.*)\.ri_)(.*)/
    pre = $1
    receiver = $2
    meth = $3 ? /\A#{Regexp.quote($3)}/ : /./ #}
    begin
      candidates = eval("#{receiver}.methods", bind).map do |m|
        case m
        when /[A-Za-z_]/; m
        else # needs escaping
          %{"#{m}"}
        end
      end
      candidates = candidates.grep(meth)
      candidates.map{|s| pre + s }
    rescue Exception
      candidates = []
    end
  when /([A-Z]\w+)#(\w*)/ #}
    klass = $1
    meth = $2 ? /\A#{Regexp.quote($2)}/ : /./
    candidates = eval("#{klass}.instance_methods(false)", bind)
    candidates = candidates.grep(meth)
    candidates.map{|s| "'" + klass + '#' + s + "'"}
  else
    IRB::InputCompletor::CompletionProc.call(input)
  end
}
#Readline.basic_word_break_characters= " \t\n\"\\'`><=;|&{("
Readline.basic_word_break_characters= " \t\n\\><=;|&"
Readline.completion_proc = RICompletionProc


# Print methods with pm
ANSI_BOLD       = "\033[1m"
ANSI_RESET      = "\033[0m"
ANSI_LGRAY    = "\033[0;37m"
ANSI_GRAY     = "\033[1;30m"

def pm(obj, *options) # Print methods
  methods = obj.methods
  methods -= Object.methods unless options.include? :more
  filter = options.select {|opt| opt.kind_of? Regexp}.first
  methods = methods.select {|name| name =~ filter} if filter

  data = methods.sort.collect do |name|
    method = obj.method(name)
    if method.arity == 0
      args = "()"
    elsif method.arity > 0
      n = method.arity
      args = "(#{(1..n).collect {|i| "arg#{i}"}.join(", ")})"
    elsif method.arity < 0
      n = -method.arity
      args = "(#{(1..n).collect {|i| "arg#{i}"}.join(", ")}, ...)"
    end
    klass = $1 if method.inspect =~ /Method: (.*?)#/
    [name, args, klass]
  end
  max_name = data.collect {|item| item[0].size}.max
  max_args = data.collect {|item| item[1].size}.max
  data.each do |item| 
    print " #{ANSI_BOLD}#{item[0].rjust(max_name)}#{ANSI_RESET}"
    print "#{ANSI_GRAY}#{item[1].ljust(max_args)}#{ANSI_RESET}"
    print "   #{ANSI_LGRAY}#{item[2]}#{ANSI_RESET}\n"
  end
  data.size
end

