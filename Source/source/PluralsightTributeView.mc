using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;
using Toybox.System as Sys;
using Toybox.Lang as Lang;

using Toybox.Time.Gregorian as Date;
using Toybox.Application as App;

using Toybox.ActivityMonitor as Mon;

class PluralsightTributeView extends Ui.WatchFace {
	private var deviceWidth;
	private var currentApp;
	private var currentSettings;	
	
    function initialize() {
        WatchFace.initialize();               
    }

    // Load your resources here
    function onLayout(dc) {
    	deviceWidth = dc.getWidth();    
    	currentApp = App.getApp();
    	currentSettings = Sys.getDeviceSettings();
    
        setLayout(Rez.Layouts.WatchFace(dc));
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() {
    }

    // Update the view
    function onUpdate(dc) {       
        setClockDisplay();
		setDateDisplay();
		setBatteryDisplay();
		setStepCountDisplay();
		setStepGoalDisplay();
		setNotificationCountDisplay();
		setHeartrateDisplay();
		adjustHeartrateDisplayAndStepCountPosition();
        // Call the parent onUpdate function to redraw the layout
        View.onUpdate(dc);
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() {
    }

    // The user has just looked at their watch. Timers and animations may be started here.
    function onExitSleep() {
    }

    // Terminate any active timers and prepare for slow updates.
    function onEnterSleep() {
    }
    
    private function setClockDisplay() {    	    	
        var timeString = getTimeString();                       
        var timeDisplay_Bottom = View.findDrawableById("TimeDisplay_Bottom");
        var TimeDisplay_Top = View.findDrawableById("TimeDisplay_Top");
        timeDisplay_Bottom.setText(timeString);
        TimeDisplay_Top.setText(timeString);
        
        // Users will have to navigate away from their watch face and then back to get this to reset
        if(currentApp.getProperty("InvertTimeColor") == false) {
			timeDisplay_Bottom.setColor(Gfx.COLOR_WHITE);
        	TimeDisplay_Top.setColor(Gfx.COLOR_WHITE);
        }     
    }
    
    private function setDateDisplay() {        
    	var dateDisplay = View.findDrawableById("DateDisplay");
    	dateDisplay.setDatePlaceholder(View.findDrawableById("DatePlaceholder"));      
    	var now = Time.now();
		var date = Date.info(now, Time.FORMAT_LONG);
		var dateString = Lang.format("$1$ $2$, $3$", [date.month, date.day, date.year]);		
		dateDisplay.setDate(dateString);	    			
    }
    
    private function setBatteryDisplay() {
    	var battery = Sys.getSystemStats().battery;				
		var batteryDisplay = View.findDrawableById("BatteryDisplay");      
		batteryDisplay.setText(battery.format("%d"));	
		var batteryBarDisplay = View.findDrawableById("BatteryBarDisplay");
		batteryBarDisplay.setPercent(battery/100);
    }
    
    private function setStepCountDisplay() {
    	var stepCount = Mon.getInfo().steps.toString();		
		var stepCountDisplay = getStepCountDisplay();  
		stepCountDisplay.setText(stepCount);		
    }
    
    private function setStepGoalDisplay() {
    	var stepGoalPercent = ((Mon.getInfo().steps).toFloat() / (Mon.getInfo().stepGoal).toFloat() * 100f);
		var stepGoalDisplay = View.findDrawableById("StepGoalDisplay");      
		stepGoalDisplay.setText(stepGoalPercent.format( "%d" ));	
		var goalPercentBarDisplay = View.findDrawableById("GoalPercentBarDisplay");
		goalPercentBarDisplay.setPercent(stepGoalPercent/100);
    }
    
    private function setNotificationCountDisplay() {
    	var notificationAmount = Sys.getDeviceSettings().notificationCount;
		
		var formattedNotificationAmount = "";
		
		if(notificationAmount > 10)	{
			formattedNotificationAmount = "10+";
		}
		else {
			formattedNotificationAmount = notificationAmount.format("%d");
		}
	
		var notificationCountDisplay = View.findDrawableById("NotificationCountDisplay");      
		notificationCountDisplay.setText(formattedNotificationAmount);
    }
    
    private function setHeartrateDisplay() {
    	var heartRate = "";
    	
    	if(DoesDeviceSupportHeartrate()) {
    		heartRate = retrieveHeartrateText();
    	}
    	else {
    		heartRate = "N/A";
    	}
    	
		var heartrateDisplay = getHeartrateDisplay();      
		heartrateDisplay.setText(heartRate);
    }
    
    private function getHeartrateDisplay() {
    	return View.findDrawableById("HeartrateDisplay");
    }

	private function getStepCountDisplay() {
		return View.findDrawableById("StepCountDisplay");    
	}
    
    private function DoesDeviceSupportHeartrate() {
    	return Mon has :INVALID_HR_SAMPLE;
    }
    
    private function getNotificationCountDisplay() {
    	return View.findDrawableById("NotificationCountDisplay");
    }
    
    private function adjustHeartrateDisplayAndStepCountPosition() {
    	if(DoesDeviceSupportHeartrate()) {
    		return;
    	}
    	
    	var heartrateDisplay = getHeartrateDisplay();
    	heartrateDisplay.setText("");
    	
    	var notificationCountDisplay = getNotificationCountDisplay();
    	notificationCountDisplay.locX = deviceWidth / 2;
    }
    
    private function retrieveHeartrateText() {
    	var heartrateIterator = ActivityMonitor.getHeartRateHistory(null, false);
		var currentHeartrate = heartrateIterator.next().heartRate;
		
		if(currentHeartrate == Mon.INVALID_HR_SAMPLE) {
			return "Invalid";
		}		
		
		return currentHeartrate.format("%d");
    }
    
    private function getTimeString() {    	
    	var clockTime = Sys.getClockTime();        		
    	var hour = clockTime.hour;	
		var minute = clockTime.min.format("%02d");				
		
		if(!currentSettings.is24Hour) {
			hour = hour % 12;
        	hour = (hour == 0) ? 12 : hour;  
        }        	  
        
        return Lang.format("$1$:$2$",[hour, minute]);
    }    
}
