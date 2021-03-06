filename = 'TrafficViolationsALL.csv';
data = readtable(filename,'PreserveVariableNames',true);

%Camila: This plot shows the relationship between the indentities of a
%black male, black female, asian male, and asian female and how predictive
%these identities are on whether a citation was given or not. The graph
%shows that out of these identities black male was the most predictive,
%then black female, then asian male, and lastly asian female

% cleaning the data
all_entries = table2array(data(:,33));
to_remove = find(strcmp(all_entries,'ESERO'));
to_remove = [to_remove; find(strcmp(all_entries,'SERO'))];
data(to_remove,:) = []; % deleting ESERO and SERO rows

all_entries = table2array(data(:,37));
to_remove = find(strcmp(all_entries,'WHITE'));
to_remove = [to_remove; find(strcmp(all_entries,'HISPANIC'))];
to_remove = [to_remove; find(strcmp(all_entries,'NATIVE AMERICAN'))];
to_remove = [to_remove; find(strcmp(all_entries,'OTHER'))];
data(to_remove,:) = []; 
all_entries = table2array(data(:,38));
to_remove = find(strcmp(all_entries,'U'));
data(to_remove,:) = []; 

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

[M_raceSex,dev,stats] = glmfit([dummyrace_black dummysex_female], D_V(:,1),'binomial','link','logit');

% this code is all just for plotting. 
black_men = data(find(strcmp(table2array(data(:,37)),'BLACK') & strcmp(table2array(data(:,38)),'M')),33);
asian_men = data(find(strcmp(table2array(data(:,37)),'ASIAN') & strcmp(table2array(data(:,38)),'M')),33);
black_female = data(find(strcmp(table2array(data(:,37)),'BLACK') & strcmp(table2array(data(:,38)),'F')),33);
asian_female = data(find(strcmp(table2array(data(:,37)),'ASIAN') & strcmp(table2array(data(:,38)),'F')),33);
[~,~,ic] = unique(black_men); n_citations_bm = length(find(ic==1)); n_warnings_bm = length(find(ic==2));
[~,~,ic] = unique(asian_men); n_citations_am = length(find(ic==1)); n_warnings_am = length(find(ic==2));
[~,~,ic] = unique(black_female); n_citations_bf = length(find(ic==1)); n_warnings_bf = length(find(ic==2));
[~,~,ic] = unique(asian_female); n_citations_af = length(find(ic==1)); n_warnings_af = length(find(ic==2));
pct_citations_bm = n_citations_bm / (n_citations_bm+n_warnings_bm);
pct_citations_am = n_citations_am / (n_citations_am+n_warnings_am);
pct_citations_bf = n_citations_bf / (n_citations_bf+n_warnings_bf);
pct_citations_af = n_citations_af / (n_citations_af+n_warnings_af);
figure;
bar([1 2 3 4], [pct_citations_bm pct_citations_wm pct_citations_bf pct_citations_wf])
xticks([1 2 3 4]); xticklabels({'black male', 'asian male','black female','asian female'})
title('Black vs. Asian in Regards to Sex Predictability');
xlabel('Identities');
ylabel('Predictability');
