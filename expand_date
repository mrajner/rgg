#!/usr/local/bin/ruby
data = STDIN.read
last_date = `git log --pretty=format:"%ad" -1`
version   = `git describe --tags`
puts data
  .gsub('$Date$'   , '%% Date:    ' + last_date.to_s.chomp)
  .gsub('$Version$', '%% Version: ' + version.to_s.chomp)
