<p align="center">
  <img src="https://i.imgur.com/jPYeXxF.png">
</p>

## RocketCAD FiveM Integration

The RocketCAD Integration is built to integrate RocketCAD and your FiveM Server.

## Installation Instructions

To install this resource, simply install it just as you would any other resource into your FiveM Server. 

1) Download the latest version from the releases page
2) Place the resource into your server-data/resources directory
3) Configure the resources by using the Configuration Guide
4) Once configured, add "start rc-integration" to your server.cfg file
5) Start your server and enjoy!

## Whitelist Installation Instructions

1) The "rc-whitelist" resource is included in your primary server resource.
2) Move the "rc-whitelist" folder out into your /resources/ directory
3) Add **start rc-whitelist** to your server.cfg file
4) Head into the "config.lua" file inside of the resource
5) Enter in your Community ID into the field provided, this is located on the "integrate" page of RocketCAD
6) You are done! The CAD will now check users to see if they are apart of your community before letting them into your server.

## Configuration Guide

Configuring the RocketCAD source is incredibly simple. Use the resources below to find quickly understand each option to get your server back up and running!

#### config.lua Configuration

Name: The "name" setting is the name of your Communications Department. For example, "San Andreas Communications" or "Acme City Dispatch"

Community Code: The "code" setting is your Unique ID of your community, this is available from https://therocketcad.com/integrate > [Select Community] > "Your Community ID"

Server ID: The "serverid" setting is the ID for the specific server you're placing the resource in. This is found under the Owner Panel > API Access tab.

##### Alert

Alert 1: The "alert1" setting is the title of your Emergency Traffic Only alert, this should match the alert title you have configured in your CAD already. For example, "Signal 100"

Alert 2: The "alert2" setting is the title of your Stop Transmitting alert, this should match the alert title you have configured in your CAD already. For example, "10-3"

#### sv-integration.lua Configuration

API Key: The "api key" config option is the API Key you wish to use with this server. This can be generated from the Owner Panel > API Access tab.

## Integration Features

#### 1) Call Notification & Directions
The Call Notification feature will notify you in-game when you are assigned to a new call and will provide you with the title and postal location. Accompanied by the CAD that will play an audible sound, you will now when you get a call and where you are supposed to go without even opening up the CAD! If the location is apart of our large database of locations around the map, you will be auto-waypointed to the location to begin responding to.

#### 2) Automatic Location Updating
The Automatic Location Update feature allows for Dispatch and Units to be aware of all player's locations at all times. Every 60 seconds, a player's location will be updated in CAD giving Dispatch an almost instant picture of where every unit is. LEO and Fire units can also view each other's locations under the new "Units" tab of the MDT.

#### 3) Plate Searches
The Plate Searching feature allows you to quickly type the plate of any vehicle in chat (Using the /plate command) and will return the results instantly as a sleek notification above your game map. This removes the need to tab into your Steam Browser or open the MDT externally.

#### 4) Emergency and Stop Transmitting Tone Alerts
If you have opted to mute your MDT whilst patrolling, you will not hear the audible effects of Emergency Broadcast Only and Stop Transmitting alerts being placed into effect. You now will receive alerts in-game notifying you of these alerts, whether you have the MDT muted or not.

#### 5) Panic Button Alert + Waypointing
If any unit in-game activates their Panic Button using the /panic command in-chat, all available units will be automatically way-pointed to their location and alerted in-game. This accompanies the visual and audio effects of the MDT itself.

#### 6) 911 Alerts
Similar to the previous integration, the /911 command allows for Civilians to alert dispatchers of their Name and Current Location so they may quickly generate an assignment and begin sending units.

#### 7) Whitelisting
In need of a non-sql or json whitelisting script? We've got you covered, RocketCAD now includes a whitelisting script that simply checks if the user is apart of your RocketCAD Community and either grants or denies access instantly. No need for resource or server restarts, as the API updates instantly!
