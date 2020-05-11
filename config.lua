-- Use /dl to delete a current waypoint

config = {

    blip = {
        -- See link above for colors
        color = 9,
        -- Text to be displayed by the blip in the map
        blipText = "Call",
        -- See link above for sprites
        sprite = 148,
        -- How close you have to be to a waypoint before it gets deleted
        distToDelete = 40,
        -- Name to be displayed at the top of the callout notifications
        name= "Ottawa Communications Center"
    },

    blip_panic = {
        -- See link above for colors
        color = 1,
        -- Text to be displayed by the blip in the map
        blipText = "Panic",
        -- See link above for sprites
        sprite = 487,
        -- How close you have to be to a waypoint before it gets deleted
        distToDelete = 30
    },

    alert = {
        -- Text to be displayed for Emergency Traffic Only Alert
        alert1 = "Signal 100",
        -- Text to be displayed for Broadcast Alert
        alert2 = "10-3"
    },
}
