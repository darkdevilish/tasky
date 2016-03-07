class Help
  attr_reader :file_path
  APP_ROOT = File.dirname(__FILE__)

  def initialize(file_path)
    @file_path = set_file_path(file_path)
  end

  def set_file_path(path)
    File.join(APP_ROOT, path)
  end

  def file_exists?(file_path)
    File.open(file_path, 'w') unless File.exists?(file_path)
  end

  def file_readable?(file_path)
    raise "File not readable" unless File.readable?(file_path)
  end

  def output_file_lines
    File.open(@file_path, 'r') do |line|
      line.each { |l| puts l }
    end
  end

  def run
    file_exists?(@file_path)
    file_readable?(@file_path)
    output_file_lines
  end

end
