class TsvWriter
  attr_reader :file

  def initialize(file)
    @file = file
  end

  def write(o)
    @file.write(o)
    @file.write("\t")
  end

  def write_last(o)
    @file.write(o)
    @file.write("\n")
  end
end
