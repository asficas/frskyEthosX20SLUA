-- *************************************************************************
-- **                                                                     **
-- **  This LUA script for the X20s is based                              **
-- **  on VSpeak LUA scripts for FrSky Horus                              **
-- **  as published on VSpeak website.                                    **
-- **                                                                     **
-- **  Use at own risk!                                                   **
-- **                                                                     **
-- **                                                                     **
-- **                                                                     **
-- **                                                                     **
-- **                                                                     **
-- **                                                                     **
-- *************************************************************************


local function create(zone, options)
    -- return {zone=zone, options=options}
    return {zone=zone, options=options, source=nil, value=0, source1=nil, value1=0 }
end

local function update(thisZone, options)
    thisZone.options = options
end
  

local function paint(widget)    
    w, h = lcd.getWindowSize()
    text_w, text_h = lcd.getTextSize("")
    lcd.font(FONT_STD)
    lcd.color(lcd.RGB(255,255,255))
    -- lcd.drawText(w/2, (h - text_h)/2, w.." x "..h, CENTERED)
    local t = widget.value
    -- lcd.drawText(0,0,t)
    local msg_table_KingTech = {
        [-20] = "- ERROR -",
        [-19] = "Unknown",
        [-13] = "CAB-Lost",
        [-12] = "FlameOut",
        [-11] = "TempHigh",
        [-10] = "SpeedLow",
        [-9] = "Failsafe",
        [-8] = "RxPwFail",
        [-7] = "Overload",
        [-6] = "Low Batt",
        [-5] = "StartBad",
        [-4] = "Weak Gas",
        [-3] = "Time Out",
        [-2] = "Ign.Fail",
        [-1] = "Glow Bad",
        [0] = "Trim Low",
        [1] = "User Off",
        [2] = "Stop",
        [3] = "Cooling",
        [4] = "Ready",
        [5] = "GdReady",
        [6] = "GlowTest",
        [7] = "StickLo!",
        [8] = "PrimeVap",
        [9] = "BurnerOn",
        [10] = "Start On",
        [11] = "Ignition",
        [12] = "Stage1",
        [13] = "Stage2",
        [14] = "Stage3",
        [20] = "Running",
        [22] = "ReStart",
    }
    status_str = msg_table_KingTech[t] 
    lcd.font( FONT_L ) 
    lcd.drawText(w/2,0,"Status: "..status_str,CENTERED )
    local batt_v = widget.value1
    lcd.drawText(w/2,21,"Voltage: "..batt_v.." V",CENTERED )
    local fuel_u = widget.value2
    lcd.drawText(w/2,42,"Fuel used: "..fuel_u.." mL",CENTERED )

end

local function configure(widget)
    -- Source choice
    line = form.addLine("Status Source")
    form.addSourceField(line, nil, function() return widget.source end, function(value) widget.source = value end)
    line1 = form.addLine("Voltage Source")
    form.addSourceField(line1, nil, function() return widget.source1 end, function(value1) widget.source1 = value1 end)
    line2 = form.addLine("Fuel Source")
    form.addSourceField(line2, nil, function() return widget.source2 end, function(value2) widget.source2 = value2 end)
end



local function backgroundProcessWidget(widgetToProcessInBackground)
	-- Nichts
end

local function wakeup(widget)
    if widget.source then
        local newValue = widget.source:value()
        if widget.value ~= newValue then
            -- print("lcd.invalidate "..widget.value.." "..newValue)
            widget.value = newValue
            -- widget.value = 5
            lcd.invalidate()
            end
    end

    if widget.source1 then
        local newValue1 = widget.source1:value()
        if widget.value1 ~= newValue1 then
            -- print("lcd.invalidate "..widget.value.." "..newValue)
            widget.value1 = newValue1
            -- widget.value1 = 9.8
            lcd.invalidate()
            end
    end

    if widget.source2 then
        local newValue2 = widget.source2:value()
        if widget.value2 ~= newValue2 then
            -- print("lcd.invalidate "..widget.value.." "..newValue)
            widget.value2 = newValue2
            -- widget.value2 = 1243
            lcd.invalidate()
            end
    end


end

local function read(widget)
    widget.source = storage.read("source")
    widget.source1 = storage.read("source1")
    widget.source2 = storage.read("source2")
end

local function write(widget)
    storage.write("source", widget.source)
    storage.write("source1", widget.source1)
    storage.write("source2", widget.source2)
end


local function init()
    system.registerWidget({key="GTBTLM", name="Turbine Telemetry Display", create=create, update=update, wakeup=wakeup,configure=configure, background=backgroundProcessWidget, paint=paint,read=read, write=write})
end

return {init=init}
