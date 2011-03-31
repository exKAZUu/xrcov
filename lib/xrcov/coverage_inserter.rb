require 'find'
require 'fileutils'

class CoverageInserter

  include AstBuilder
  include StatementCoverage
  include BranchCoverage
  include EvalCoverage

  OUT_SUFFIX = '.xrcov_out'
  BACKUP_SUFFIX = '.xrcov_bak'
  ID_NAME = '.xrcov_id'
  ELEMENTS_NAME = '.xrcov_elems'
  INSERTED_NAME = '.xrcov_inserted'

  attr_accessor :info

  def initialize(out_path, first_id = 0)
    @out_path = out_path
    # measurement targets corresponding to ids (0, 1, 2, ...)
    @id = first_id - 1
    @info = CoverageInformation.new()
    @inserted = {}
  end

  def next_id()
    @id = @id + 1
  end

  def insert_coverage_in_string(src, src_path)
    @ast = Ripper::RubyBuilder.build(src)
    @src_path = src_path

    insert_statement_coverage('XrcovOut.stmt')
    insert_branch_coverage('XrcovOut.pred')
    insert_eval_coverage('XrcovOut.eval')

    @ast.to_ruby
  end

  def initialize_eval()
    File.open(File.join(@out_path, ID_NAME), 'r') { |f|
      @id = f.read().to_i - 1
    }
    File.open(File.join(@out_path, INSERTED_NAME), 'rb') { |f|
      @inserted = Marshal.load(f)
    }
    self
  end

  def insert_coverage_in_eval(id, src, src_path)
    return @inserted[[id, src]] if @inserted[[id, src]]

    ret = insert_coverage_in_string(src, src_path)

    File.open(File.join(@out_path, ID_NAME), 'w') { |f|
      f.write(next_id())
    }
    File.open(File.join(@out_path, ELEMENTS_NAME), 'a') { |f|
      @info.append(f)
    }
    File.open(File.join(@out_path, INSERTED_NAME), 'wb') { |f|
      Marshal.dump(@inserted, f)
    }

    ret
  end

  def insert_coverage_in_file(src_path)
    src = File.open(src_path) { |f| f.read() }
    File.open(src_path + BACKUP_SUFFIX, 'w') { |f|
      f.write(src)
    }
    ret = insert_coverage_in_string(src, src_path)

    File.open(src_path, 'w') { |f|
      f.write("require 'xrcov'\n")
      f.write("$xrcov_out_path = #{@out_path}\n")
      f.write("require 'xrcov/coverage_fileout'\n")
      f.write(ret)
    }

    File.open(File.join(@out_path, ID_NAME), 'w') { |f|
      f.write(next_id())
    }
    File.open(File.join(@out_path, ELEMENTS_NAME), 'w') { |f|
      @info.write(f)
    }
    File.open(File.join(@out_path, INSERTED_NAME), 'wb') { |f|
      Marshal.dump(@inserted, f)
    }

    ret
  end

  def restore_original_sources(src_dir=@out_path)
    Find.find(src_dir) { |back|
      if back.end_with?(BACKUP_SUFFIX)
        org = back[0...-BACKUP_SUFFIX.length]
        FileUtils.rm(org)
        FileUtils.mv(back, org)
      end
    }
  end
end

if ARGV.count > 1 then
  ins = CoverageInserter.new()
  outdir = ARGV.shift
  ARGV.each { |arg| ins.insert_coverage_in_file(arg, outdir) }
end
