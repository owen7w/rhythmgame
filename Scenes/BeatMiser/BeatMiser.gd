extends Node
class_name BeatMiser

#var inputTimes: Array = [];
var lastBeat: int = Time.get_ticks_msec();
const WINDOW: int = 110;

@export var bm: BeatMiser

signal DownBeat;

func _ready() -> void:
	bm.DownBeat.connect(
		func():
			lastBeat = Time.get_ticks_msec();
	)
	$MidiPlayer.play();

func _on_midi_player_midi_event(channel: Variant, event: Variant) -> void:
	if (event.type == 0x90 && event.note == 0):
		DownBeat.emit();

func upTempo() ->void:
	$MidiPlayer.set_tempo($MidiPlayer.tempo + 2);

func _process(_delta: float) -> void:
	if (Input.is_action_just_pressed("ui_accept")):
		#handling slightly late presses is trivial
		if (Time.get_ticks_msec() - lastBeat < WINDOW):
			pass #late success
		#otherwise, wait and see if a beat is coming
		else:
			var waiter = BeatWaiter.new();
			waiter.BeatSignal = bm.DownBeat;
			waiter.MaxWaitTime = (WINDOW / 1000.0);
			call_deferred("add_child", waiter);
			var success = await waiter.Interrupt;
			if (success): pass #early success
			else: 
				pass #failure
				bm.upTempo();
