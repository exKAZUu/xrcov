$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'xrcov'

if ARGV.count > 1 then
  cmd = ARGV.shift
  if cmd == '-i'
    ARGV.each { |arg| CoverageInserter.insert_coverage(arg) }
  elsif cmd == '-p'
    reporter = CoverageReporter.new
    ARGV.each { |arg| reporter.print_result(arg) }
  elsif cmd == '-sp'
    reporter = CoverageReporter.new
    ARGV.each { |arg| reporter.print_static_result(arg) }
  end
end

