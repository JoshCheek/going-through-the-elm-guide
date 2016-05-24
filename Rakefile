require 'pathname'

def self.task_name(filename)
  Pathname.new(filename).basename.sub_ext('').to_s
end

task default: :most_recent

examples = {
  'examples/Buttons.elm'    => 'build/buttons.html',
  'examples/TextFields.elm' => 'build/text_fields.html',
  'mine/RecreateTextFields1.elm' => 'build/recreate_text_fields1.html',
  'mine/RecreateTextFields2.elm' => 'build/recreate_text_fields2.html',
}

examples.each do |infile, outfile|
  file outfile => infile do
    mkdir_p File.dirname(outfile)
    sh 'elm', 'make', infile, "--output=#{outfile}"
  end

  desc "Compile / open #{infile}"
  task task_name(outfile) => outfile do
    sh 'open', '-a', 'Google Chrome', outfile
  end
end


desc 'Compile / open the most recent example'
task :most_recent do
  infile  = Dir['{examples,mine}/*.elm'].max_by(&File.method(:mtime))
  outfile = examples[infile]
  Rake.application[task_name outfile].invoke
end
