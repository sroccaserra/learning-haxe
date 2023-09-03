
run: hello.hl
	hl hello.hl

hello.hl: src/Main.hx res/img/sheet.png res/map.json
	haxe compile.hxml
