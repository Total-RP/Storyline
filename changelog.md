# Change-log version 1.3

## Legion compatibility

This version fixes a lot of issues introduced with patch 7.0.

## Workflow improvements
- **Fast-forward**: you can now **right-click** or use **SHIFT + spacebar** to fast forward to the end of a dialog.
- **Next action improvement**: we have tweaked what a click on the text (or the spacebar) do when at the end of a dialog to make it always choose the best option available instead of just closing the dialog. If a dialog has choices, clicking on the text at the end of a dialog will now pick the best choice (first completed quests, then quests that are available, then gossip choices and finally dialog for quest that are not completed yet).
- **New disable Storyline in instances option**. A new option (disable by default), allow you to disable Storyline when you are inside an instance (dungeon, raid, battlegrounds, etc.).
- You can now use the middle click of the mouse on the text to close the dialog quickly.

## UI improvements

- We are now using a **new system to hide the default quest frame and dialog frame**. The frames should no longer re-appear when opening other frames, and the other frames should be correctly aligned to the left of the screen without any gap. This version is also more compatible with other UI customization add-ons. This new solution require a reload of the user interface.
- With the new system to hide the quest frame, we have also implemented an **option to use the default interface layout engine**. When opening default frames, they appear on the left of the screen, one next to the other, with priorities. Storyline can now use that layout engine to be placed on the left just like the character pannel or the spellbook.

## Animation/Scaling

- Improved scaling and animation for female Orc