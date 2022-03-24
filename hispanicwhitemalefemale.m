filename = 'TrafficViolationsALL.csv';
data = readtable(filename,'PreserveVariableNames',true);

% data cleaning. going to only count the two types of violations
all_entries = table2array(data(:,33));
to_remove = find(strcmp(all_entries,'ESERO'));
to_remove = [to_remove; find(strcmp(all_entries,'SERO'))];
data(to_remove,:) = []; 
all_entries = table2array(data(:,37));
to_remove = find(strcmp(all_entries,'ASIAN'));
to_remove = [to_remove; find(strcmp(all_entries,'BLACK'))];
to_remove = [to_remove; find(strcmp(all_entries,'NATIVE AMERICAN'))];
to_remove = [to_remove; find(strcmp(all_entries,'OTHER'))];
data(to_remove,:) = []; % drop these rows, now just hispanic/white
all_entries = table2array(data(:,38));
to_remove = find(strcmp(all_entries,'U'));
data(to_remove,:) = []; % drop these rows, now just hispanic/white
% RACE DUMMY VARIABLES
race_columns = data(:,37);
race_array = table2array(race_columns);
n_race_array = nominal(race_array);
D_R = dummyvar(n_race_array);
dummyrace_hispanic = D_R(:,1);
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
[M_raceHSex,dev,stats] = glmfit([dummyrace_hispanic dummysex_female], D_V(:,1),'binomial','link','logit');
% does this match a simple look at the data?
% this code is all just for plotting. 
hispanic_men = data(find(strcmp(table2array(data(:,37)),'HISPANIC') & strcmp(table2array(data(:,38)),'M')),33);
white_men = data(find(strcmp(table2array(data(:,37)),'WHITE') & strcmp(table2array(data(:,38)),'M')),33);
hispanic_female = data(find(strcmp(table2array(data(:,37)),'HISPANIC') & strcmp(table2array(data(:,38)),'F')),33);
white_female = data(find(strcmp(table2array(data(:,37)),'WHITE') & strcmp(table2array(data(:,38)),'F')),33);
[~,~,ic] = unique(hispanic_men); n_citations_hm = length(find(ic==1)); n_warnings_hm = length(find(ic==2));
[~,~,ic] = unique(white_men); n_citations_wm = length(find(ic==1)); n_warnings_wm = length(find(ic==2));
[~,~,ic] = unique(hispanic_female); n_citations_hf = length(find(ic==1)); n_warnings_hf = length(find(ic==2));
[~,~,ic] = unique(white_female); n_citations_wf = length(find(ic==1)); n_warnings_wf = length(find(ic==2));
pct_citations_hm = n_citations_hm / (n_citations_hm+n_warnings_hm);
pct_citations_wm = n_citations_wm / (n_citations_wm+n_warnings_wm);
pct_citations_hf = n_citations_hf / (n_citations_hf+n_warnings_hf);
pct_citations_wf = n_citations_wf / (n_citations_wf+n_warnings_wf);
figure
bar([1 2 3 4], [pct_citations_hm pct_citations_wm pct_citations_hf pct_citations_wf])
xticks([1 2 3 4]); xticklabels({'hispanic male', 'white male','hispanic female','white female'})
%title(['model beta: hispanic ' num2str(M_raceSex(2)) '  |||||   model beta: female ' num2str(M_raceSex(3))])
title('Hispanic vs. White in Regards to Sex Predictability');
xlabel('Identities');
ylabel('Predictability');
