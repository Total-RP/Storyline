## Changelog for version 3.0.3.1

### Fixed

- Fixed the Lua error related to promises. We must not promise what we ought not.

## Changelog for version 3.0.3

### Added

- When the option to force flavor gossip text for NPC dialogs is enabled, a new button is added to the UI, next to the button to close Storyline, that allows you to blacklist specific NPCs that you don't want the flavor gossip text to appear (mission tables, flight masters, etc.). _This will not disable dialogs that are not disabled when the force gossip option is not enabled._

### Fixed

- Updated version number according to patch 8.1.
- Removed replay button from the classic quest frame as it would throw a Lua error due to recent changes.

## Changelog for version 3.0.2

### Fixed

- Fixed an issue that could cause Storyline to be incorrectly reported as the source of other add-ons errors.

## Changelog for version 3.0.1

### Fixed

- Hotfixed an issue with the library shared between Total RP 3 and Storyline.
- Updated list of Patreon supporters.

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
