
run: hello.hl
	hl hello.hl

hello.hl: src/Main.hx
	haxe compile.hxml
