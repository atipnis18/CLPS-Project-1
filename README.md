# CLPS-Project-1
Traffic Violation Bias

This project analyzes the bias which police hold and act upon in Montgomery County, Maryland. First, we show the bias in a police officer's decision to pull over a driver in the first place. This data finds that certain racial groups and certain genders were pulled over at disparate rates.
We also illustrate that intersections between racial identity, sex, and time of day influence the outcome (whether or not a driver recieves a citation or a warning) of a car pull-over. 
An interesting point to note is that racial categories and sex categories are assigned to individuals by the police officer -- for example, drivers labelled "Hispanic" are *racialized* as "Hispanic" by the police officer themselves. Given this example, drivers who are not visually profiled as "Hispanic" racially (despite Hispanic being an ethnic group) could still identify as Hispanic. Race, particularly, is not inherent to an individual, but *assigned*. 

Below you will find a distribution plot. At the top of each file for each plot you will find a description of the results of that section including the predictors that are being compared. Under the file “newpredictorsall.m” one can find the calculation of all of the M-values for various combinations of predictors. M-values were calculated using glmfit. They represent the level of predictability for each different predictor. The higher the M-value is, the more predictable an identity is to receiving a citation rather than a warning. In order to determine whether the predictability is significant, we used the command “stats.p.” First we created dummy columns in order to use our data in a quantitative way. We then used these dummy columns to compare data—specifically how predictable each identity/factor was when intersected. 



This plot displays 4 different subplots outlining the distribution thoughout the data set of each predictor including race, gender, time, and type of violation. To create these graphs we found the sum of each attribute for the predictors and placed them next to each other to see how they compare. (code for these graphs can be found under file sumsFULLdata.m)

<img width="542" alt="Screen Shot 2022-03-24 at 7 14 26 PM" src="https://user-images.githubusercontent.com/101379301/160025032-db7f186d-6963-45a3-9d28-3d507d8d9dee.png">


This plot shows the relationship between the indentities of a hispanic male, hispanic female, white male, and white female and how predictive these identities are on whether a citation was given or not. The graph shows that out of these identities hispanic males were the most predictive followed by hispanic females, white males, then white females. (code can be found under file hispanicwhitemalefemale.m)

<img width="537" alt="Screen Shot 2022-03-24 at 6 42 43 PM" src="https://user-images.githubusercontent.com/101379301/160024774-6fcd9d34-27e7-4fa6-9239-c77890dd4859.png">



This plot shows the relationship between the indentities of a black male, black female, asian male, and asian female and how predictive these identities are on whether a citation was given or not. The graph shows that out of these identities black male was the most predictive,then black female, then asian male, and lastly asian female (code can be found under file blackasianmalefemale.m)

<img width="545" alt="Screen Shot 2022-03-24 at 6 49 55 PM" src="https://user-images.githubusercontent.com/101379301/160024794-a99682f6-1e2f-4143-82e3-a5cd9d0b84dc.png">



This plot shows the relationship between the indentities of a black male, black female, hispanic male, and hispanic female and how predictive these identities are on whether a citation was given or not. The graph shows that out of these identities hispanic males were the most predictive of a citation followed by black males, hispanic women, and lastly black women (code can be found under file blackhispanicmalefemale.m)

<img width="550" alt="Screen Shot 2022-03-24 at 7 00 21 PM" src="https://user-images.githubusercontent.com/101379301/160024796-82eed242-813f-46b4-ae25-d9e32323f903.png">


This plot shows the relationship between the indentities of a hispanic male, hispanic female, asian male, and asian female and how predictive these identities are on whether a citation was given or not. The graph shows that out of these identities hispanic males were the most predictive followed by hispanic females, then asian males, then asian females. (code can be found under file hispanicasianmalefemale.m)

<img width="558" alt="Screen Shot 2022-03-24 at 7 05 58 PM" src="https://user-images.githubusercontent.com/101379301/160024800-cdbfb8d4-1698-42d1-b2fa-42931cbeec11.png">



This plot shows the relationship between the indentities of a black male, black female, white male, and white female and how predictive these identities are on whether a citation was given or not. The graph shows that out of these identities black male is the most predictive, then a black female, then a white male, and the least is a white female (code can be found under file Haleyplotting.m).

<img width="554" alt="Screen Shot 2022-03-24 at 6 23 15 PM" src="https://user-images.githubusercontent.com/101379301/160024801-c549385d-05b6-48d7-90b5-db3a46e79b47.png">


This plot shows the relationship between the indentities of a asian male, asian female, white male, and white female and how predictive these identities are on whether a citation was given or not. The graph shows that out of these identities white and asian males are the best predictors(with white males being slightly better), and white and asian females falling slightly below. (code can be found under file asianwhitemalefemale.m)

<img width="549" alt="Screen Shot 2022-03-24 at 6 30 47 PM" src="https://user-images.githubusercontent.com/101379301/160024805-57e7ba16-5449-4dac-868e-3b4e2ad11ddb.png">

Logistic notes:
– We are including an image of the distribution of our hours.
– Ariana: My github was not working even late in the process. For the sake of time, we decided to focus on just writing the code rather than attempting to get github to work for me. I would use the code that I could view being pushed on the browser and write my code in matlab. I would then email the code to either Camila or Aisha so that they could run it and push it. 

![Screen Shot 2022-03-24 at 7 49 50 PM](https://user-images.githubusercontent.com/101745330/160028364-b5feb074-970f-4a10-a462-fa37c6f87be6.png)
