//+build linux, darwin, freebsd, openbsd
//+private
package dynlib

import "core:os"

_load_library :: proc(path: string, global_symbols := false) -> (Library, bool) {
	flags := os.RTLD_NOW
	if global_symbols {
		flags |= os.RTLD_GLOBAL
	}
	lib := os.dlopen(path, flags)
	return Library(lib), lib != nil
}

_unload_library :: proc(library: Library) {
	os.dlclose(rawptr(library))
}

_symbol_address :: proc(library: Library, symbol: string) -> (ptr: rawptr, found: bool) {
	ptr = os.dlsym(rawptr(library), symbol)
	found = ptr != nil
	return
}
