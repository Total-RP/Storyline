# Changelog

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

## [2.0.13](https://github.com/Ellypse/Storyline/compare/2.0.12...2.0.13) - 2018-04-18

### Fixed

- Fixed an error when displaying the tooltip for currency quest objectives (order hall resources, nethershards, etc.).

### Fixed

- You can now right-click the objectives and rewards popup frames to close them.

### Modified

- Updated libraries and in-game list of Patreon supporters.

## [2.0.12](https://github.com/Ellypse/Storyline/compare/2.0.11...2.0.12) - 2018-04-01

### Removed

- Removed April fools' day joke.

## [2.0.11](https://github.com/Ellypse/Storyline/compare/2.0.10...2.0.11) - 2018-03-31

### Fixed

- Fixed a critical issue with localizations that are not English or French.

## [2.0.10](https://github.com/Ellypse/Storyline/compare/2.0.9...2.0.10) - 2018-03-31

### Fixed

- Fixed a library compatibility issue when running both Total RP 3 and Storyline.

## [2.0.9](https://github.com/Ellypse/Storyline/compare/2.0.8...2.0.9) - 2018-03-30

### Modified

- Updated libraries and dependencies

## [2.0.8](https://github.com/Ellypse/Storyline/compare/2.0.7...2.0.8) - 2018-02-22

### Fixed

- Fixed an issue with the auto-equip rewards option caused by the scaling introduced in patch 7.3.5.

## [2.0.7] - 2018-01-07

### Added

- Added new option to disable Storyline while in the Darkmoon Faire Island (disabled by default)
- Added thank you message panel for Ellypse's Patreon supporters.

## [2.0.6] - 2017-06-20

### Fixed

- Fixed issues for patch 7.3

[2.0.7]: https://github.com/Ellypse/Storyline/compare/2.0.6...2.0.7
[2.0.6]: https://github.com/Ellypse/Storyline/compare/2.0.5...2.0.6
