filename = 'TrafficViolationsALL.csv';
data = readtable(filename,'PreserveVariableNames',true);

%% RACE DUMMY VARIABLES

%make dummy columns (Aisha, 3/21 2PM-4PM)
race_columns = data(:,37);
race_array = table2array(race_columns);
n_race_array = nominal(race_array);
D_R = dummyvar(n_race_array);

%make dummy variables (Aisha, 3/21 4PM-5PM)
dummyrace_asian = D_R(:,1);
dummyrace_black = D_R(:,2) ;
dummyrace_hispanic = D_R(:,3) ;
dummyrace_other = D_R(:,4) ;
dummyrace_white = D_R(:,5) ;
Traffic_Violations_Table = [data array2table(dummyrace_asian) array2table(dummyrace_black) array2table(dummyrace_hispanic) array2table(dummyrace_other) array2table(dummyrace_white) ];

%% SEX DUMMY VARIABLES

%make dummy columns (Aisha, 3/21 5-5:30PM)
sex_columns = data(:,38);
sex_array = table2array(sex_columns);
n_sex_array = nominal(sex_array);
D_S = dummyvar(n_sex_array);

%make dummy variables (Aisha, 3/21 5-5:30PM)
dummysex_female = D_S(:,1);
dummysex_male = D_S(:,2) ;
Traffic_Violations_Table = [Traffic_Violations_Table array2table(dummysex_male) array2table(dummysex_female)];

% %dummy citation v. warning
% citation_warning_columns = data(:,22);
% citation_warning_array = table2array(citation_warning_columns);
% n_citation_warning_array = nominal(citation_warning_array);
% D_CW = dummyvar(n_citation_warning_array);
% 
% %dummy search variables
% dummysearch_citation = D_CW(:,1);
% dummysearch_warning = D_CW(:,2) ;
% Traffic_Violations_Table = [Traffic_Violations_Table array2table(dummysearch_citation) array2table(dummysearch_warning)];


%% TIME DUMMY VARIABLES

%make dummy columns (Aisha, 3/22, 5:00-7:00PM)
time_columns = data(:,3);
time_array = table2array(time_columns);
time_array = hours(time_array);
time_array(time_array >= 7.0 & time_array <= 19.0) = 0;
time_array((time_array < 7.0 | time_array > 19.0) & time_array ~=0) = 1;
time_array = num2str(time_array);
n_time_array = nominal(time_array);
D_T = dummyvar(n_time_array);

%make dummy variables (Aisha, 3/22 7-7:30PM)
dummytime_daytime = D_T(:,1);
dummytime_nighttime = D_T(:,2) ;
Traffic_Violations_Table = [Traffic_Violations_Table array2table(dummytime_daytime) array2table(dummytime_nighttime)];


%dummy violation columns
violation_columns = data(:,33);
violation_array = table2array(violation_columns);
n_violation_array = nominal(violation_array);
D_V = dummyvar(n_violation_array);
%%dummy violation variable
dummyviolation_citation = D_V(:,1);
dummyviolation_warning = D_V(:,2);
dummyviolation_ESERO = D_V(:,3);
Traffic_Violations_Table = [data array2table(dummyviolation_citation) array2table(dummyviolation_warning) array2table(dummyviolation_ESERO)];



% %seeing reelationships
% data = data(~isnan('data.dummyrace_asian' ==0),:);
% data = data(~isnan('dummysearch_citation' ==0),:);
% data.dummysearch_citation = categorical(data.dummysearch_citation);
% predictor1 = data.(dummyrace_asian);
% predictor2 = data.(dummysearch_citation);
% predictor_vector = [predictor1 predictor2];
% [M, dec,stats] = mnrfit(predictor1, predictor2)

%RREDICTORS FOR RACE 
%data = data(any('dummyrace_asian'),:);
%data = data(any('dummysearch_citation'),:);
predictor1 = dummyrace_asian;
predictor2 = dummyrace_black;
predictor3 = dummyrace_white;
predictor4 = dummyrace_hispanic;
predictor5 = dummyrace_other;
dummyviolation_citation = categorical(dummyviolation_citation);
predictor_vector = [predictor1, predictor2, predictor3, predictor4];
[M_race, dec_race,stats_race] = mnrfit(predictor_vector, dummyviolation_citation)

%PREDICTORS FOR SEX (MALE)
predictor1 = dummysex_male;
predictor2 = dummysex_female;
dummyviolation_citation = categorical(dummyviolation_citation);
predictor_vector = [predictor1];
[M_sex, dec_sex,stats_sex] = mnrfit(predictor_vector, dummyviolation_citation)

%PREDICTORS FOR SEX (FEMALE)
predictor1 = dummysex_male;
predictor2 = dummysex_female;
dummyviolation_citation = categorical(dummyviolation_citation);
predictor_vector = [predictor2];
[M_sexf, dec_sexf,stats_sexf] = mnrfit(predictor_vector, dummyviolation_citation)

%PREDICTORS FOR TIME (NIGHT)
predictor1 = dummytime_nighttime;
predictor2 = dummytime_daytime;
dummyviolation_citation = categorical(dummyviolation_citation);
predictor_vector = [predictor1];
[M_night, dec_night,stats_night] = mnrfit(predictor_vector, dummyviolation_citation)

%PREDICTORS FOR TIME (DAY)
predictor1 = dummytime_nighttime;
predictor2 = dummytime_daytime;
dummyviolation_citation = categorical(dummyviolation_citation);
predictor_vector = [predictor2];
[M_day, dec_day,stats_day] = mnrfit(predictor_vector, dummyviolation_citation)


% %trying to see how asian predicts getting a citation but it did not work
% predictor1 = data.(dummyrace_asian);
% [M, dev,stats] = mnrfit(dummyrace_asian, dummysearch_citation, 'Model','hierarchical')
% [M, dev,stats] = mnrfit(dummyrace_black, dummysearch_citation, 'Model','hierarchical')
% [M, dev,stats] = mnrfit(dummyrace_white, dummysearch_citation, 'Model','hierarchical')
% [M, dev,stats] = mnrfit(dummyrace_hispanic, dummysearch_citation, 'Model','hierarchical')
% %[M, dev,stats] = mnrfit(dummyrace_other, dummysearch_citation, 'Model','hierarchical')

%another way we were trying with isabella
%load data
%const = ones(height(DataTable),1);
%DataTable = aadvars(DataTable, Const, Before = 1);
