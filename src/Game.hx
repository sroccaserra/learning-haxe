import h2d.Scene;
import hxd.Key;

class Game extends hxd.App {
    static var W = 256;
    static var H = 224;
    static var TW = 8; // default tile width / height;

    static var LAYER_BG = 0;
    static var LAYER_SPRITES = 1;
    static var LAYER_HUD = 2;

    var x: Float = 60;
    var y: Float = 60;
    var heroSprite: h2d.Object;

    override function init() {
        super.init();
        engine.backgroundColor = 0xFF393939;

        s2d.scaleMode = LetterBox(W, H, true, Center, Center);
        var mask = new h2d.Graphics(s2d);
        mask.beginFill(0xFF0000, 0.5);
        mask.drawRect(0, 0, W, H);
        mask.endFill();
        s2d.filter = new h2d.filter.Mask(mask);

        var world = new h2d.Layers(s2d);

        var mapData: TiledMapData = haxe.Json.parse(hxd.Res.map.entry.getText());
        var tw = mapData.tileWidth;
        var th = mapData.tileHeight;
        var mw = mapData.width;
        var mh = mapData.height;

        var tileSheet = hxd.Res.img.sheet.toTile();
        var tiles = [
             for(y in 0 ... Std.int(tileSheet.height / th))
             for(x in 0 ... Std.int(tileSheet.width / tw))
             tileSheet.sub(x * tw, y * th, tw, th)
        ];

        var group = new h2d.TileGroup(tileSheet);
        world.add(group, LAYER_BG);
        for(layer in mapData.layers) {
            for(y in 0 ... mh) {
                for (x in 0 ... mw) {
                    var tid = layer.data[x + y * mw];
                    if (tid != 0) {
                        group.add(x * tw, y * mapData.tileWidth, tiles[tid]);
                    }
                }
            }
        }

        var PW = 16;
        var PH = 16;
        var runningAnim = new h2d.Anim(
                [for (i in 0...2) tileSheet.sub(0, i*PW, PW, PH)],
                5);
        heroSprite = runningAnim;
        heroSprite.x = x;
        heroSprite.y = y;
        world.add(heroSprite, LAYER_SPRITES);

        var tf = new h2d.Text(hxd.res.DefaultFont.get());
        world.add(tf, LAYER_HUD);
        tf.text = 'Hello World !';
        tf.x = 2*TW;
        tf.y = 2*TW;
    }

    override function update(dt: Float) {
        super.update(dt);
        if (Key.isDown(Key.UP)) {
            y -= 1;
        }
        if (Key.isDown(Key.DOWN)) {
            y += 1;
        }
        if (Key.isDown(Key.LEFT)) {
            x -= 1;
        }
        if (Key.isDown(Key.RIGHT)) {
            x += 1;
        }
        if (Key.isPressed(Key.F)) {
            engine.fullScreen = !engine.fullScreen;
        }
        heroSprite.x = x;
        heroSprite.y = y;
    }

    static function main() {
        hxd.Res.initEmbed();
        new Game();
    }
}

typedef TiledMapData = {
    layers:Array<{data: Array<Int>}>,
    tileWidth:Int,
    tileHeight:Int,
    width:Int,
    height:Int
};
