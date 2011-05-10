$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'ripper2ruby'

require 'xrcov/tsv_stream'

require 'xrcov/consts.rb'
require 'xrcov/element_type'
require 'xrcov/coverage_state'
include Consts

require 'xrcov/ast_builder'

require 'xrcov/coverage_information'
require 'xrcov/coverage_element'

require 'xrcov/statement_coverage'
require 'xrcov/branch_coverage'
require 'xrcov/eval_coverage'

require 'xrcov/coverage_analyzer'

require 'xrcov/coverage_inserter'
require 'xrcov/coverage_reporter'

if ARGV.count > 1 then
  cmd = ARGV.shift
  if cmd == '-i'
    ARGV.each { |arg| CoverageInserter.insert_coverage(arg) }
  else cmd == '-p'
    reporter = CoverageReporter.new
    ARGV.each { |arg| reporter.print_result(arg) }
  end
end
