module main

import io.util
import os

fn create_tmp_home() !string {
	mh_root := util.temp_dir() or { return error("unable to create tmp home parent directory: ${err}") }
	home_dir_path := os.join_path(mh_root, "home")
	os.mkdir(home_dir_path) or { return error("unable to create tmp home dir ${home_dir_path}: ${err}") }
	return home_dir_path
}

fn resolve_sandbox() string {
	return "sandboxhome"
}

fn resolve_dot_prefix(s string) string {
	return s.replace("dot_", ".")
}

fn main() {
	tmp_home := create_tmp_home()!
	defer { os.rmdir(tmp_home) or { panic(err) } }

	os.walk(resolve_sandbox(), fn (p string) {
		println(resolve_dot_prefix(p))
	})
}
