date_formatted=$(date "+%Y-%m-%d %I:%M:%S %p")

battery_status=$(cat /sys/class/power_supply/BAT0/capacity)

keyboard=$(swaymsg -t get_inputs | jq '.[0].xkb_active_layout_name')

en="\"English (US)\""

sv="\"Swedish\""

jp="\"Japanese\""

language=""

if [ "$keyboard" = "$en" ]; then
    language="en"
elif [ "$keyboard" = "$sv" ]; then
    language="sv"
elif [ "$keyboard" = "$jp" ]; then
    language="jp"
fi
    

echo Keyboard: "$language" '|' Volume: $(pactl list sinks | grep '^[[:space:]]Volume:' | \
    head -n $(( $SINK + 1 )) | tail -n 1 | sed -e 's,.* \([0-9][0-9]*\)%.*,\1,')% '|' Battery: $battery_status% '|' $date_formatted 
