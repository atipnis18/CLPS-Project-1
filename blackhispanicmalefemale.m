filename = 'TrafficViolationsALL.csv';
data = readtable(filename,'PreserveVariableNames',true);

%Ariana: This plot shows the relationship between the indentities of a
%black male, black female, hispanic male, and hispanic female and how predictive
%these identities are on whether a citation was given or not. The graph
%shows that out of these identities hispanic males were the most predictive
%of a citation followed by black males, hispanic women, and lastly black
%women


% data cleaning. going to only count the two types of violations
all_entries = table2array(data(:,33));
to_remove = find(strcmp(all_entries,'ESERO'));
to_remove = [to_remove; find(strcmp(all_entries,'SERO'))];
data(to_remove,:) = []; 
all_entries = table2array(data(:,37));
to_remove = find(strcmp(all_entries,'WHITE'));
to_remove = [to_remove; find(strcmp(all_entries,'ASIAN'))];
to_remove = [to_remove; find(strcmp(all_entries,'OTHER'))];
data(to_remove,:) = []; 
black_men = data(find(strcmp(table2array(data(:,37)),'BLACK') & strcmp(table2array(data(:,38)),'M')),33);
hispanic_female = data(find(strcmp(table2array(data(:,37)),'HISPANIC') & strcmp(table2array(data(:,38)),'F')),33);
black_female = data(find(strcmp(table2array(data(:,37)),'BLACK') & strcmp(table2array(data(:,38)),'F')),33);
[~,~,ic] = unique(hispanic_men); n_citations_hm = length(find(ic==1)); n_warnings_hm = length(find(ic==2));
[~,~,ic] = unique(black_men); n_citations_bm = length(find(ic==1)); n_warnings_bm = length(find(ic==2));
[~,~,ic] = unique(hispanic_female); n_citations_hf = length(find(ic==1)); n_warnings_hf = length(find(ic==2));
[~,~,ic] = unique(black_female); n_citations_bf = length(find(ic==1)); n_warnings_bf = length(find(ic==2));
pct_citations_hm = n_citations_hm / (n_citations_hm+n_warnings_hm);
pct_citations_bm = n_citations_bm / (n_citations_bm+n_warnings_bm);
pct_citations_hf = n_citations_hf / (n_citations_hf+n_warnings_hf);
pct_citations_bf = n_citations_bf / (n_citations_bf+n_warnings_bf);
figure;
bar([1 2 3 4], [pct_citations_hm pct_citations_bm pct_citations_hf pct_citations_bf])
xticks([1 2 3 4]); xticklabels({'hispanic male', 'black male','hispanic female','black female'})
title('Black vs. Hispanic in Regards to Sex Predictability');
xlabel('Identities');
ylabel('Predictability');