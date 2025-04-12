extends Sprite2D

#var inputTimes: Array = [];
var lastBeat: int = Time.get_ticks_msec();
@export var WindowMsec: int = 110;

@export var bm: BeatMiser

func _ready() -> void:
	bm.DownBeat.connect(
		func():
			lastBeat = Time.get_ticks_msec();
	)

func _process(_delta: float) -> void:
	if (Input.is_action_just_pressed("ui_accept")):
		#handling slightly late presses is trivial
		if (Time.get_ticks_msec() - lastBeat < WindowMsec):
			DamageNumbers.display_text("Hit! (late)", global_position, "#3F3");
		#otherwise, wait and see if a beat is coming
		else:
			var waiter = BeatWaiter.new();
			waiter.BeatSignal = bm.DownBeat;
			waiter.MaxWaitTime = (WindowMsec / 1000.0);
			call_deferred("add_child", waiter);
			var success = await waiter.Interrupt;
			if (success): DamageNumbers.display_text("Hit! (early)", global_position, "#3F3");
			else: 
				DamageNumbers.display_text("Miss!", global_position, "#F33");
				bm.upTempo();
