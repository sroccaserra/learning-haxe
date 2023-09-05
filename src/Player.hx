class Player {
    var anim: h2d.Anim;
    var stillFrames: Array<h2d.Tile>;
    var runningFrames: Array<h2d.Tile>;

    public function new(game: Game, x: Float, y: Float) {
        var PW = 16;
        var PH = 16;
        stillFrames = [game.tileSheet.sub(0, 0, PW, PH)];
        runningFrames =
            [for (i in 0...2) game.tileSheet.sub(0, i*PW, PW, PH)] ;
        anim = new h2d.Anim(stillFrames, 5);
        anim.x = x;
        anim.y = y;
        game.world.add(anim, Game.LAYER_SPRITES);
    }

    public function update(dt: Float, input: Input) {
        var isMoving = false;
        if (input.up) {
            anim.y -= 1;
            isMoving = true;
        }
        if (input.down) {
            anim.y += 1;
            isMoving = true;
        }
        if (input.left) {
            anim.x -= 1;
            isMoving = true;
        }
        if (input.right) {
            anim.x += 1;
            isMoving = true;
        }

        if (isMoving) {
            anim.play(runningFrames, anim.currentFrame);
        }
        else {
            anim.play(stillFrames, anim.currentFrame);
        }
    }
}
