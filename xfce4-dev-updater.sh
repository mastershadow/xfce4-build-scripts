#!/bin/bash
#
# Made by Eduard Roccatello <eduard@xfce.org>
#
source xfce4-dev-settings.sh

echo "Updating source tree..."
echo "Updating core..."
for package in ${xfce_core_packages[@]}; do
	package_name=${xfce_core_prefix}/$package
	package_url=${xfce_git_url}/$package_name
	package_dir=$xfce_src_dir/$package_name

	git_command=""
	if [ ! -d "$package_dir" ]; then
		echo "Cloning $package_name..."
		git_command="$xfce_git_command $xfce_git_clone $package_url $package_dir"
	else
		echo "Updating $package_name..."
		git_command="$xfce_git_command -C $package_dir $xfce_git_pull origin master"
	fi

	$git_command
	if [ $? -ne 0 ]; then
    	echo "Operation failed."
    	exit 1;
	fi
done
echo "OK"

echo "Updating apps..."
for package in ${xfce_apps_packages[@]}; do
	package_name=${xfce_apps_prefix}/$package
	package_url=${xfce_git_url}/$package_name
	package_dir=$xfce_src_dir/$package_name

	git_command=""
	if [ ! -d "$package_dir" ]; then
		echo "Cloning $package_name..."
		git_command="$xfce_git_command $xfce_git_clone $package_url $package_dir"
	else
		echo "Updating $package_name..."
		git_command="$xfce_git_command -C $package_dir $xfce_git_pull origin master"
	fi

	$git_command
	if [ $? -ne 0 ]; then
    	echo "Operation failed."
    	exit 1;
	fi
done
echo "OK"

exit 0