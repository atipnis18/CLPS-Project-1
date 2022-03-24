filename = 'TrafficViolationsALL.csv';
data = readtable(filename,'PreserveVariableNames',true);

% cleaning the data
all_entries = table2array(data(:,33));
to_remove = find(strcmp(all_entries,'ESERO'));
to_remove = [to_remove; find(strcmp(all_entries,'SERO'))];
data(to_remove,:) = []; % deleting ESERO and SERO rows
% simplify to check our math so we can do a visual check -- you should take
% this out once you validate, and add back in the other columns.
% you can run unique(n_race_array) to see the order of the variables in
% n_race_array, for example. will generally be alphabetical.
all_entries = table2array(data(:,37));
to_remove = find(strcmp(all_entries,'ASIAN'));
to_remove = [to_remove; find(strcmp(all_entries,'HISPANIC'))];
to_remove = [to_remove; find(strcmp(all_entries,'NATIVE AMERICAN'))];
to_remove = [to_remove; find(strcmp(all_entries,'OTHER'))];
data(to_remove,:) = []; % drop these rows, now just black/white
all_entries = table2array(data(:,38));
to_remove = find(strcmp(all_entries,'U'));
data(to_remove,:) = []; % drop these rows, now just black/white

% RACE DUMMY VARIABLES
race_columns = data(:,37);
race_array = table2array(race_columns);
n_race_array = nominal(race_array);
D_R = dummyvar(n_race_array);
dummyrace_black = D_R(:,1);

% SEX DUMMY VARIABLES
sex_columns = data(:,38);
sex_array = table2array(sex_columns);
n_sex_array = nominal(sex_array);
D_S = dummyvar(n_sex_array);
dummysex_female = D_S(:,1);

% to predict
violation_columns = data(:,33);
violation_array = table2array(violation_columns);
n_violation_array = nominal(violation_array);
D_V = dummyvar(n_violation_array);
% for this you won't need the categorical for the predictor.
% dummyviolation_citation = categorical(D_V(:,1));

[M_raceSex,dev,stats] = glmfit([dummyrace_black dummysex_female], D_V(:,1),'binomial','link','logit');
% does this match a simple look at the data?
% this code is all just for plotting. 
black_men = data(find(strcmp(table2array(data(:,37)),'BLACK') & strcmp(table2array(data(:,38)),'M')),33);
white_men = data(find(strcmp(table2array(data(:,37)),'WHITE') & strcmp(table2array(data(:,38)),'M')),33);
black_female = data(find(strcmp(table2array(data(:,37)),'BLACK') & strcmp(table2array(data(:,38)),'F')),33);
white_female = data(find(strcmp(table2array(data(:,37)),'WHITE') & strcmp(table2array(data(:,38)),'F')),33);
[~,~,ic] = unique(black_men); n_citations_bm = length(find(ic==1)); n_warnings_bm = length(find(ic==2));
[~,~,ic] = unique(white_men); n_citations_wm = length(find(ic==1)); n_warnings_wm = length(find(ic==2));
[~,~,ic] = unique(black_female); n_citations_bf = length(find(ic==1)); n_warnings_bf = length(find(ic==2));
[~,~,ic] = unique(white_female); n_citations_wf = length(find(ic==1)); n_warnings_wf = length(find(ic==2));
pct_citations_bm = n_citations_bm / (n_citations_bm+n_warnings_bm);
pct_citations_wm = n_citations_wm / (n_citations_wm+n_warnings_wm);
pct_citations_bf = n_citations_bf / (n_citations_bf+n_warnings_bf);
pct_citations_wf = n_citations_wf / (n_citations_wf+n_warnings_wf);
figure;
bar([1 2 3 4], [pct_citations_bm pct_citations_wm pct_citations_bf pct_citations_wf])
xticks([1 2 3 4]); xticklabels({'black male', 'white male','black female','white female'})
title(['model beta: black ' num2str(M_raceSex(2)) '  |||||   model beta: female ' num2str(M_raceSex(3))])
