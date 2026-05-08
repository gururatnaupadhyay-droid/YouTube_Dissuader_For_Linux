#!/bin/bash

# Define paths for Brave
BRAVE_HISTORY="$HOME/.config/BraveSoftware/Brave-Browser/Default/History"
TEMP_DB="/tmp/brave_history_copy"

# 1. Create a copy so we don't interfere with the running browser
cp "$BRAVE_HISTORY" "$TEMP_DB"

# 2. Extract the last 10 visited URLs and their timestamps
sqlite3 "$TEMP_DB" <<EOF
.headers on
.mode column
SELECT 
    datetime(last_visit_time/1000000-11644473600,'unixepoch','localtime') AS time, 
    url 
FROM urls 
ORDER BY last_visit_time DESC 
LIMIT 10;
EOF

# 3. Remove the temporary copy
rm "$TEMP_DB"
