function onCreate()
    makeLuaText('runTxt', "RAP!", 530, 400, 330);
    setTextSize('runTxt', 50);
    addLuaText('runTxt');
    setTextColor('runTxt', 'ffffff');
	setObjectCamera('runTxt', 'hud');
	setProperty('runTxt.visible', false);
	
	addLuaScript('lua/reverseStrum')

   

    makeLuaSprite('red', '', 0, 0);
    makeGraphic('red',1280,720,'ff0000')
    setProperty('red.scale.x',4)
    setProperty('red.scale.y',4)
    setLuaSpriteScrollFactor('red',0,0)
    addLuaSprite('red', false);
    setProperty('red.visible', false);
    setObjectOrder('red', 1);
end

function onCreatePost()
    setTextFont('runTxt', 'Pixel_NES.otf')
end

function onStepHit()
	if curStep == 2200 then
        doTweenColor('timeBar', 'timeBar', 'fc0303', 0.3, 'linear');
	    doTweenColor('timeTxt', 'timeTxt', 'fc0303', 0.3, linear);
    end
	if curStep == 2204 then
        doTweenColor('timeBar', 'timeBar', 'ffffff', 0.3, 'linear');
	    doTweenColor('timeTxt', 'timeTxt', 'ffffff', 0.3, linear);	
    end
	if curStep == 2208 then
        doTweenColor('timeBar', 'timeBar', 'fc0303', 0.3, 'linear');
	    doTweenColor('timeTxt', 'timeTxt', 'fc0303', 0.3, linear);
    end

	if curStep == 2212 then
        doTweenColor('timeBar', 'timeBar', 'ffffff', 0.3, 'linear');
	    doTweenColor('timeTxt', 'timeTxt', 'ffffff', 0.3, linear);
    end

	if curStep == 2216 then
        doTweenColor('timeBar', 'timeBar', 'fc0303', 0.3, 'linear');
	    doTweenColor('timeTxt', 'timeTxt', 'fc0303', 0.3, linear);
    end

	if curStep == 2220 then
        doTweenColor('timeBar', 'timeBar', 'ffffff', 0.3, 'linear');
	    doTweenColor('timeTxt', 'timeTxt', 'ffffff', 0.3, linear);
    end

	if curStep == 2224 then
        doTweenColor('timeBar', 'timeBar', 'fc0303', 1.2, 'linear');
	    doTweenColor('timeTxt', 'timeTxt', 'fc0303', 1.2, linear);
    end

	if curStep == 2624 then
	    setProperty('runTxt.visible', true);
    end

	if curStep == 2752 then
		setProperty('runTxt.visible', false);
    end
    if curStep == 2624 then
 
        setProperty('red.visible', true);
    end 
        if curStep == 2625 then
        setProperty('red.visible', false);
    end
        if curStep == 2627 then
        setProperty('red.visible', true);
    end 
        if curStep == 2628 then
        setProperty('red.visible', false);
    end
        if curStep == 2630 then
        setProperty('red.visible', true);
    end 
        if curStep == 2631 then
        setProperty('red.visible', false);
    end
        if curStep == 2633 then
        setProperty('red.visible', true);
    end 
        if curStep == 2634 then
        setProperty('red.visible', false);
    end
        if curStep == 2636 then
        setProperty('red.visible', true);
    end 
        if curStep == 2635 then
        setProperty('red.visible', false);
    end
        if curStep == 2637 then
        setProperty('red.visible', true);
    end 
        if curStep == 2638 then
        setProperty('red.visible', false);
    end
        if curStep == 2640 then
        setProperty('red.visible', true);
    end 
        if curStep == 2641 then
        setProperty('red.visible', false);
    end
        if curStep == 2643 then
        setProperty('red.visible', true);
    end 
        if curStep == 2644 then
        setProperty('red.visible', false);
    end
        if curStep == 2646 then
        setProperty('red.visible', true);
    end 
        if curStep == 2647 then
        setProperty('red.visible', false);
    end
        if curStep == 2649 then
        setProperty('red.visible', true);
    end 
        if curStep == 2650 then
        setProperty('red.visible', false);
    end
        if curStep == 2652 then
        setProperty('red.visible', true);
    end 
        if curStep == 2653 then
        setProperty('red.visible', false);
    end
        if curStep == 2655 then
        setProperty('red.visible', true);
    end 
        if curStep == 2656 then
        setProperty('red.visible', false);
    end
        if curStep == 2658 then
        setProperty('red.visible', true);
    end 
        if curStep == 2659 then
        setProperty('red.visible', false);
    end
        if curStep == 2661 then
        setProperty('red.visible', true);
    end 
        if curStep == 2662 then
        setProperty('red.visible', false);
    end
        if curStep == 2664 then
        setProperty('red.visible', true);
    end 
        if curStep == 2663 then
        setProperty('red.visible', false);
    end
        if curStep == 2665 then
        setProperty('red.visible', true);
    end 
        if curStep == 2666 then
        setProperty('red.visible', false);
    end
        if curStep == 2667 then
        setProperty('red.visible', true);
    end 
        if curStep == 2668 then
        setProperty('red.visible', false);
    end
        if curStep == 2670 then
        setProperty('red.visible', true);
    end 
        if curStep == 2671 then
        setProperty('red.visible', false);
    end
        if curStep == 2673 then
        setProperty('red.visible', true);
    end 
        if curStep == 2674 then
        setProperty('red.visible', false);
    end
        if curStep == 2676 then
        setProperty('red.visible', true);
    end 
        if curStep == 2677 then
        setProperty('red.visible', false);
    end
        if curStep == 2679 then
        setProperty('red.visible', true);
    end 
        if curStep == 2680 then
        setProperty('red.visible', false);
    end
        if curStep == 2682 then
        setProperty('red.visible', true);
    end 
        if curStep == 2683 then
        setProperty('red.visible', false);
    end
        if curStep == 2685 then
        setProperty('red.visible', true);
    end 
        if curStep == 2686 then
        setProperty('red.visible', false);
    end
        if curStep == 2688 then
        setProperty('red.visible', true);
    end 
        if curStep == 2689 then
        setProperty('red.visible', false);
    end
        if curStep == 2691 then
        setProperty('red.visible', true);
    end 
        if curStep == 2692 then
        setProperty('red.visible', false);
    end
        if curStep == 2694 then
        setProperty('red.visible', true);
    end 
        if curStep == 2695 then
        setProperty('red.visible', false);
    end
        if curStep == 2697 then
        setProperty('red.visible', true);
    end 
        if curStep == 2698 then
        setProperty('red.visible', false);
    end
        if curStep == 2700 then
        setProperty('red.visible', true);
    end 
        if curStep == 2701 then
        setProperty('red.visible', false);
    end
        if curStep == 2703 then
        setProperty('red.visible', true);
    end 
        if curStep == 2704 then
        setProperty('red.visible', false);
    end
        if curStep == 2706 then
        setProperty('red.visible', true);
    end 
        if curStep == 2707 then
        setProperty('red.visible', false);
    end
        if curStep == 2709 then
        setProperty('red.visible', true);
    end 
        if curStep == 2710 then
        setProperty('red.visible', false);
    end
        if curStep == 2712 then
        setProperty('red.visible', true);
    end 
        if curStep == 2713 then
        setProperty('red.visible', false);
    end
        if curStep == 2715 then
        setProperty('red.visible', true);
    end 
        if curStep == 2716 then
        setProperty('red.visible', false);
    end
        if curStep == 2718 then
        setProperty('red.visible', true);
    end 
        if curStep == 2719 then
        setProperty('red.visible', false);
    end
        if curStep == 2721 then
        setProperty('red.visible', true);
    end 
        if curStep == 2722 then
        setProperty('red.visible', false);
    end
        if curStep == 2724 then
        setProperty('red.visible', true);
    end 
        if curStep == 2725 then
        setProperty('red.visible', false);
    end
        if curStep == 2727 then
        setProperty('red.visible', true);
    end 
        if curStep == 2728 then
        setProperty('red.visible', false);
    end
        if curStep == 2730 then
        setProperty('red.visible', true);
    end  
        if curStep == 2731 then
        setProperty('red.visible', false);
    end
        if curStep == 2733 then
        setProperty('red.visible', true);
    end 
        if curStep == 2734 then
        setProperty('red.visible', false);
    end
        if curStep == 2736 then
        setProperty('red.visible', true);
    end 
        if curStep == 2737 then
        setProperty('red.visible', false);
    end
        if curStep == 2739 then
        setProperty('red.visible', true);
    end 
        if curStep == 2740 then
        setProperty('red.visible', false);
    end
        if curStep == 2741 then
        setProperty('red.visible', true);
    end 
        if curStep == 2742 then
        setProperty('red.visible', false);
    end
        if curStep == 2744 then
        setProperty('red.visible', true);
    end 
        if curStep == 2745 then
        setProperty('red.visible', false);
    end
        if curStep == 2747 then
        setProperty('red.visible', true);
    end 
        if curStep == 2748 then
        setProperty('red.visible', false);
    end
        if curStep == 2750 then
        setProperty('red.visible', true);
    end 
        if curStep == 2751 then
        setProperty('rapTxt.visible', false);
        setProperty('red.visible', false);
    end
end