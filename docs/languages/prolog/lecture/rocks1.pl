% rocks1.pl

%
% Some facts about rocks.
% https://www.thoughtco.com/rock-identification-tables-1441174
%
% Grouped by rock name. Prolog gives warnings the predicates are not together.
%
grain(obsidian, fine).
color(obsidian, dark).
composition(obsidian, laval_glass).

grain(pumice, fine).
color(pumice, light).
composition(pumice, sticky_lava_froth).

grain(scoria, fine).
color(scoria, dark).
composition(scoria, fluid_lava_froth).

grain(felsite, fine_or_mixed).
color(felsite, light).
composition(felsite, high_silica_lava).

grain(andesite, fine_or_mixed).
color(andesite, medium).
composition(andesite, medium_silica_lava).

grain(basalt, fine_or_mixed).
color(basalt, dark).
composition(basalt, low_silica_lava).

grain(pegmatite, very_coarse).
color(pegmatite, any).
composition(pegmatite, granitic).
