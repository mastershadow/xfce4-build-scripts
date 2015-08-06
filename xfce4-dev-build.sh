#!/bin/bash
#
# Made by Eduard Roccatello <eduard@xfce.org>
#
source xfce4-dev-settings.sh

export PKG_CONFIG_PATH="${xfce_prefix}/lib/pkgconfig:$PKG_CONFIG_PATH"
export PATH="${xfce_prefix}/bin:$PATH"

cat /dev/null > $xfce_build_log;

configure_opts=""
debug_flag=""
if [ $xfce_debug -ne 1 ]; then
	export CFLAGS="${xfce_cflags}"
else
	export CFLAGS="${xfce_cflags_debug}"
	debug_flag="--enable-debug=full"
fi

declare -A package_opts

echo "Building Xfce core..."
for package in ${xfce_core_packages[@]}; do
	package_dir=$xfce_src_dir/${xfce_core_prefix}/$package

	echo "Building $package ...";

	specific_opts = "";
	# look into package_opts
	#
	cd $package_dir;
	if [ $xfce_clean_before_building -eq 1 ]; then
		make clean > /dev/null 2> /dev/null;
	fi
	./autogen.sh --prefix=$xfce_prefix $debug_flag $configure_opts $specific_opts > $xfce_build_log && \
	make > $xfce_build_log && \
	sudo make install > $xfce_build_log;
	if [ $? -ne 0 ]; then
    	echo "Operation failed."
    	exit 1;
	fi
	cd -;
done
echo "OK"

echo "Building apps..."
for package in ${xfce_apps_packages[@]}; do
	package_dir=$xfce_src_dir/${xfce_core_prefix}/$package
	echo $package_dir;
done
echo "OK"