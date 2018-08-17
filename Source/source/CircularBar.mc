using Toybox.WatchUi as Ui;
using Toybox.Math;

class CircularBar extends Ui.Drawable {
	hidden var centerX;
    hidden var centerY;

	hidden var percent, color, orientation;	
	
    function initialize(params) {
        Drawable.initialize(params);

        color = params.get(:color);
        percent = params.get(:percent);                
        orientation = params.get(:orientation);        
    }

    function draw(dc) {
    	centerX = dc.getWidth() / 2;
    	centerY = dc.getHeight() / 2;    
        
        drawArcGroups(dc, 1, 1);                                                          
        drawArcGroups(dc, percent, 3);
    }
    
    function setPercent(newPercent) {
    	percent = newPercent;       	 
    }
    
    hidden function drawArcGroups(dc, percent, barWidth) {      	        	    
    	dc.setColor(color, color);         
    	
    	var radianStart = degreesToRadians(5);
    	var maxRadianAddition = degreesToRadians(55);
    	
    	if(percent > 1) {
    		percent = 1;
    	}
    	
    	// This is to solve a bug where the drawing of the circle flips out
    	// when percent is at 1.
    	// I'm tired. 
    	if(percent < .02) {
    		percent = 0;
    	}
    	
    	var radianEndFromPercent = radianStart + maxRadianAddition * percent;
    	
    	if(radianEndFromPercent <= radianStart)
    	{
    		return;
    	}
    	
    	var orientedStart = radianStart;
    	var orientedEnd = radianEndFromPercent;    	
    	
    	if(orientation == 0) {
    		orientedStart += Math.PI;
    		orientedEnd += Math.PI;
    	}
    	
    	drawDoubleArcs(dc, barWidth, 0, orientedStart, orientedEnd);
    	drawDoubleArcs(dc, barWidth, 1, -orientedStart, -orientedEnd);
    }     
    
    hidden function drawDoubleArcs(dc, thickness, direction, radianStart, radianEnd) {
    	for(var i = 0; i < thickness; i++) {
    		dc.drawArc(centerX, centerY, 118 - i, direction, radiansToDegrees(radianStart), radiansToDegrees(radianEnd));
    		
    		dc.drawArc(centerX, centerY, 114 - i, direction, radiansToDegrees(radianStart), radiansToDegrees(radianEnd));
    	}        		    	
    }
    
    hidden function degreesToRadians(degrees) {
    	return degrees * Math.PI / 180;
    }  
    
    hidden function radiansToDegrees(radians) {
    	return radians * 180 / Math.PI;
    }  
}