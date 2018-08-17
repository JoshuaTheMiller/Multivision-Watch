using Toybox.WatchUi as Ui;

class RectangleBar extends Ui.Drawable {
	hidden var percent, xOrigin, color;	
	
    function initialize(params) {
        Drawable.initialize(params);

        color = params.get(:color);
        percent = params.get(:percent);        
        xOrigin = params.get(:xOrigin);
    }

    function draw(dc) {
    	var deviceHeight = dc.getHeight(); 
    	var yCenter = deviceHeight / 2;
		var xCenter = dc.getWidth() / 2;				
		var yCenterOffset = 9;    	
		var maxHeight = deviceHeight / 2 - yCenterOffset;
			
    	var barWidth = 3;    	
    	var height = percent * maxHeight;    	
            
        dc.setColor(color, color);
		dc.fillRectangle(xOrigin + 1, yCenter + yCenterOffset, barWidth, height);
		dc.fillRectangle(xOrigin + 8, yCenter + yCenterOffset, barWidth, height);
					
		dc.fillRectangle(xOrigin + 1, yCenter - yCenterOffset - height, barWidth, height);
		dc.fillRectangle(xOrigin + 8, yCenter - yCenterOffset - height, barWidth, height);
    }
    
    function setPercent(newPercent) {
    	percent = newPercent;       	 
    }
}