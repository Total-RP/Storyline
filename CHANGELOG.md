## Changelog for version 3.0

_Note: The scaling system in this version is **temporary** and will be improved in a future version._

### Added

- The player model is now refreshed when changes happen to your character (equipment changes, druid forms, etc.).
- The scaling between the two models is now animated when one of the models changes.
- The 3D models are now animated into the view.
- Added support for quests with special background and wax seals.
- Added item icon border for Azerite empowered rewards.

### Modified

- Completely re-implemented the way animations are played on the 3D models. Using new in-game methods for timing animations, we no longer need our own database of animation timings. This means that all models are now timed automatically by the game.

### Fixed

- Fixed Lua error when displaying spell rewards.
- Empty lines will now be skipped and no longer be shown in the dialogs.
- NPC emotes spanning over multiple paragraphs are now correctly colored until the actual end of the emote.
- Models with no speaking animation will no longer start playing their idle animation from the beginning when they are being animated.
- Fixed an issue that prevented dead NPCs to appear as dead in Storyline.
- Fixed an issue where the player model would not be displayed correctly when Storyline was opened when the player model was not already loaded (typically during login).
- Fixed an issue that would make the game crash during quests that have an attached 3D portrait.
- Fixed an issue that would prevent the correct attached 3D portrait from appearing for some quests or display it when it shouldn't be.
- Remove April fools' joke from UI.
