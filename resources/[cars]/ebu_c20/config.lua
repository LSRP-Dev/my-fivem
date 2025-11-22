Config = {}

Config.MarkerType    			  = 25
Config.MarkerColor                = { r = 0, g = 255, b = 100 }
Config.CarMarkerSize   			  = { x = 2.0, y = 2.0, z = 1.0 }
Config.InteractMarkerSize   		  = { x = 1.0, y = 1.0, z = 1.0 }

---ALLOWED CLASSES
Config.bikes        = {8,13}
Config.cars         = {0,1,2,3,4,5,6,7,9,11,12,17,18,15,10,11,19,20}

Config.ShowMarkers  = true
Config.InteractKey  = 51  -- Default: 51 = E

Config.AttachNotify = true
Config.NotiLoadMessage = "Vehicle attached to trailer"

Config.rampInstant = false --set to true if you want the ramps to instantly open/close

Config.CommandPrefix = 'Press'
Config.DetachCommand = 'to move into the vehicle'
Config.RampCommand   = 'to manipulate the ramp'
Config.TrailerCommand = 'to attach/detach trailer'
Config.LightCommand = 'to toggle the lights'


Config.ManualLock = false
Config.AttachCommand   = 'to attach the vehicle'