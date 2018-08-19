using Toybox.WatchUi as Ui;

class TextBlockBackground extends Ui.Drawable {
	hidden var backgroundColor, xAnchor, xOffset;	
	
    function initialize(params) {
        Drawable.initialize(params);

        backgroundColor = params.get(:backgroundColor);
        xAnchor = params.get(:xAnchor);         
        xOffset = params.get(:xOffset);             
    }

    function draw(dc) {		
    	var height = 22;    
        var width = 45;
        
    	var xPosition = xOffset;
    	
    	if(xAnchor == Right) {
    		xPosition += dc.getWidth() - width;
    	} else if(xAnchor == Left) {
    		xPosition += 0;
    	} else {
    		xPosition += dc.getWidth() / 2 - width / 2;
    	}
    	    	    	
    	var y = dc.getHeight() / 2;            
                
        var actualY = y - height / 2;        
        
        dc.setColor(backgroundColor, backgroundColor);
		dc.fillRoundedRectangle(xPosition, actualY, width, height, height/2);			
    }
}