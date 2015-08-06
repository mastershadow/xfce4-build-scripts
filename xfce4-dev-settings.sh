#!/bin/bash
#
# Made by Eduard Roccatello <eduard@xfce.org>
#

xfce_src_dir="src"
xfce_prefix="/opt/xfce4"
xfce_debug=0
xfce_cflags="-O2 -pipe"
xfce_cflags_debug=""
xfce_build_log="build.log"
xfce_clean_before_building=1

# EDIT IF YOU KNOW WHAT YOU ARE DOING :)
xfce_git_url="git://git.xfce.org"
xfce_git_command="git"
xfce_git_clone="clone"
xfce_git_pull="pull"

xfce_core_prefix="xfce"
xfce_core_packages=(xfce4-dev-tools libxfce4util xfconf libxfce4ui garcon exo xfce4-panel xfce4-power-manager tumbler thunar xfce4-settings xfce4-session xfdesktop xfwm4 xfce4-appfinder thunar-desktop-plugin thunar-volman)

xfce_apps_prefix="apps"
xfce_apps_packages=(mousepad xfce4-mixer xfce4-notifyd xfce4-terminal)
