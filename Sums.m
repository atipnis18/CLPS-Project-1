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
disp(Traffic_Violations_Table);

%Sums of each race
sum_asian = sum(dummyrace_asian)
sum_black = sum(dummyrace_black)
sum_hispanic = sum(dummyrace_hispanic)
sum_white = sum(dummyrace_white)
sum_other = sum(dummyrace_other)

%bar graph of the number of each race that was pulled over 
h = figure
subplot(2,1,1)
x = [1:5];
y = [sum_asian, sum_black, sum_hispanic, sum_white, sum_other];
b = bar(x, y ,0.75);
b.FaceColor = '#FFB6C1'
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
disp(D_S);

%make dummy variables (Aisha, 3/21 5-5:30PM)
dummysex_female = D_S(:,1);
dummysex_male = D_S(:,2) ;
Traffic_Violations_Table = [Traffic_Violations_Table array2table(dummysex_male) array2table(dummysex_female)];
disp(Traffic_Violations_Table)

%sums for sex
sum_female = sum(dummysex_female);
sum_male = sum(dummysex_male);

%bar graph of the number of each race that was pulled over 
subplot(2,1,2)
x = [1:2];
y = [sum_female, sum_male];
g = bar(x, y ,0.75);
g.FaceColor = '#CBC3E3'
title('Sex Distribution of Cars Pulled Over');
xlabel('Sex');
ylabel('Number of Cars Pulled Over');
set(gca,'xticklabel',{'Female','Male'})






