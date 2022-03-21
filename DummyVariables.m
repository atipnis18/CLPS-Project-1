%Purpose of code:
%   1. call dataset 
%   2. create boolean columns for race, sex, and time
%   3. Add these to the table: "Traffic_Violations_Table"

filename = 'Traffic_Violations100rows.csv';
data = readtable(filename,'PreserveVariableNames',true);

%% RACE DUMMY VARIABLES

%make dummy columns (Aisha, 3/21 2PM-4PM)
race_columns = data(:,37);
race_array = table2array(race_columns);
n_race_array = nominal(race_array);
D_R = dummyvar(n_race_array);
disp(D_R);

%make dummy variables (Aisha, 3/21 4PM-5PM)
dummyrace_asian = D_R(:,1);
dummyrace_black = D_R(:,2) ;
dummyrace_hispanic = D_R(:,3) ;
dummyrace_other = D_R(:,4) ;
dummyrace_white = D_R(:,5) ;
Traffic_Violations_Table = [data array2table(dummyrace_asian) array2table(dummyrace_black) array2table(dummyrace_hispanic) array2table(dummyrace_other) array2table(dummyrace_white) ];
disp(Traffic_Violations_Table)

%% SEX DUMMY VARIABLES

%make dummy columns (Aisha, 3/21 5-5:30PM)
sex_columns = data(:,38);
sex_array = table2array(sex_columns);
n_sex_array = nominal(sex_array);
D_S = dummyvar(n_sex_array);
disp(D_S);

%make dummy variables (Aisha, 3/21 5-5:30PM)
dummysex_female = D_S(:,1);
dummysex_male = D_S(:,2) ;
Traffic_Violations_Table = [Traffic_Violations_Table array2table(dummysex_male) array2table(dummysex_female)];
disp(Traffic_Violations_Table)

