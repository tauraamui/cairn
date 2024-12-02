module main

import io.util
import os

fn create_tmp_home() !string {
	mh_root := util.temp_dir() or { return error("unable to create tmp home parent directory: ${err}") }
	home_dir_path := os.join_path(mh_root, "home")
	os.mkdir(home_dir_path) or { return error("unable to create tmp home dir ${home_dir_path}: ${err}") }
	return home_dir_path
}

fn main() {
	tmp_home := create_tmp_home()!
	defer { os.rmdir(tmp_home) or { panic(err) } }
}
