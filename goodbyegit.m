filename ='Traffic_Violations100rows.csv';
datas = readtable(filename);
data = table2array(datas)

%first create the boolean columns for race, gender, and time
% RACE: for filename(:,37) (seperating the race column)
mask = ismember(data(:,37),['ASIAN'])
selected_data = (mask,:);%trying to just selected ASIAN but not sure 
filename.race_asian = data.race(race == 'ASIAN');
filename.race_black = data.race(race == 'BLACK');
filename.race_white = data.race(race == 'WHITE');
filename.race_hispanic = data.race(race == 'HISPANIC');
filename.race_other = data.race(race == 'OTHER');

%GENDER for filename(:,38) (seperating the gender column)
filename.gender_male = data.gender(gender == 'M');
filename.gender_female = data.gender(gender == 'F');

%TIME for filename(:,3) (seperating the time column)  
filename.time_day = data.time((time >= 7 && time <=19) == day);
filename.time_night = data.time((time < 7 && time >19) == night);

%CAR SEARCH
filename.search_yes = data.search(search == yes);
filename.search_no = data.search(search == no);

%seeing reelationships
data = data(~isnan(data.race),:);
data.search = categorical(data.cor);
predictor1 = data.race;
predictor2 = data.gender;
predictor3 = data.time;
predictor_vector = [predictor1, predictor2, predictor3];
[M, dec,stats] = mnrift(predictor_vector, data.search)

%% PLOTS!!

%race pullover : race search (normalization)
asian_controlled = sum(race == 'ASIAN') / sum(race == 'ASIAN' && car_searched == yes)  
black_controlled = sum(race == 'BLACK') / sum(race == 'BLACK' && car_searched == yes) 
white_controlled = sum(race == 'WHITE') /sum(race == 'WHITE' && car_searched == yes) 
hispanic_controlled = sum(race == 'HISPANIC') /sum(race == 'HISPANIC' && car_searched == yes) 
other_controlled = sum(race == 'OTHER') /sum(race == 'OTHER' && car_searched == yes) 

%do I need a race vector, to plot that alongside race controlled?
race_controlled = [asian_controlled,black_controlled,white_controlled,hispanic_controlled,other_controlled]

%make your figure:
h = figure
bar(race_controlled)
xlabel('Race')
ylabel('Car Searched')
title('Race as a Predictor for Car Searches (controlled for pullover rate')
%plotting the relationship between car searching and races