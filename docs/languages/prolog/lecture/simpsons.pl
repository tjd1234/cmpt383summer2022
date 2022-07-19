%
% A simple knowledge base of facts.
%
fat(homer).                  % homer is fat
thin(homer).
dad(homer).                  % homer is a dad
father_of(homer, bart).      % homer is bart's father
kicked(itchy, scratchy).     % itchy kicked scratchy
stole(bart, donut, homer).   % bart stole the donut from homer

%
% These facts have exactly the same structure as the ones above, but they
% don't use suggestive names.
%
a(b).
c(b).
d(b, e).
f(g, h).
i(e, j, b).
