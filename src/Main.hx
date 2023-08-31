import h2d.Scene;
import h2d.filter.Nothing;

class Main extends hxd.App {
    static var W = 256;
    static var H = 224;
    static var TW = 8; // default tile width / height;

    override function init() {
        super.init();

        s2d.scaleMode = LetterBox(W, H, true, Center, Center);
        s2d.filter = new Nothing();

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
        var heroSprite = new h2d.SpriteBatch.BasicElement(heroTile);
        heroSprite.x = 60;
        heroSprite.y = 60;

        var spriteBatch = new h2d.SpriteBatch(spriteSheet, s2d);
        spriteBatch.hasUpdate = true;
        spriteBatch.add(heroSprite);

        var tf = new h2d.Text(hxd.res.DefaultFont.get(), s2d);
        tf.text = "Hello World !";
        tf.x = 2*TW;
        tf.y = 2*TW;
    }

    override function update(dt: Float) {
    }

    static function main() {
        hxd.Res.initEmbed();
        new Main();
    }
}
