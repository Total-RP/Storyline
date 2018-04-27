## 3.0 - Unreleased

### Added

- The player model is now refreshed when changes happen to your character (equipment changes, druid forms, etc.).
- The scaling between the two models is now animated when one of the models changes.
- The 3D models are now animated into the view.

### Modified

- Completely re-implemented the way animations are played on the 3D models. Using new in-game methods for timing animations, we no longer need our own database of animation timings. All models are now timed automatically by the game.

### Fixed

- Fixed Lua error when displaying spell rewards.
- Models with no speaking animation will no longer start playing their idle animation from the beginning when they are being animated.
- Fixed an issue that prevented dead NPCs to appear as dead in Storyline.
- Fixed an issue where the player model would not be displayed correctly when Storyline was opened when the player model was not already loaded (typically during login).
- Fixed an issue that would make the game crash during quests that have an attached 3D portrait.
- Fixed an issue that would prevent the correct attached 3D portrait from appearing for some quests or display it when it shouldn't be.
