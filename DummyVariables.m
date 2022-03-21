%Purpose of code:
%   1. call dataset 
%   2. create boolean columns for race, gender, and time
%   3. Add these to the table: "Traffic_Violations_Table"

filename = 'Traffic_Violations100rows.csv';
data = readtable(filename,'PreserveVariableNames',true);

%% RACE DUMMY VARIABLES

%make dummy columns (Aisha, 3/21 2PM-4PM)
race_columns = data(:,37);
race_array = table2array(race_columns);
race_array_vertical = categorical(race_array);
n_race_array = nominal(race_array);
D = dummyvar(n_race_array);
disp(D);

%make dummy variables (Aisha, 3/21 4PM-5PM)
dummyrace_asian = D(:,1);
dummyrace_black = D(:,2) ;
dummyrace_hispanic = D(:,3) ;
dummyrace_other = D(:,4) ;
dummyrace_white = D(:,5) ;
Traffic_Violations_Table = [data array2table(dummyrace_asian) array2table(dummyrace_black) array2table(dummyrace_hispanic) array2table(dummyrace_other) array2table(dummyrace_white) ];
disp(Traffic_Violations_Table)