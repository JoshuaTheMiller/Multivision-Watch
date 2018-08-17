using Toybox.WatchUi as Ui;
using Toybox.Math;

class RectangleBar extends Ui.Drawable {
	hidden var yCenterOffset = 9;	

	hidden var percent, xOffsetFromSide, color, orientation;	
	
    function initialize(params) {
        Drawable.initialize(params);

        color = params.get(:color);
        percent = params.get(:percent);        
        xOffsetFromSide = params.get(:xOffsetFromSide);
        orientation = params.get(:orientation);        
    }

    function draw(dc) {
    	var deviceHeight = dc.getHeight();     			
		var maxHeight = deviceHeight / 2 - yCenterOffset;			        
        var yCenter = deviceHeight / 2;              
        
        var height = Math.ceil(percent * maxHeight);
        
        var xOrigin = 0;
        
        if(orientation == 1) {
        	xOrigin = dc.getWidth() - 3;
        	drawRectangles(dc, xOrigin + 2, maxHeight, yCenter, 1);
        }   
        else {
        	drawRectangles(dc, xOrigin, maxHeight, yCenter, 1);
        }     
                                                                  
        drawRectangles(dc, xOrigin, height, yCenter, 3);
    }
    
    function setPercent(newPercent) {
    	percent = newPercent;       	 
    }
    
    hidden function drawRectangles(dc, xOrigin, height, yCenter, barWidth) {
    	var xPosBar1 = 0;
    	var xPosBar2 = 0;    
    	  
    	if(orientation == 1) {
    		xPosBar1 = xOrigin - 1;
    		xPosBar2 = xOrigin - 8;
    	}    	
    	else {
    		xPosBar1 = xOrigin + 1;
    		xPosBar2 = xOrigin + 8;
    	}
      	        	    
    	dc.setColor(color, color);
		dc.fillRectangle(xPosBar1, yCenter - yCenterOffset - height, barWidth, height);
		dc.fillRectangle(xPosBar2, yCenter - yCenterOffset - height, barWidth, height);
    	
		dc.fillRectangle(xPosBar1, yCenter + yCenterOffset, barWidth, height);
		dc.fillRectangle(xPosBar2, yCenter + yCenterOffset, barWidth, height);				
    }
}