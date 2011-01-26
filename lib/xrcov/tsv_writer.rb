require 'singleton'

class TsvWriter
  include Singleton

  attr_writer :file

  def write(o)
    @file.write(o)
    @file.write("\t")
  end

  def write_last(o)
    @file.write(o)
    @file.write("\n")
  end
end
