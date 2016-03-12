Gem::Specification.new do |s|
  s.name = 'tasky'
  s.version = '1.0.0'
  s.licenses = ['MIT']
  s.summary = "Task Manager"
  s.description = "Go To README"
  s.authors = [ "Anthony Gonzalez" ]
  s.email = 'anthonyzg3@hotmail.com'

  s.files = `ls-files`.split("\n")
  s.executables   = `ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ['lib']

  ['sqlite3', 'sequel'].each do |dep|
    s.add_dependency dep
  end
end

