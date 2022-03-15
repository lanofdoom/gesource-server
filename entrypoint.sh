#!/bin/bash -ue

[ -z "${GE_MOTD}" ] || echo "${GE_MOTD}" > /opt/game/gesource/motd.txt

#  Hack to make auth plugin load properly
cp /opt/game/gesource/addons/sourcemod/extensions/auth_by_steam_group.ext.1.ep1.dll /opt/game/gesource/addons/sourcemod/extensions/auth_by_steam_group.ext.dll

# Generate mapcycle
ls /opt/game/gesource/maps/*.bsp | grep -v tutorial | sed -e 's/.*\/\([^\/]*\).bsp/\1/' > /opt/game/gesource/cfg/mapcycle.txt

# Update maplists
sed -i 's|addons/sourcemod/configs/adminmenu_maplist.ini|default|g' /opt/game/gesource/addons/sourcemod/configs/maplists.cfg

# Touch these files to prevent sourcemod from creating them and overriding
# values sent in server.cfg
touch /opt/game/gesource/cfg/sourcemod/mapchooser.cfg
touch /opt/game/gesource/cfg/sourcemod/rtv.cfg

# Update server config file
cp /opt/game/gesource/cfg/templates/server.cfg /opt/game/gesource/cfg/server.cfg
echo "// Added by entrypoint.sh" >> /opt/game/gesource/cfg/server.cfg
echo "hostname \"$GE_HOSTNAME\"" >> /opt/game/gesource/cfg/server.cfg

# Set terminal
export TERM=xterm

# Start display server
Xvfb :98 -screen 0 800x600x16 &
sleep 1s

# Create temporary wine root
export WINEPREFIX=$(mktemp -d)

# CD into game directory
cd /opt/game

# Configure wine and start game
export DISPLAY=:98.0
wine start /wait srcds.exe \
    -game gesource \
    -port "$GE_PORT" \
    -strictbindport \
    -console \
    -tickrate 100 \
    +ip 0.0.0.0 \
    +map "$GE_MAP" \
    +rcon_password "$RCON_PASSWORD" \
    +sv_password "$GE_PASSWORD" \
    +sm_auth_by_steam_group_group_id "$STEAM_GROUP_ID" \
    +sm_auth_by_steam_group_steam_key "$STEAM_API_KEY"
