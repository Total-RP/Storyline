# Change-log for version 2.0.1 of Storyline

## Bug fixes

- Comparison tooltips are now always visible, just like in the default UI.
- The dialog options scrolling frame is now dynamically resized with Storyline's frame so that the options do not overlap the dialog text when Storyline is displayed in a small window and additional margins are applied when Storyline is displayed as a bigger window.


# Change-log for version 2.0 of Storyline

This is the best update to Storyline yet. We have addressed many shortcomings and greatly improved the UI to make Storyline an even better way to experience questing than before!

## Well…

No more Well… button! The system handling dialog options has been completely rebuilt to be highly dynamic and future proof. This new system allows us to show all the dialog options directly at the center of the Storyline frame, with scrolling if there are many options. Options are ordered from the one you are the most likely to click to the one you are the less likely to click. You can still use keyboard shortcuts if the option is enabled.

![Nicer dialog options](https://totalrp3.info/documentation/changelogs/storyline_2_0_dialog_options.jpg)

The options now have a nicer texture and handle long text or text with line breaks perfectly. And don't forget you can change the font used and the size of the font in the settings.

## A peek at the rewards

The system handling rewards has been completely rebuilt to be highly dynamic and future proof too. This new system allows us to finally show the rewards before accepting the quest, right inside the objectives popup!

![See rewards before accepting a quest](https://totalrp3.info/documentation/changelogs/storyline_2_0_rewards_peek.jpg)

We have also improved the implementation of some rewards so they render nicer, like skill points, spells or followers. Finally, these changes made it really easy to fix the issue where rewards had empty names because the information were not downloaded from the server yet, no more empty boxes!

## Other enhancements

- **Storyline will no longer open incorrectly when you loot an item that launch a quest or for quests that are dynamically added to your quest log**. Clicking on the quest notification in the quest tracker will open Storyline.
- You can now *Shift-click* the Decline button to ignore/un-ignore a quest.
- The dialog text frame at the bottom is now correctly resized when the text size of the elements inside it is changed.
