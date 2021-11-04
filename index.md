# Portfolio

---

### Anaheim Ducks Capstone Project

**Project overview:** As a part of the UCI MSBA program, students are required to complete a six month long capstone project with a local OC company. I was fortunate enough to be paired with the Anaheim Ducks Hockey Club along with four other students. The purpose of the project was to answer three questions:
• Who are Ducks customers?
• What drives the buying behaviors of Ducks customers?
• Is there any synergy between Ducks customers and customers within the H&S Ventures (the parent company) portfolio?

With the use of recency frequency monetization (RFM) scoring, we were able to identify a potential target customer segmentation that had not been specifically marketed to previously. To showcase these segments, we created a Tableau dashboard to display their demographics. Next, we used survival analysis to investigate drivers towards Ducks ticket sales and the effectiveness of various marketing methonds. Our findings opened discussions towards a shift in marketing strategy from previous approaches. Lastly, we observed that Ducks customers prefer certain types of activities in the H&S portfolio. Our recommendation was to potentially increase the availability of these activities to attract more Ducks customers.

Specifics and files are not shared for confidentiality purposes.

<img src="images/ducks_img.png?raw=true"/>

**Improvements:** From our analysis, we cannot say what is a cause and what is an effect; more specifically for the survival analysis piece of the project. The next step would be to set upa randomized experiment to draw more conclusive findings regarding the effectiveness of various marketing methods.

***Technical skills:*** Survival analysis, RFM scoring, clustering, multivariate regression, SVM, KNN, decision tree, random forest

***Tools:*** R, SQL, Tableau

***Team:*** Salem Arthur, Eric Chen, Edward Shih-Chung, Marianna Carini

---

### Spotify Network Analysis

**Project overview:** For this social analytics project, my team and I wanted to analyze the networks of popular musicians to identify any common themes. Our goal was to predict which songs will be popular based on the various audio features and the respective artist's network structure. We used Spotify's extensive API to gather our data. We defined a popular artist to be any artist with one or more songs with a popularity rating of 70 or more. We defined a connection to be when two artists collaborate on a song together. 

From our analysis we discovered three main insights. With the use of clustering we observed there are two distinct genres of popular songs, upbeat/party songs and slow-paced/serious songs. After constructing the network, we observed there are statistically significant differences in the closeness and betweenness of the popular artist network compared to the non-popular artist network. The popular artist community is a smaller circle (higher closeness) and is less likely to broker relationships different artists together (lower betweennesss). Lastly, we observed the network of an artist strongly impacts the success of their songs. From a basic regression model using only a song's profile, we observed an R-squared of 0.238. When we included the average of the neighbors' network values the R-squared increased to 0.651; thus showing the value of one's network is linked with their popularity.

<img src="images/spotify_img.png?raw=true"/>
<img src="images/spotify_img2.png?raw=true"/>
<img src="images/spotify_img3.png?raw=true"/>

***Technical skills:*** Network analysis, social analytics, regression, k-means clustering, API

***Tools:*** R, igraph

***Team:*** Salem Arthur, Eric Chen, Edward Shih-Chung, Marianna Carini


