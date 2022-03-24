filename = 'TrafficViolationsALL.csv';
data = readtable(filename,'PreserveVariableNames',true);

%% RACE DUMMY VARIABLES

%make dummy columns 
race_columns = data(:,37);
race_array = table2array(race_columns);
n_race_array = nominal(race_array);
D_R = dummyvar(n_race_array);

%make dummy variables 
dummyrace_asian = D_R(:,1);
dummyrace_black = D_R(:,2) ;
dummyrace_hispanic = D_R(:,3) ;
dummyrace_other = D_R(:,4) ;
dummyrace_white = D_R(:,5) ;
Traffic_Violations_Table = [data array2table(dummyrace_asian) array2table(dummyrace_black) array2table(dummyrace_hispanic) array2table(dummyrace_other) array2table(dummyrace_white) ];

%% SEX DUMMY VARIABLES

%make dummy columns 
sex_columns = data(:,38);
sex_array = table2array(sex_columns);
n_sex_array = nominal(sex_array);
D_S = dummyvar(n_sex_array);

%make dummy variables 
dummysex_female = D_S(:,1);
dummysex_male = D_S(:,2) ;
Traffic_Violations_Table = [Traffic_Violations_Table array2table(dummysex_male) array2table(dummysex_female)];



%% TIME DUMMY VARIABLES

%make dummy columns 
time_columns = data(:,3);
time_array = table2array(time_columns);
time_array = hours(time_array);
time_array(time_array >= 7.0 & time_array <= 19.0) = 0;
time_array((time_array < 7.0 | time_array > 19.0) & time_array ~=0) = 1;
time_array = num2str(time_array);
n_time_array = nominal(time_array);
D_T = dummyvar(n_time_array);

%make dummy variables 
dummytime_daytime = D_T(:,1);
dummytime_nighttime = D_T(:,2) ;
Traffic_Violations_Table = [Traffic_Violations_Table array2table(dummytime_daytime) array2table(dummytime_nighttime)];


%% VIOLATION DUMMY VARIABLES
violation_columns = data(:,33);
violation_array = table2array(violation_columns);
n_violation_array = nominal(violation_array);
D_V = dummyvar(n_violation_array);
%%dummy violation variable
dummyviolation_citation = D_V(:,1);
dummyviolation_warning = D_V(:,2);
dummyviolation_ESERO = D_V(:,3);
Traffic_Violations_Table = [data array2table(dummyviolation_citation) array2table(dummyviolation_warning) array2table(dummyviolation_ESERO)];


%RREDICTORS FOR RACE 
predictor1 = dummyrace_asian;
predictor2 = dummyrace_black;
predictor3 = dummyrace_white;
predictor4 = dummyrace_hispanic;
predictor5 = dummyrace_other;
dummyviolation_citation = categorical(dummyviolation_citation);
predictor_vector = [predictor1, predictor2, predictor3, predictor4];
[M_race, dev_race,stats_race] = glmfit(predictor_vector, D_V(:,1),'binomial','link','logit')

%PREDICTORS FOR SEX (MALE)
predictor1 = dummysex_male;
predictor2 = dummysex_female;
predictor_vector = [predictor1];
[M_sex, dec_sex,stats_sex] = glmfit(predictor_vector, D_V(:,1),'binomial','link','logit')

%PREDICTORS FOR SEX (FEMALE)
predictor1 = dummysex_male;
predictor2 = dummysex_female;
predictor_vector = [predictor2];
[M_sexf, dec_sexf,stats_sexf] = glmfit(predictor_vector, D_V(:,1),'binomial','link','logit')

%PREDICTORS FOR TIME (NIGHT)
predictor1 = dummytime_nighttime;
predictor2 = dummytime_daytime;
predictor_vector = [predictor1];
[M_night, dec_night,stats_night] = glmfit(predictor_vector, D_V(:,1),'binomial','link','logit')

%PREDICTORS FOR TIME (DAY)
predictor1 = dummytime_nighttime;
predictor2 = dummytime_daytime;
predictor_vector = [predictor2];
[M_day, dec_day,stats_day] = glmfit(predictor_vector, D_V(:,1),'binomial','link','logit')

%COMBINING DIFFERENT PREDICTORS:

%RACE AND TIME:
%PREDICTORS FOR ASIAN AND TIME(DAY) ON CITATIONS
predictor1 = dummyrace_asian;
predictor2 = dummytime_daytime;
predictor3 = dummytime_nighttime;
predictor_vector = [predictor1, predictor2];
[M_asday, dec_asday,stats_asday] = glmfit(predictor_vector, D_V(:,1),'binomial','link','logit')

%RREDICTORS FOR BLACK AND TIME(DAY) ON CITATIONS
predictor1 = dummyrace_black;
predictor2 = dummytime_daytime;
predictor3 = dummytime_nighttime;
predictor_vector = [predictor1, predictor2];
[M_blday, dec_blday,stats_blday] = glmfit(predictor_vector, D_V(:,1),'binomial','link','logit')

%RREDICTORS FOR WHITE AND TIME(DAY) ON CITATIONS
predictor1 = dummyrace_white;
predictor2 = dummytime_daytime;
predictor3 = dummytime_nighttime;
predictor_vector = [predictor1, predictor2];
[M_whday, dec_whday,stats_whday] = glmfit(predictor_vector, D_V(:,1),'binomial','link','logit')

%RREDICTORS FOR HISPANIC AND TIME(DAY) ON CITATIONS
predictor1 = dummyrace_hispanic;
predictor2 = dummytime_daytime;
predictor3 = dummytime_nighttime;
predictor_vector = [predictor1, predictor2];
[M_hispday, dec_hispday,stats_hispday] = glmfit(predictor_vector, D_V(:,1),'binomial','link','logit')

%RACE AND GENDER
%PREDICTORS FOR ASIAN AND MALE ON CITATIONS
predictor1 = dummyrace_asian;
predictor2 = dummysex_male;
predictor3 = dummysex_female;
predictor_vector = [predictor1, predictor2];
[M_asmale, dec_asmale,stats_asmale] = glmfit(predictor_vector, D_V(:,1),'binomial','link','logit')

%PREDICTORS FOR BLACK AND MALE ON CITATIONS
predictor1 = dummyrace_black;
predictor2 = dummysex_male;
predictor3 = dummysex_female;
predictor_vector = [predictor1, predictor2];
[M_blmale, dec_blmale,stats_blmale] = glmfit(predictor_vector, D_V(:,1),'binomial','link','logit')

%PREDICTORS FOR WHITE AND MALE ON CITATIONS
predictor1 = dummyrace_white;
predictor2 = dummysex_male;
predictor3 = dummysex_female;
predictor_vector = [predictor1, predictor2];
[M_wmale, dec_wmale,stats_wmale] = glmfit(predictor_vector, D_V(:,1),'binomial','link','logit')

%PREDICTORS FOR HISPANIC AND MALE ON CITATIONS
predictor1 = dummyrace_hispanic;
predictor2 = dummysex_male;
predictor3 = dummysex_female;
predictor_vector = [predictor1, predictor2];
[M_hispmale, dec_hispmale,stats_hispmale] = glmfit(predictor_vector, D_V(:,1),'binomial','link','logit')

%SEX and TIME
[M_sexTime,dev_sexTime,stats_sexTime] = glmfit([dummytime_daytime dummysex_male], D_T(:,1),'binomial','link','logit');
%% --> found that gender and time don't have a significant relationship