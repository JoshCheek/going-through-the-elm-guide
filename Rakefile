task default: :buttons

desc 'Compile / open the html buttons example'
task :buttons do
  mkdir_p 'build'
  sh 'elm', 'make', 'examples/Buttons.elm', '--output=build/buttons.html'
  sh 'open', '-a', 'Google Chrome', 'build/buttons.html'
end
