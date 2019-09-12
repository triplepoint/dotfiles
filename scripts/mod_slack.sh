#!/usr/bin/env bash
set -e

# Define some paths, like where the Slack resources live, where the archive
# will be extracted to, and where the target file to modify is in that archive.
SLACK_RESOURCEDIR="/Applications/Slack.app/Contents/Resources"
SLACK_EXTRACT_PATH="${SLACK_RESOURCEDIR}/extracted-asar"
SLACK_FILE_PATH="${SLACK_EXTRACT_PATH}/dist/ssb-interop.bundle.js"

# Ensure npm is installed
command -v npm >/dev/null 2>&1 || { echo "Install Node Package Manager (npm) first."; exit 1; }

# Make a note about the required font
echo "For best results, make sure you have the 'Muli' font installed.  It's available in the brew cask font tap."

# Define the javascript shim content
APPENDSTRING=$(cat <<-'EOM'
// MOD TO END OF FILE

document.addEventListener('DOMContentLoaded', function() {
  // Fetch our CSS in parallel ahead of time
  const cssPath = 'https://raw.githubusercontent.com/triplepoint/slack-black-theme/master/slack-dark-mode.css';
  let cssPromise = fetch(cssPath).then((response) => response.text());
  // Insert a style tag into the wrapper view
  cssPromise.then((css) => {
    let s = document.createElement('style');
    s.type = 'text/css';
    s.innerHTML = css;
    document.head.appendChild(s);
  });
});
EOM
)

# Extract the asar archive file
npx asar extract ${SLACK_RESOURCEDIR}/app.asar ${SLACK_EXTRACT_PATH}
sleep 4

# Remove the previously existing mod content
sed -i -n '/\/\/ MOD TO END OF FILE/q;p' ${SLACK_FILE_PATH}

# Append the mod string to the javascript file
# echo "${APPENDSTRING}" >> ${SLACK_FILE_PATH}

# Repack the archive and delete the working copy
npx asar pack ${SLACK_EXTRACT_PATH} ${SLACK_RESOURCEDIR}/app.asar
rm -r ${SLACK_EXTRACT_PATH}
