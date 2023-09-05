class Player {
    var object: h2d.Object;

    public function new(game: Game, x: Float, y: Float) {

        var PW = 16;
        var PH = 16;
        var runningAnim = new h2d.Anim(
                [for (i in 0...2) game.tileSheet.sub(0, i*PW, PW, PH)],
                5);
        object = runningAnim;
        object.x = x;
        object.y = y;
        game.world.add(object, Game.LAYER_SPRITES);
    }

    public function update(dt: Float, input: Input) {
        if (input.up) {
            object.y -= 1;
        }
        if (input.down) {
            object.y += 1;
        }
        if (input.left) {
            object.x -= 1;
        }
        if (input.right) {
            object.x += 1;
        }
    }
}
