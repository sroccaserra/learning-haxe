class Player {
    static var PW = 16;
    static var PH = 16;

    var anim: h2d.Anim;
    var stillFrames: Array<h2d.Tile>;
    var runningFrames: Array<h2d.Tile>;

    public function new(game: Game, x: Float, y: Float) {
        initFrames(game.tileSheet);
        anim = new h2d.Anim(stillFrames, 5);
        anim.x = x;
        anim.y = y;
        game.world.add(anim, Game.LAYER_SPRITES);
    }

    private function initFrames(tileSheet: h2d.Tile) {
        stillFrames = [tileSheet.sub(0, 0, PW, PH)];
        runningFrames = [for (i in 0...2) tileSheet.sub(0, i*PW, PW, PH)];
    }

    public function update(dt: Float, input: Input) {
        var isRunning = false;
        if (input.up) {
            anim.y -= 1;
        }
        if (input.down) {
            anim.y += 1;
        }
        if (input.left) {
            anim.x -= 1;
            isRunning = true;
        }
        if (input.right) {
            anim.x += 1;
            isRunning = true;
        }

        if (isRunning) {
            anim.play(runningFrames, anim.currentFrame);
        }
        else {
            anim.play(stillFrames, anim.currentFrame);
        }
    }
}
