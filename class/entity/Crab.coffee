class Crab extends Walker

	bodySize: [
		38 # width
		38 # height
		28 # x
		39 # y
	]

	spritesheet: 'crab'

	loopFrames: [0, 1, 2, 3]

	onOverlap: ->
		game.puck.stop()
		game.puck.health = 0

	onCollision: ->
		@onOverlap()