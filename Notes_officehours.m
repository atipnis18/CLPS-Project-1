%fid = fopen('Traffic Violations (first 100 rows', 'w')
A = rand(100)
dlmwrite('Traffic Violations (first 100 rows).txt', A)

first value in vector is the b term, the bias!!
p value -- is it just random? is it so close to 0 that we should get rid of it?
struct --> multiple values 

filename = 'subject1_data.csv';
data = readtable(filename);
data = data(~isnan(data.rt),:);
performance = categorical(data.cor);
predictor1 = data.rt;
predictor2 = data.trial_type;
predictor_vector = [predictor1, predictor2];
[M, dev, stats] = mnrfit(predictor_vector, performance)

stats.p --> 3 values, if it's less than .05 it's meaningful, greater? not meaningful

    depends on the model
    if you only put in one thing, it might accidentrally think that its predictive. when u add the predictive variable, then it's not statistically significant
        prediction based on categorical variables, things that aren't numbers