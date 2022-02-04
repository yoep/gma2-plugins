# Grandma 2 Plugins

These plugins for Grandma2 allow a variation of functions such as a color & position picker
or a color & position effect generator.

## Installation

Add each plugin to your grandma2 show file in the same order as they are listed in the directory.

- 0_common.xml
- 1_prepare.xml
- 2_groups.xml

## Scripts

### Common

Contains common functions which are used by the other scripts.
This script doesn't do anything on it's own, but needs to be loaded on startup.

### Prepare

Prepare the current session with all required scaffolding.
This script will prepare the pools of the session.

### Groups

Create and manage existing groups within MA.

This plugin can create multiple groups based on the user input.
These groups are later used within the other plugins.

## Predefined

## Effects

The `effects/effect_color_fx.xml` is the predefined effect that is required 
by the color FX generator. This is the effect that is triggered by 
the executor/sequence in the background and this is the one that is configured 
by the color FX generator.

Import this effect to the correct index which is used by the executor.