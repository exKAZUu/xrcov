# add directories which locate in the same directory
#$LOAD_PATH.unshift(File.dirname(__FILE__))
# add lib directory
#$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'xrcov'
require 'coverage_state_helper'
require 'element_type_helper'
require 'fileutils'

FIXTURE_PATH = File.expand_path(File.join(File.dirname(__FILE__), '..', 'fixture'))
