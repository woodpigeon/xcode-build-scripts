# make sure you do a
#  sudo gem install growl
# and have growl and growlnotify installed

require 'rubygems'
require 'cfpropertylist'
require 'fileutils'

# ARGV.each do |arg|
#   puts arg
# end

debug = true

if !debug
  config = ENV['CONFIGURATION'].upcase
  config_build_dir = ENV['CONFIGURATION_BUILD_DIR']
  archive_action = config_build_dir.include?("ArchiveIntermediates")
  project_dir = ENV['PROJECT_DIR']
  infoplist_file = ENV['INFOPLIST_FILE']
else
  project_dir = Dir.pwd
  infoplist_file = "Gardens/Gardens-Info.plist"
  archive_action = true
end

if archive_action

  plist_filename = "#{project_dir}/#{infoplist_file}"
  pods_path = "#{project_dir}/Pods"
  pods_archive_path = "#{project_dir}/PodsArchive"

  plist = CFPropertyList::List.new(:file => plist_filename)
  data = CFPropertyList.native_types(plist.value)
  version = "#{data["CFBundleShortVersionString"]} (#{data["CFBundleVersion"]})"
  zip_file = "#{File.join(pods_archive_path, version)}.zip"

  Dir.mkdir(pods_archive_path) unless File.exists?(pods_archive_path)

  FileUtils.rm zip_file, :force=>true

  value = `zip -r "#{zip_file}" "#{pods_path}"`
  puts value

  # Now push to S3
  puts zip_file

end
