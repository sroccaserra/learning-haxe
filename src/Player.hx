enum FacingDirection {
    Right;
    Left;
}

class Player {
    static var PW = 16;
    static var PH = 16;

    var anim: h2d.Anim;
    var stillFrames: Array<h2d.Tile>;
    var runningFrames: Array<h2d.Tile>;
    var allAnims: Array<Array<h2d.Tile>>;
    var facingDirection: FacingDirection;

    public function new(game: Game, x: Float, y: Float) {
        initFrames(game.tileSheet);
        anim = new h2d.Anim(stillFrames, 5);
        anim.x = x;
        anim.y = y;
        game.world.add(anim, Game.LAYER_SPRITES);
        facingDirection = FacingDirection.Right;
    }

    private function initFrames(tileSheet: h2d.Tile) {
        stillFrames = [tileSheet.sub(0, 0, PW, PH)];
        runningFrames = [for (i in 0...2) tileSheet.sub(0, i*PW, PW, PH)];
        allAnims = [stillFrames, runningFrames];
        for (animFrames in allAnims) {
            for (tile in animFrames) {
                tile.dx = -8;
            }
        }
    }

    public function update(dt: Float, input: Input) {
        var isRunning = false;
        var oldFacingDir = facingDirection;

        if (input.up) {
            anim.y -= 1;
        }
        if (input.down) {
            anim.y += 1;
        }
        if (input.left) {
            anim.x -= 1;
            facingDirection = FacingDirection.Left;
            isRunning = true;
        }
        if (input.right) {
            anim.x += 1;
            facingDirection = FacingDirection.Right;
            isRunning = true;
        }

        if (isRunning) {
            anim.play(runningFrames, anim.currentFrame);
        }
        else {
            anim.play(stillFrames, anim.currentFrame);
        }

        if (facingDirection != oldFacingDir) {
            for (animFrames in allAnims) {
                for (frame in animFrames) {
                    frame.flipX();
                }
            }
        }
    }
}
