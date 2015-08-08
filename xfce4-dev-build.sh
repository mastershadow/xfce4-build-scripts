#!/bin/bash
#
# Made by Eduard Roccatello <eduard@xfce.org>
#
source xfce4-dev-settings.sh

export PKG_CONFIG_PATH="${xfce_prefix}/lib/pkgconfig:$PKG_CONFIG_PATH"
export PATH="${xfce_prefix}/bin:$PATH"

configure_command="./autogen.sh"
configure_opts="--enable-gtk3"
debug_flag=""
if [ $xfce_debug -ne 1 ]; then
	export CFLAGS="${xfce_cflags}"
else
	export CFLAGS="${xfce_cflags_debug}"
	debug_flag="--enable-debug=full"
fi

declare -A package_opts
package_opts["xfce/xfce4-dev-tools"]=""

echo "Building Xfce core..."
for package in ${xfce_core_packages[@]}; do
	package_name=${xfce_core_prefix}/$package
	package_dir=$xfce_src_dir/$package_name

	echo "Building $package ...";
	specific_opts=${package_opts[$package_name]};
	cd $package_dir;
	if [ $xfce_clean_before_building -eq 1 ]; then
		make clean > /dev/null 2> /dev/null;
	fi
	$configure_command --prefix=$xfce_prefix $debug_flag $configure_opts $specific_opts && make && sudo make install;
	if [ $? -ne 0 ]; then
    	echo "Operation failed."
    	exit 1;
	fi
	cd -;
done
echo "OK"

echo "Building apps..."
for package in ${xfce_apps_packages[@]}; do
	package_name=${xfce_apps_prefix}/$package
	package_dir=$xfce_src_dir/$package_name

	echo "Building $package ...";
	specific_opts=${package_opts[$package_name]};
	cd $package_dir;
	if [ $xfce_clean_before_building -eq 1 ]; then
		make clean > /dev/null 2> /dev/null;
	fi
	$configure_command --prefix=$xfce_prefix $debug_flag $configure_opts $specific_opts && make && sudo make install;
	if [ $? -ne 0 ]; then
    	echo "Operation failed."
    	exit 1;
	fi
	cd -;
done
echo "OK"