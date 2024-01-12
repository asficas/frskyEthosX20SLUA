# frskyEthosX20SLUA

## LUA scripts for ethos

This LUA script is written for EthOs firmware in order to display a widget with telemetry data on a FrSky X20S radio.
The telemetry data are received via a VSpeak interface from a KingTech turbine.

## Usage

Create a folder named GTBTLM inside the scripts folder on the transmitter.
Download the main.lua file and place it inside the GTBTLM folder.

Add the widget to a screen. Click configure widget and select the sources from the available telemetry data.
In the case of a KingTech Turbine the following are selected:
Status -> TMP2 
Voltage -> ADC3
Fuel: -> FUEL


![image](https://github.com/asficas/frskyEthosX20SLUA/assets/21962448/12e5013a-6611-4a6b-8a62-660db48f5037)
