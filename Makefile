run: hello.hl
	hl hello.hl

hello.hl: src/*.hx res/img/sheet.png res/map.json
	haxe compile.hxml

clean:
	rm hello.hl
