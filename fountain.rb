require 'rubygems'
require 'dtrace/provider'

Dtrace::Provider.create :crunch do |p|
  p.probe :foo, :integer
  p.probe :bar, :integer
end

c = 0

while true
  Dtrace::Probe::Crunch.foo do |p|
    p.fire(c)
  end
  sleep 0.5
  c += 1
  Dtrace::Probe::Crunch.foo do |p|
    p.fire(c)
  end
  sleep 0.5
  c +=1
end