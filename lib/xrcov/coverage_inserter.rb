class CoverageInserter

  include AstBuilder
  include StatementCoverage
  include BranchCoverage
  include EvalCoverage

  attr_reader :info

  def initialize(first_id = 0)
    # measurement targets corresponding to ids (0, 1, 2, ...)
    @id = first_id - 1
    @info = CoverageInformation.new()
    @inserted = {}
  end

  def next_id()
    @id = @id + 1
  end

  def insert_coverage_in_string(src, path)
    @ast = Ripper::RubyBuilder.build(src)
    @path = path

    insert_statement_coverage('stmt_cov')
    insert_branch_coverage('pred_cov')
    insert_eval_coverage('eval_cov')
    
    @ast.to_ruby
  end

  def initialize_eval()
    File.open('coverage_id', 'rb') { |f|
      @id = Marshal.load(f) - 1
    }
    if File.exist?('coverage_inserted')
      File.open('coverage_inserted', 'rb') { |f|
        @inserted = Marshal.load(f)
      }
    else
      @inserted = {}
    end
    self
  end

  def insert_coverage_in_eval(id, src, path)
    return @inserted[[id, src]] if @inserted[[id, src]]

    ret = insert_coverage_in_string(src, path)

    File.open('coverage_id', 'wb') { |f|
      Marshal.dump(next_id(), f)
    }

    File.open('coverage_extra_info', 'ab') { |f|
      Marshal.dump(@info, f)
    }

    File.open('coverage_inserted', 'wb') { |f|
      Marshal.dump(@inserted, f)
    }

    ret
  end

  def insert_coverage_in_file(path, outdir = nil)
    src = File.open(path) { |f| f.read() }
    ret = insert_coverage_in_string(src, path)

    if outdir != nil then
      outdir += '/' if outdir[-1] != '/'
      File.open(outdir + File.basename(path), 'w') { |f|
        f.write("require 'xrcov'\n")
        f.write("require 'xrcov/coverage_fileout'\n")
        f.write(ret)
      }
      File.open(outdir + 'coverage_id', 'w') { |f|
        f.write(next_id())
      }
      File.open(outdir + 'coverage_elements', 'w') { |f|

        Marshal.dump(@info, f)
      }
      File.open(outdir + 'coverage_element_groups', 'w') { |f|
        Marshal.dump(@info, f)
      }
      File.delete(outdir + 'coverage_inserted') if File.exist?(outdir + 'coverage_inserted')
      File.delete(outdir + 'coverage_extra_info') if File.exist?(outdir + 'coverage_extra_info')
    end
  end
end

if ARGV.count > 1 then
  ins = CoverageInserter.new()
  outdir = ARGV.shift
  ARGV.each { |arg| ins.insert_coverage_in_file(arg, outdir) }
end
