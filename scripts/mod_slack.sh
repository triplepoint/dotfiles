#!/usr/bin/env bash

# Where the slack resources directory is.  In this case, on macos.
SLACK_RESOURCEDIR=/Applications/Slack.app/Contents/Resources

# Ensure npm is installed
command -v npm >/dev/null 2>&1 || { echo "Install Node Package Manager (npm) first."; exit 1; }

# Define the appended content
APPENDSTRING=$(cat <<-'EOM'
// MOD TO END OF FILE







// First make sure the wrapper app is loaded
document.addEventListener("DOMContentLoaded", function() {

  // Then get its webviews
  let webviews = document.querySelectorAll(".TeamView webview");

  // Fetch our CSS in parallel ahead of time
  const cssPath = 'https://raw.githubusercontent.com/widget-/slack-black-theme/master/custom.css';
  let cssPromise = fetch(cssPath).then(response => response.text());

  let customCustomCSS = `
  :root {
    /* Modify these to change your theme colors: */
    /*
    --primary: #09F;
    --text: #CCC;
    --background: #080808;
    --background-elevated: #222;
    */
    --primary: #61AFEF;
    --text: #ABB2BF;
    --background: #282C34;
    --background-elevated: #3B4048;
  }

  div.c-message.c-message--light.c-message--hover {
    color: #fff !important;
    background-color: #222 !important;
  }

  span.c-message__body,
  a.c-message__sender_link,
  span.c-message_attachment__text,
  .c-message_attachment__field_value,
  span.c-message_attachment__media_trigger.c-message_attachment__media_trigger--caption,
  div.p-message_pane__foreword__description span {
  	color: #afafaf !important;
  }

  .c-message_attachment__field_title {
  	font-weight: bold;
  	color: #afafaf !important;
  }

  pre.special_formatting {
    background-color: #222 !important;
    color: #8f8f8f !important;
    border: solid;
    border-width: 1 px !important;
  }

  .c-message, .c-virtual_list__item {
    background-color: #222 !important;
  }
  `

  // Insert a style tag into the wrapper view
  cssPromise.then(css => {
    let s = document.createElement('style');
    s.type = 'text/css';
    s.innerHTML = css + customCustomCSS;
    document.head.appendChild(s);
  });

  // Wait for each webview to load
  webviews.forEach(webview => {
    webview.addEventListener('ipc-message', message => {
      if (message.channel == 'didFinishLoading')
        // Finally add the CSS into the webview
        cssPromise.then(css => {
          let script = `
            let s = document.createElement('style');
            s.type = 'text/css';
            s.id = 'slack-custom-css';
            s.innerHTML = \`${css + customCustomCSS}\`;
            document.head.appendChild(s);
          `
          webview.executeJavaScript(script);
        })
    });
  });
});
EOM
)

# Extract the asar archive file
npx asar extract ${SLACK_RESOURCEDIR}/app.asar ${SLACK_RESOURCEDIR}/extracted-asar
sleep 4

# Remove the previously existing mod content
sed -i -n '/\/\/ MOD TO END OF FILE/q;p' ${SLACK_RESOURCEDIR}/extracted-asar/dist/ssb-interop.bundle.js

# Append the mod string to the javascript file
echo "${APPENDSTRING}" >> ${SLACK_RESOURCEDIR}/extracted-asar/dist/ssb-interop.bundle.js

# Repack the archive
npx asar pack ${SLACK_RESOURCEDIR}/extracted-asar ${SLACK_RESOURCEDIR}/app.asar
rm -r ${SLACK_RESOURCEDIR}/extracted-asar
