# YouTube_Dissuader_For_Linux
This is a set of downloadable shell scripts to pop up a reminder every time you open YouTube On your browser...also pops up a warning if you open YT shorts
Download the shell scripts to your home directory in a Linux machine
Enter the following command to install the requisite Linux packages "sudo apt install wmctrl zenity sqlite3 coreutils"
Enter the following command to make the shell scripts executable "chmod +x browser_history.sh yt_tracker.sh"
Go To the Startup Aplications app on that is installed in Ubuntu machines atleast and click Add on the right side. Enter a suitable Name and Comment and click Browse and selec the yt_tracker.sh file in your Home directory.

Please Note: Minimal changes would be required in browser_history.sh to make the code compitable with your browser.

For Google Chrome make the following changes in browser_history.sh:

CHROME_HISTORY="$HOME/.config/google-chrome/Default/History"
TEMP_DB="/tmp/chrome_history_copy"
cp "$CHROME_HISTORY" "$TEMP_DB"
