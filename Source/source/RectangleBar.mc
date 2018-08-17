using Toybox.WatchUi as Ui;

class RectangleBar extends Ui.Drawable {
	hidden var percent, maxHeight, xOrigin, color;	
	
    function initialize(params) {
        Drawable.initialize(params);

        color = params.get(:color);
        percent = params.get(:percent);
        maxHeight = params.get(:maxHeight);
        xOrigin = params.get(:xOrigin);
    }

    function draw(dc) {
    	var yCenter = dc.getHeight() / 2;
		var xCenter = dc.getWidth() / 2;				
		
    	var barWidth = 3;    	
    	var height = percent * maxHeight;
    	var yCenterOffset = 9;    	
    
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