require 'spike'
require 'rubygems'
require 'Dtrace'

dtracy = Dtrace.new
dtracy.setopt('bufsize', '8m')
code = ':::foo{ } :::bar{ }'
prog = dtracy.compile code
prog.execute

dtracy.go

stream = Orchestra::Stream.new

listener = Orchestra::Listener.new(stream, "foobar")

listener.consume do
  puts "NOM!"
end

nom = DtraceConsumer.new(dtracy)
nom.consume do |rec|
  stream.push("foobar", "play")
end