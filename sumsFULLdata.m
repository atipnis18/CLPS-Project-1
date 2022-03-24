filename = 'TrafficViolationsALL.csv';
data = readtable(filename,'PreserveVariableNames',true);

%this file uses the dummy columns to find sums of each identity. These sums
%are then placed next to each other to be compared.

%% RACE DUMMY VARIABLES

%make dummy columns (Aisha, 3/21 2PM-4PM)
race_columns = data(:,37);
race_array = table2array(race_columns);
race_array_vertical = categorical(race_array);
n_race_array = nominal(race_array);
D = dummyvar(n_race_array);

%make dummy variables (Aisha, 3/21 4PM-5PM)
dummyrace_asian = D(:,1);
dummyrace_black = D(:,2) ;
dummyrace_hispanic = D(:,3) ;
dummyrace_other = D(:,4) ;
dummyrace_white = D(:,5) ;
Traffic_Violations_Table = [data array2table(dummyrace_asian) array2table(dummyrace_black) array2table(dummyrace_hispanic) array2table(dummyrace_other) array2table(dummyrace_white) ];


%Sums of each race
sum_asian = sum(dummyrace_asian);
sum_black = sum(dummyrace_black);
sum_hispanic = sum(dummyrace_hispanic);
sum_white = sum(dummyrace_white);
sum_other = sum(dummyrace_other);

%bar graph of the number of each race that was pulled over 
h = figure;
subplot(2,2,1)
x = 1:5;
y = [sum_asian, sum_black, sum_hispanic, sum_white, sum_other];
b = bar(x, y ,0.75);
b.FaceColor = '#FFB6C1';
title('Race Distribution of Cars Pulled Over');
xlabel('Races');
ylabel('Number of Cars Pulled Over');
set(gca,'xticklabel',{'Asian','Black','White','Hispanic','Other'})

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


%sums for sex
sum_female = sum(dummysex_female);
sum_male = sum(dummysex_male);

%bar graph of the number of each sex that was pulled over 
subplot(2,2,2)
x = 1:2;
y = [sum_female, sum_male];
g = bar(x, y ,0.75);
g.FaceColor = '#CBC3E3';
title('Sex Distribution of Cars Pulled Over');
xlabel('Sex');
ylabel('Number of Cars Pulled Over');
set(gca,'xticklabel',{'Female','Male'}) 

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


%sums for time
sum_daytime = sum(dummytime_daytime);
sum_nighttime = sum(dummytime_nighttime);

%bar graph of the number of times car was pulled over during day and night time
subplot(2,2,3)
x = 1:2;
y = [sum_daytime, sum_nighttime];
f = bar(x,y,.75);
f.FaceColor = '#003366';
title('Distribution of Time')
xlabel('Time')
ylabel('Number of People Stopped')
set(gca,'xticklabel',{'Day','Night'})


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

%sums violations
sum_citations = sum(dummyviolation_citation);
sum_warnings = sum(dummyviolation_warning);
sum_ESERO = sum(dummyviolation_ESERO);

%bar graph of violations citations vs warnings
subplot(2,2,4)
x = 1:3;
y = [sum_citations, sum_warnings, sum_ESERO];
l = bar(x,y,.75);
l.FaceColor = '#ed872d';
title('Citation vs. Warning vs. ESERO Violations');
xlabel('Violations');
ylabel('Number of Cars');
set(gca,'xticklabel',{'Citation','Warning', 'ESERO'})




