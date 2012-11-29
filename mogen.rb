#!/usr/bin/env ruby -w

# NOTE -  WE RARELY USE UNVERSIONED MOM FILES SO THIS SCRIPT IS PROB NOT WORKING!
# TO GET IT WORKING YOU NEED TO USE mogend.rb AS A BASE AND MOREVE THE MOMD STUFF
# - OR ADD A COMMAND LINE SWITCH TO mogend.rb SO IT CAN PROCESS BOTH TYPE OF FILES!




# The first arg passed in must be the custom ManagedObject base class
# If no custom MO class is required, remove the "--base-class $baseClass" 
# parameter from mogenerator call
# baseClass=NTManagedObject

# Arguments
# 0: name of custom managed object base class
# 1: any value will trigger ARC output
baseClassOption = ""
arcOption = ""
ARGV.each_with_index do |arg, i|
  baseClassOption = "--base-class #{arg}" if i == 0
  arcOption = "--template-var arc=true" if i == 1 && arg = "arc"
end


puts "MOGEN!"

cmd = 'echo /usr/local/bin/mogenerator --model "${INPUT_FILE_PATH}" --output-dir "${INPUT_FILE_DIR}/Models" "#{baseClassOption}" "#{arcOption}"'
`echo "#{cmd}"`
puts `"#{cmd}"`

# # echo mogenerator --model \"${INPUT_FILE_PATH}\" --output-dir \"${INPUT_FILE_DIR}/Models\" --base-class $baseClass --template-var arc=true
# puts `echo mogenerator --model "${INPUT_FILE_PATH}" --output-dir "${INPUT_FILE_DIR}/Models" --base-class "#{baseClass}"`

cmd = 'echo ${DEVELOPER_BIN_DIR}/momc -XD_MOMC_TARGET_VERSION=10.6 "${INPUT_FILE_PATH}" "${TARGET_BUILD_DIR}/${EXECUTABLE_FOLDER_PATH}/${INPUT_FILE_BASE}.mom"'
`echo "#{cmd}"`
puts `#{cmd}`

# echo ${DEVELOPER_BIN_DIR}/momc -XD_MOMC_TARGET_VERSION=10.6 \"${INPUT_FILE_PATH}\" \"${TARGET_BUILD_DIR}/${EXECUTABLE_FOLDER_PATH}/${INPUT_FILE_BASE}.mom\"
#puts `echo ${DEVELOPER_BIN_DIR}/momc -XD_MOMC_TARGET_VERSION=10.6 "${INPUT_FILE_PATH}" "${TARGET_BUILD_DIR}/${EXECUTABLE_FOLDER_PATH}/${INPUT_FILE_BASE}.mom"`

# echo mogenerator --model \"${INPUT_FILE_PATH}\" --output-dir \"${INPUT_FILE_DIR}/Models\" --base-class $baseClass --template-var arc=true
# mogenerator --model "${INPUT_FILE_PATH}" --output-dir "${INPUT_FILE_DIR}/Models" --base-class $baseClass

# echo ${DEVELOPER_BIN_DIR}/momc -XD_MOMC_TARGET_VERSION=10.6 \"${INPUT_FILE_PATH}\" \"${TARGET_BUILD_DIR}/${EXECUTABLE_FOLDER_PATH}/${INPUT_FILE_BASE}.mom\"
# ${DEVELOPER_BIN_DIR}/momc -XD_MOMC_TARGET_VERSION=10.6 "${INPUT_FILE_PATH}" "${TARGET_BUILD_DIR}/${EXECUTABLE_FOLDER_PATH}/${INPUT_FILE_BASE}.mom"

# echo "that's all folks. mogen.sh is done"