[![Open Code](https://img.shields.io/badge/R-Open_Files-red?logo=R)](/spotify_network_analysis/)
[![Open Slides](https://img.shields.io/badge/PPT-View_Slides-red?logo=microsoftpowerpoint)](docs/Spotify_Network_Pres.ppt)
[![Open Report](https://img.shields.io/badge/PDF-View_Report-red?logo=MicrosoftWord)](docs/Spotify_Network_Report.docx)

---

### Nursing Home COVID-19 Risk Assessment

**Project overview:** On the heels of the COVID-19 vaccine approvals for Pfizer and BioNTech, our team utilized our machine learning technics to protect the populations hardest hit by outbreaks, senior living facilities. We wanted to understand driving factors of COVID mortality and how best to distribute vaccines to senior citizens. We combined nursing home staff stats, nursing home supply stats, county census stats, and county COVID policy data to find trends with COVID mortality rates. Our group turned to k-means clustering to group like senior living facilities based on the mortality rates of COVID-19 at the time of analysis. Our clustering analysis came out with three distinct groups, deemed high, medium, and low impact. 

We observed that the medium impact group experienced the highest amount of staffing and supply shortages, but did not experience the highest mortality rates. Our data showed a higher percentage of the medium impact facilities were in areas implimenting shelter-in-place and mask policies versus the other two clusters. The variance in the remaining policies was neglegible between clusters. Conversly, the cluster with the highest mortality rates experienced similar shortages as the cluster with the lowest mortality rate. The highest mortaility cluster was a more densly populated cluster, had the largest population of 65+, and had the highest population of civilians without health insurance.

From our analysis, we recommended sending the vaccines first to the high impact cluster because of their high mortality rates and high at-risk population. Next would be the medium impact cluster due to their shortage of supplies. Lastly would be the low impact cluster because of their low mortality rate. Once a plan was developed, communicating that plan would be key to avoiding the same issues we saw with the H1N1 vaccine distribution.

<img src="images/covid_nursing_home_img2.png?raw=true"/>
<img src="images/covid_nursing_home_img3.png?raw=true"/>

***Technical skills:*** K-Means Clustering, API

***Tools:*** Python

***Team:*** Eric Chen, Allen Lee, Hyoungmin (Stella) Lee, Smitha Kannanaikkal, Marianna Carini


[![Open Code](https://img.shields.io/badge/Jupyter-Open_Files-red?logo=Jupyter)](/H1N1_pred/)
[![Open Slides](https://img.shields.io/badge/PPT-View_Slides-red?logo=microsoftpowerpoint)](docs/COVID_Nursing_Home.pdf)
[![Open Report](https://img.shields.io/badge/PDF-View_Report-red?logo=MicrosoftWord)](docs/COVID_Nursing_Home_Report.pdf)

---

### H1N1 Vaccine Demand Prediction

**Project overview:** At the time of this project, the Pfizer and BioNTech vaccines were recently approved for distribution. Our team wanted to study the H1N1 vaccine data to ultimately gain insight into the demand for COVID-19 vaccines. Our dataset was provided by the National Center for Immunization and Respiratory Disease as a apart of a DrivenData competition. The data detailed patient demographics, behaviors, opinions, health stats, and whether or not they received the vaccine. 

We built models using Naive Bayes, Decision Tree, and Random Forest algorithms. We created multiple variations of each using forward feature selection and oversampling, due to a classs imbalance in our outcome variable (80% did not receive a vaccine). We balanced the cost of manufacturing a vaccine that went unused versus the cost of a customer not receiving a vaccine. Because of our class imbalance, F1-score would be our measure of success over accuracy. Ultimately, the Naive Bayes model with oversampling and foward selection performed the best. Our other models experienced overfitting and/or low scores. 

<img src="images/h1n1_img.png?raw=true"/>


**Improvements:** If/when the NCIRD collects similar data for COVID-19, it would be interesting to study the similarities and differences in the H1N1 data. We would expect to see differences due to government mandates, but seeing the effect.

***Technical skills:*** Naïve-Bayes, Decision Tree, Random Forest

***Tools:*** WEKA, Python

***Team:*** Eric Chen, Allen Lee, Hyoungmin (Stella) Lee, Smitha Kannanaikkal, Marianna Carini


[![Open Code](https://img.shields.io/badge/Jupyter-Open_Files-red?logo=Jupyter)](/H1N1_pred/)
[![Open Slides](https://img.shields.io/badge/PPT-View_Slides-red?logo=microsoftpowerpoint)](docs/H1N1_Pred_Presentation.png)
[![Open Report](https://img.shields.io/badge/PDF-View_Report-red?logo=MicrosoftWord)](docs/H1N1_Pred_Report.pdf)

---

### Predicting Total Nitrate (NO3) in the Atmosphere

**Project overview:** This hackathon was hosted by the Data Science Go (DSGO) conference. Our team was provided time-series environmental data from the EPA on national parks in California. The goal was to garner insights into total nitrate levels.

Our group explored common environmental pollutants to find possible links between them and the total nitrate in the atmosphere. Among the pollutants, we found that ammonium and sulfate were associated with the strongest positive correlation to nitrate levels. Our project was awarded "Best Insights" for our in-depth exploratory data analysis and crisp presentation.

<img src="images/nitrate_img3.png?raw=true"/>


**Improvements:** Given more time, we would have looked into measuring and improving our model accuracy, along with any other algorithms. Ideally, we would also search for factors that correlate with nitrate levels which we can control (ex. number of park visitors).

***Technical skills:*** Correlation, t-test, Gamma regression

***Tools:*** Python, Tableau

***Team:*** Ali Khan, Sasha Prokhorova, Marquise Piton, Marianna Carini


[![Open Code](https://img.shields.io/badge/Jupyter-Open_Files-red?logo=Jupyter)](projects/nitrate_pred/)
[![Open Slides](https://img.shields.io/badge/PPT-View_Slides-red?logo=microsoftpowerpoint)](docs/nitrate_pred_slides.pdf)

---
<p style="font-size:11px">Page template forked from <a href="https://github.com/evanca/quick-portfolio">evanca</a></p>
<!-- Remove above link if you don't want to attibute -->
