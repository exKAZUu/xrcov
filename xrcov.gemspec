# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{xrcov}
  s.version = "0.0.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Kazunori SAKAMOTO"]
  s.date = %q{2011-05-11}
  s.description = %q{description}
  s.email = %q{exkazuu@gmail.com}
  s.extra_rdoc_files = [
    "LICENSE.txt",
    "README.rdoc"
  ]
  s.files = [
    ".document",
    ".rspec",
    "Gemfile",
    "Gemfile.lock",
    "LICENSE.txt",
    "README.rdoc",
    "Rakefile",
    "VERSION",
    "fixture/expected/branch/lib/.xrcov_elems",
    "fixture/expected/branch/lib/.xrcov_id",
    "fixture/expected/branch/lib/.xrcov_inserted",
    "fixture/expected/branch/lib/branch.rb",
    "fixture/expected/branch/lib/branch.rb.xrcov_bak",
    "fixture/expected/branch/spec/branch_spec.rb",
    "fixture/expected/fibonacci/lib/.xrcov_elems",
    "fixture/expected/fibonacci/lib/.xrcov_id",
    "fixture/expected/fibonacci/lib/.xrcov_inserted",
    "fixture/expected/fibonacci/lib/fibonacci.rb",
    "fixture/expected/fibonacci/lib/fibonacci.rb.xrcov_bak",
    "fixture/expected/fibonacci/spec/fibonacci_spec.rb",
    "fixture/expected/sample/lib/.xrcov_elems",
    "fixture/expected/sample/lib/.xrcov_id",
    "fixture/expected/sample/lib/.xrcov_inserted",
    "fixture/expected/sample/lib/sample.rb",
    "fixture/expected/sample/lib/sample.rb.xrcov_bak",
    "fixture/expected/sample/spec/sample_spec.rb",
    "fixture/expected/stmt/lib/.xrcov_elems",
    "fixture/expected/stmt/lib/.xrcov_id",
    "fixture/expected/stmt/lib/.xrcov_inserted",
    "fixture/expected/stmt/lib/stmt.rb",
    "fixture/expected/stmt/lib/stmt.rb.xrcov_bak",
    "fixture/expected/stmt/spec/stmt_spec.rb",
    "fixture/input/branch/lib/branch.rb",
    "fixture/input/branch/spec/branch_spec.rb",
    "fixture/input/fibonacci/lib/fibonacci.rb",
    "fixture/input/fibonacci/spec/fibonacci_spec.rb",
    "fixture/input/sample/lib/sample.rb",
    "fixture/input/sample/spec/sample_spec.rb",
    "fixture/input/stmt/lib/stmt.rb",
    "fixture/input/stmt/spec/stmt_spec.rb",
    "lib/core_ext/array/flush.rb",
    "lib/core_ext/hash/delete_at.rb",
    "lib/core_ext/object/meta_class.rb",
    "lib/core_ext/object/try.rb",
    "lib/erb/stripper.rb",
    "lib/highlighters/ansi.rb",
    "lib/ripper/event_log.rb",
    "lib/ripper/ruby_builder.rb",
    "lib/ripper/ruby_builder/buffer.rb",
    "lib/ripper/ruby_builder/events/args.rb",
    "lib/ripper/ruby_builder/events/array.rb",
    "lib/ripper/ruby_builder/events/assignment.rb",
    "lib/ripper/ruby_builder/events/block.rb",
    "lib/ripper/ruby_builder/events/call.rb",
    "lib/ripper/ruby_builder/events/case.rb",
    "lib/ripper/ruby_builder/events/const.rb",
    "lib/ripper/ruby_builder/events/for.rb",
    "lib/ripper/ruby_builder/events/hash.rb",
    "lib/ripper/ruby_builder/events/identifier.rb",
    "lib/ripper/ruby_builder/events/if.rb",
    "lib/ripper/ruby_builder/events/lexer.rb",
    "lib/ripper/ruby_builder/events/literal.rb",
    "lib/ripper/ruby_builder/events/method.rb",
    "lib/ripper/ruby_builder/events/operator.rb",
    "lib/ripper/ruby_builder/events/statements.rb",
    "lib/ripper/ruby_builder/events/string.rb",
    "lib/ripper/ruby_builder/events/symbol.rb",
    "lib/ripper/ruby_builder/events/while.rb",
    "lib/ripper/ruby_builder/queue.rb",
    "lib/ripper/ruby_builder/stack.rb",
    "lib/ripper/ruby_builder/token.rb",
    "lib/ripper2ruby.rb",
    "lib/ruby.rb",
    "lib/ruby/aggregate.rb",
    "lib/ruby/alternation/args.rb",
    "lib/ruby/alternation/hash.rb",
    "lib/ruby/alternation/list.rb",
    "lib/ruby/args.rb",
    "lib/ruby/array.rb",
    "lib/ruby/assignment.rb",
    "lib/ruby/assoc.rb",
    "lib/ruby/block.rb",
    "lib/ruby/call.rb",
    "lib/ruby/case.rb",
    "lib/ruby/const.rb",
    "lib/ruby/for.rb",
    "lib/ruby/hash.rb",
    "lib/ruby/if.rb",
    "lib/ruby/list.rb",
    "lib/ruby/literal.rb",
    "lib/ruby/method.rb",
    "lib/ruby/node.rb",
    "lib/ruby/node/composite.rb",
    "lib/ruby/node/conversions.rb",
    "lib/ruby/node/position.rb",
    "lib/ruby/node/source.rb",
    "lib/ruby/node/text.rb",
    "lib/ruby/node/traversal.rb",
    "lib/ruby/operator.rb",
    "lib/ruby/params.rb",
    "lib/ruby/statements.rb",
    "lib/ruby/string.rb",
    "lib/ruby/symbol.rb",
    "lib/ruby/token.rb",
    "lib/ruby/while.rb",
    "lib/ruby_api.rb",
    "lib/xrcov.rb",
    "lib/xrcov/ast_builder.rb",
    "lib/xrcov/branch_coverage.rb",
    "lib/xrcov/consts.rb",
    "lib/xrcov/coverage_analyzer.rb",
    "lib/xrcov/coverage_element.rb",
    "lib/xrcov/coverage_fileout.rb",
    "lib/xrcov/coverage_information.rb",
    "lib/xrcov/coverage_inserter.rb",
    "lib/xrcov/coverage_reporter.rb",
    "lib/xrcov/coverage_state.rb",
    "lib/xrcov/element_type.rb",
    "lib/xrcov/eval_coverage.rb",
    "lib/xrcov/statement_coverage.rb",
    "lib/xrcov/tsv_stream.rb",
    "spec/branch_coverage_spec.rb",
    "spec/coverage_analyzer_spec.rb",
    "spec/coverage_element_spec.rb",
    "spec/coverage_fileout_spec.rb",
    "spec/coverage_information_spec.rb",
    "spec/coverage_inserter_spec.rb",
    "spec/coverage_reporter_spec.rb",
    "spec/coverage_state_helper.rb",
    "spec/element_type_helper.rb",
    "spec/eval_coverage_spec.rb",
    "spec/spec.opts",
    "spec/spec_helper.rb",
    "spec/statement_coverage_spec.rb",
    "spec/tsv_stream_spec.rb",
    "xrcov.gemspec"
  ]
  s.homepage = %q{http://github.com/exKAZUu/xrcov}
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{summary}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rspec>, ["~> 2.3.0"])
      s.add_development_dependency(%q<bundler>, ["~> 1.0.0"])
      s.add_development_dependency(%q<jeweler>, ["~> 1.6.0"])
      s.add_development_dependency(%q<rcov>, [">= 0"])
    else
      s.add_dependency(%q<rspec>, ["~> 2.3.0"])
      s.add_dependency(%q<bundler>, ["~> 1.0.0"])
      s.add_dependency(%q<jeweler>, ["~> 1.6.0"])
      s.add_dependency(%q<rcov>, [">= 0"])
    end
  else
    s.add_dependency(%q<rspec>, ["~> 2.3.0"])
    s.add_dependency(%q<bundler>, ["~> 1.0.0"])
    s.add_dependency(%q<jeweler>, ["~> 1.6.0"])
    s.add_dependency(%q<rcov>, [">= 0"])
  end
end

