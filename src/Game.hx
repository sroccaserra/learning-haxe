import h2d.Scene;
import hxd.Key;

class Game extends hxd.App {
    static var W = 256;
    static var H = 224;

    public static var LAYER_BG = 0;
    public static var LAYER_SPRITES = 1;
    public static var LAYER_HUD = 2;

    public var world: h2d.Layers;
    public var tileSheet: h2d.Tile;

    var player: Player;

    override function init() {
        super.init();
        engine.backgroundColor = 0xFF393939;

        s2d.scaleMode = LetterBox(W, H, true, Center, Center);
        var mask = new h2d.Graphics(s2d);
        mask.beginFill(0xFF0000, 0.5);
        mask.drawRect(0, 0, W, H);
        mask.endFill();
        s2d.filter = new h2d.filter.Mask(mask);

        world = new h2d.Layers(s2d);

        var mapData: TiledMapData = haxe.Json.parse(hxd.Res.map.entry.getText());
        var tw = mapData.tileWidth;
        var th = mapData.tileHeight;
        var mw = mapData.width;
        var mh = mapData.height;

        tileSheet = hxd.Res.img.sheet.toTile();
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

        player = new Player(this, 60, 60);

        var tf = new h2d.Text(hxd.res.DefaultFont.get());
        world.add(tf, LAYER_HUD);
        tf.text = 'Hello World !';
        tf.x = 16;
        tf.y = 16;
    }

    override function update(dt: Float) {
        super.update(dt);
        var input = readInput();

        player.update(dt, input);

        if (Key.isPressed(Key.F)) {
            engine.fullScreen = !engine.fullScreen;
        }
    }

    function readInput(): Input {
        var input = {up: false, down: false, left: false, right: false};
        if (Key.isDown(Key.UP)) {
            input.up = true;
        }
        if (Key.isDown(Key.DOWN)) {
            input.down = true;
        }
        if (Key.isDown(Key.LEFT)) {
            input.left = true;
        }
        if (Key.isDown(Key.RIGHT)) {
            input.right = true;
        }
        return input;
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
