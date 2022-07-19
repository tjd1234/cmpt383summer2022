% rocks2.pl

%
% Some facts about rocks.
% https://www.thoughtco.com/rock-identification-tables-1441174
%
%
% Grouped by predicate name.
%
grain(obsidian, fine).
grain(pumice, fine).
grain(scoria, fine).
grain(felsite, fine_or_mixed).
grain(andesite, fine_or_mixed).
grain(basalt, fine_or_mixed).
grain(pegmatite, very_coarse).

color(obsidian, dark).
color(pumice, light).
color(scoria, dark).
color(felsite, light).
color(andesite, medium).
color(basalt, dark).
color(pegmatite, any).

composition(obsidian, laval_glass).
composition(pumice, sticky_lava_froth).
composition(scoria, fluid_lava_froth).
composition(felsite, high_silica_lava).
composition(andesite, medium_silica_lava).
composition(basalt, low_silica_lava).
composition(pegmatite, granitic).