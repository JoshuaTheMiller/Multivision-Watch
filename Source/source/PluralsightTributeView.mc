using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;
using Toybox.System as Sys;
using Toybox.Lang as Lang;

using Toybox.Time.Gregorian as Date;
using Toybox.Application as App;

using Toybox.ActivityMonitor as Mon;

class PluralsightTributeView extends Ui.WatchFace {

    function initialize() {
        WatchFace.initialize();
    }

    // Load your resources here
    function onLayout(dc) {
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
    
    function setClockDisplay() {
    	var clockTime = Sys.getClockTime();
        var timeString = Lang.format("$1$:$2$", [clockTime.hour, clockTime.min.format("%02d")]);
        var view = View.findDrawableById("TimeDisplay");
        view.setText(timeString);
    }
    
    function setDateDisplay() {        
    	var now = Time.now();
		var date = Date.info(now, Time.FORMAT_LONG);
		var dateString = Lang.format("$1$ $2$, $3$", [date.month, date.day, date.year]);
		var dateDisplay = View.findDrawableById("DateDisplay");      
		dateDisplay.setText(dateString);	    	
    }
    
    function setBatteryDisplay() {
    	var battery = Sys.getSystemStats().battery;				
		var batteryDisplay = View.findDrawableById("BatteryDisplay");      
		batteryDisplay.setText(battery.format("%d")+"%");	
    }
    
    function setStepCountDisplay() {
    	var stepCount = Mon.getInfo().steps.toString();		
		var stepCountDisplay = View.findDrawableById("StepCountDisplay");      
		stepCountDisplay.setText(stepCount);		
    }
    
    function setStepGoalDisplay() {
    	var stepGoalPercent = ((Mon.getInfo().steps).toFloat() / (Mon.getInfo().stepGoal).toFloat() * 100f);
		var stepGoalDisplay = View.findDrawableById("StepGoalDisplay");      
		stepGoalDisplay.setText(stepGoalPercent.format( "%d" ) + "%");	
    }
    
    function setNotificationCountDisplay() {
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
}
