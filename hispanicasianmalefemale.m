filename = 'TrafficViolationsALL.csv';
data = readtable(filename,'PreserveVariableNames',true);

data = readtable(filename,'PreserveVariableNames',true);
% data cleaning. going to only count the two types of violations
all_entries = table2array(data(:,33));
to_remove = find(strcmp(all_entries,'ESERO'));
to_remove = [to_remove; find(strcmp(all_entries,'SERO'))];
data(to_remove,:) = []; 
all_entries = table2array(data(:,37));
to_remove = find(strcmp(all_entries,'WHITE'));
to_remove = [to_remove; find(strcmp(all_entries,'BLACK'))];
to_remove = [to_remove; find(strcmp(all_entries,'OTHER'))];
data(to_remove,:) = []; 
asian_men = data(find(strcmp(table2array(data(:,37)),'ASIAN') & strcmp(table2array(data(:,38)),'M')),33);
hispanic_female = data(find(strcmp(table2array(data(:,37)),'HISPANIC') & strcmp(table2array(data(:,38)),'F')),33);
asian_female = data(find(strcmp(table2array(data(:,37)),'ASIAN') & strcmp(table2array(data(:,38)),'F')),33);
[~,~,ic] = unique(hispanic_men); n_citations_hm = length(find(ic==1)); n_warnings_hm = length(find(ic==2));
[~,~,ic] = unique(asian_men); n_citations_am = length(find(ic==1)); n_warnings_am = length(find(ic==2));
[~,~,ic] = unique(hispanic_female); n_citations_hf = length(find(ic==1)); n_warnings_hf = length(find(ic==2));
[~,~,ic] = unique(asian_female); n_citations_af = length(find(ic==1)); n_warnings_af = length(find(ic==2));
pct_citations_hm = n_citations_hm / (n_citations_hm+n_warnings_hm);
pct_citations_am = n_citations_am / (n_citations_am+n_warnings_am);
pct_citations_hf = n_citations_hf / (n_citations_hf+n_warnings_hf);
pct_citations_af = n_citations_af / (n_citations_af+n_warnings_af);
figure;
bar([1 2 3 4], [pct_citations_hm pct_citations_am pct_citations_hf pct_citations_af])
xticks([1 2 3 4]); xticklabels({'hispanic male', 'asian male','hispanic female','asian female'})
title(['model beta: hispanic ' num2str(M_raceSex(2)) '  |||||   model beta: female ' num2str(M_raceSex(3))])

