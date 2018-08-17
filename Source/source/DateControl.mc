using Toybox.WatchUi as Ui;

class DateControl extends Ui.Drawable {
	hidden var text, font, color, justification;	
	
	hidden var datePlaceholder;
	
    function initialize(params) {
        Drawable.initialize(params);

        text = params.get(:text);
        font = params.get(:font);   
        color = params.get(:color);
        justification = params.get(:justification);       
    }

    function draw(dc) {
    	var centerY = dc.getHeight() / 2;
		var deviceWidth = dc.getWidth();
		var halfWidth = deviceWidth / 2;					
            
        var yPosition = centerY + 30;
            
        dc.setColor(color, color);														
		
		// setting fonts via a param was giving me issues. I'm moving on from that problem for now.
		// dc.drawText(halfWidth, yPosition, Rez.Fonts.smallFont, text, justification);	
		
		if(datePlaceholder != null) {
			datePlaceholder.setText(text);
			datePlaceholder.locX = halfWidth;
			datePlaceholder.locY = yPosition;
			datePlaceholder.setJustification(justification);
		}				
    }
    
    function setDate(date) {
    	text = date;
    }
    
    function setDatePlaceholder(newPlaceHolder) {
    	datePlaceholder = newPlaceHolder;
    }
}