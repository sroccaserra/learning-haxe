import h2d.Scene;
import h2d.filter.Nothing;
import hxd.Key;

class Main extends hxd.App {
    static var W = 256;
    static var H = 224;
    static var TW = 8; // default tile width / height;

    var x: Float = 60;
    var heroSprite: h2d.Bitmap;

    override function init() {
        super.init();

        s2d.scaleMode = LetterBox(W, H, true, Center, Center);
        var mask = new h2d.Graphics(s2d);
        mask.beginFill(0xFF0000, 0.5);
        mask.drawRect(0, 0, W, H);
        mask.endFill();
        s2d.filter = new h2d.filter.Mask(mask);

        var spriteSheet = hxd.Res.img.sheet.toTile();
        var brickTile = spriteSheet.sub(2*TW, 0, TW, TW);

        var group = new h2d.TileGroup(spriteSheet, s2d);
        for(y in 0...Std.int(H/TW)) {
            group.add(0, y*TW, brickTile);
            group.add(W-TW, y*TW, brickTile);
        }
        for(x in 0...Std.int(W/TW)) {
            group.add(x*TW, 0, brickTile);
            group.add(x*TW, H-TW, brickTile);
        }

        var heroTile = spriteSheet.sub(0, 0, 2*TW, 2*TW);
        heroSprite = new h2d.Bitmap(heroTile);
        heroSprite.x = x;
        heroSprite.y = 60;
        s2d.add(heroSprite);

        var tf = new h2d.Text(hxd.res.DefaultFont.get(), s2d);
        tf.text = 'Hello World !';
        tf.x = 2*TW;
        tf.y = 2*TW;
    }

    override function update(dt: Float) {
        super.update(dt);
        if (Key.isDown(Key.LEFT)) {
            x -= 1;
        }
        if (Key.isDown(Key.RIGHT)) {
            x += 1;
        }
        heroSprite.x = x;
    }

    static function main() {
        hxd.Res.initEmbed();
        new Main();
    }
}
