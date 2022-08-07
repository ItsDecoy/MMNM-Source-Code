function onCountdownTick(counter)
    --BF notes

	noteTweenX("BFNoteLeft", 4, 92, 0.01, linear)
	noteTweenX("BFNoteDown", 5, 202, 0.01, linear)
	noteTweenX("BFNoteUp", 6, 316, 0.01, linear)
	noteTweenX("BFNoteRight", 7, 428, 0.01, linear)

    --OPPONENT notes

	noteTweenX("OPPONENTNoteLeft", 0, 730, 0.01, linear)
	noteTweenX("OPPONENTNoteDown", 1, 845, 0.01, linear)
	noteTweenX("OPPONENTNoteUp", 2, 960, 0.01, linear)
	noteTweenX("OPPONENTNoteRight", 3, 1067, 0.01, linear)
end