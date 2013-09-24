# A sample Guardfile
# More info at https://github.com/guard/guard#readme

guard 'bundler' do
  watch('Gemfile')
  # Uncomment next line if Gemfile contain `gemspec' command
  # watch(/^.+\.gemspec/)
end

guard 'rspec', :version => 2, spec_paths: ['specifications'] do
  watch(%r{^specifications/.+_spec\.rb$})
  watch(%r{^library/(.+)\.rb$})     { |m| "specifications/#{m[1]}_spec.rb" }
  watch('specifications/spec_helper.rb')  { "spec" }
end

