# Change-log version 1.4.1

## Bug fixes

- Fixed an issue with the order hall upgrades NPCs when the flavor NPC text option is enabled.
- Fixed a Lua error with the custom scaling.
- The window can now be dismissed using escape even when not using the default game layout.

# Change-log version 1.4

## Custom scaling system

We have restored the custom scaling system. We had to take it out after the modifications brought by Legion. Storyline will now remember the height you have defined for a model.

Additionally, the vertical and horizontal offset of a model is now saved per model, and not for a model against another model, so models that are not correctly centered only need to be fixed once.

_Reminder_: You can manually change the height and the position of a model. To change the height of a model maintain the ALT key down and scroll on a model, to change its horizontal offset maintain the ALT key down and left click or right click on a model, and to change the vertical offset maintain the CONTROL key down and left click or right click. If you additionally maintain the SHIFT key down for any of those actions, the value will be incremented by 10 instead of 1 so it's faster.

## Bug fixes

- Fixed a bug when using the next action shortcut when a NPC has at least one active quest and one quest available.
- Fixed an issue that was making the Storyline window appear briefly for some NPCs.
- Fixed an issue that was preventing in game events from being triggered for auto-accepted quests.
- Fixed an issue preventing the frame from being locked properly.

## Improvements

- Added Brazilian Portuguese localization
- Added sounds when the Storyline frame is opened and closed.