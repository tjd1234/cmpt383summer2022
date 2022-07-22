% sample_code.pl

%
% A small knowledge base of facts about who likes who, and what.
%
likes(john, mary).      % john likes mary
likes(mary, skiing).    % mary likes skiing
likes(john, skiing).    % john likes skiing
likes(john, flowers).   % john likes flowers
likes(mary, surprises). % mary likes surprises

%
% The x + y = z relation from the notes.
%
xyz(1, 1, 2). % 1 + 1 = 2
xyz(1, 2, 3). % 1 + 2 = 3
xyz(1, 3, 4). % 1 + 3 = 4
xyz(2, 1, 3). % ...
xyz(2, 2, 4).
xyz(2, 3, 5).
xyz(3, 1, 4).
xyz(3, 2, 5).
xyz(3, 3, 6).

%
% Some facts about The Simpsons.
%
fat(homer).                  % homer is fat
dad(homer).                  % homer is a dad
father_of(homer, bart).      % homer is bart's father
kicked(itchy, scratchy).     % itchy kicked scratchy
stole(bart, donut, homer).   % bart stole the donut from homer

%
% Some family relations.
%
male(bob).
male(doug).

female(val).
female(ada).

parents(doug, ada, bob).
parents(val, ada, bob).

%
% Some facts about rocks.
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
