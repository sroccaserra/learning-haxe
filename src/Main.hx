import h2d.Scene;
import h2d.filter.Nothing;

class Main extends hxd.App {
    var bmp: h2d.Bitmap;

    override function init() {
        super.init();
        s2d.scaleMode = LetterBox(256, 224, true, Center, Center);
        s2d.filter = new Nothing();

        var tf = new h2d.Text(hxd.res.DefaultFont.get(), s2d);
        tf.text = "Hello World !";

        var tile = hxd.Res.img.sheet.toTile();
        bmp = new h2d.Bitmap(tile);
        bmp.x = s2d.width/2;
        bmp.y = s2d.height/2;

        s2d.addChild(bmp);
    }

    override function update(dt: Float) {
        // bmp.rotation += 0.01;
    }

    static function main() {
        hxd.Res.initEmbed();
        new Main();
    }
}
