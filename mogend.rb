#!/usr/bin/env ruby -w

# This is a script designed to be called from a Build Rule in XCode like so
#  ruby "${SRCROOT}/xcode_build_scripts/mogend.rb" true NTManagedObject arc
# with the Process set to Data model versioned files (for momd models)
# and 'Using' set to 'Custom script'
# In the 'output files' section you should add 
#  $(DERIVED_FILES_DIR)/$(INPUT_FILE_BASE).momd
# 
# Arguments
# 0:  a string containing 'arc' or 'noarc' indicating where the generated 
#     models should be ARC compliant or not.
# 1:  an optional name of a custom NSManagedObject base class eg NTManagedObject

puts "Running mogend.rb"

# Parse the passed in arguments
baseClassOption = ""
arcOption = ""

ARGV.each_with_index do |arg, i|
  arcOption = "--template-var arc=true" if i == 0 && arg = "arc"
  baseClassOption = "--base-class #{arg}" if i == 1
end

# Get the current datamodel version - relies on PlistBuddy being installed
# Maybe we should document how to install this if missing?
# Could use CFPropertyList gem here 
curVer=`/usr/libexec/PlistBuddy "#{ENV['INPUT_FILE_PATH']}/.xccurrentversion" -c 'print _XCCurrentVersionName'`
curVer.rstrip!.lstrip! 
puts "  Current model is #{ENV['INPUT_FILE_PATH']}/#{curVer}"


cmd = "/usr/local/bin/mogenerator --model \"#{ENV['INPUT_FILE_PATH']}/#{curVer}\" --output-dir \"#{ENV['INPUT_FILE_DIR']}/Models/\" #{baseClassOption} #{arcOption}"
#puts cmd
puts `#{cmd}`

if $? == 0
  puts "mogenerator successful"
else
  puts "mogenerator failed"
  exit 1
end

cmd = "\"#{ENV['DEVELOPER_BIN_DIR']}/momc\" -XD_MOMC_TARGET_VERSION=10.6 \"#{ENV['INPUT_FILE_PATH']}\" \"#{ENV['TARGET_BUILD_DIR']}/#{ENV['EXECUTABLE_FOLDER_PATH']}/#{ENV['INPUT_FILE_BASE']}.momd\""
#puts cmd
puts = `#{cmd}` 

if $? == 0
  puts "momc successful"
else
  puts "momc failed"
  exit 1
end

exit 0


