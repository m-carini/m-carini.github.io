## Portfolio

---

#### Predicting Total Nitrate (NO3) in the Atmosphere

**Project overview:** At the time of this project, the Pfizer and BioNTech vaccines were recently approved for distribution. Our team wanted to study the H1N1 vaccine data to ultimately gain insight into the demand for COVID-19 vaccines. Our dataset was provided by the National Center for Immunization and Respiratory Disease as a apart of a DrivenData competition. The data detailed patient demographics, behaviors, opinions, health stats, and whether or not they received the vaccine. 

We built models using Naive Bayes, Decision Tree, and Random Forest algorithms. We created multiple variations of each using forward feature selection and oversampling, due to a classs imbalance in our outcome variable (80% did not receive a vaccine). We balanced the cost of manufacturing a vaccine that went unused versus the cost of a customer not receiving a vaccine. Because of our class imbalance, F1-score would be our measure of success over accuracy. Ultimately, the Naive Bayes model with oversampling and foward selection performed the best. Our other models experienced overfitting and/or low scores. 

<img src="images/h1n1_img.png?raw=true"/>


**Improvements:** If/when the NCIRD collects similar data for COVID-19, it would be interesting to study the similarities and differences in the H1N1 data. We would expect to see differences due to government mandates, but seeing the effect.

***Technical skills:*** Naïve-Bayes, Decision Tree, Random Forest

***Tools:*** WEKA, Python

***Team:*** Eric Chen, Allen Lee, Hyoungmin (Stella) Lee, Smitha Kannanaikkal, Marianna Carini


[![Open Code](https://img.shields.io/badge/Jupyter-Open_Files-red?logo=Jupyter)](/H1N1_pred/)
[![Open Slides](https://img.shields.io/badge/GitHub-View_Slides-red?logo=GitHub)](docs/H1N1_Pred_Presentation.png)
[![Open Report](https://img.shields.io/badge/PDF-View_Report-red?logo=Microsoft)](docs/H1N1_Pred_Report.pdf)

---

#### Nursing Home COVID-19 Risk Assessment

**Project overview:** On the heels of the COVID-19 vaccine approvals for Pfizer and BioNTech, our team utilized our machine learning technics to protect the populations hardest hit by outbreaks, senior living facilities. We wanted to understand driving factors of COVID mortality and how best to distribute vaccines to senior citizens. We combined nursing home staff stats, nursing home supply stats, county census stats, and county COVID policy data to find trends with COVID mortality rates. Our group turned to k-means clustering to group like senior living facilities based on the mortality rates of COVID-19 at the time of analysis. Our clustering analysis came out with three distinct groups, deemed high, medium, and low impact. 

We observed that the medium impact group experienced the highest amount of staffing and supply shortages, but did not experience the highest mortality rates. Our data showed a higher percentage of the medium impact facilities were in areas implimenting shelter-in-place and mask policies versus the other two clusters. The variance in the remaining policies was neglegible between clusters. Conversly, the cluster with the highest mortality rates experienced similar shortages as the cluster with the lowest mortality rate. The highest mortaility cluster was a more densly populated cluster, had the largest population of 65+, and had the highest population of civilians without health insurance.

From our analysis, we recommended sending the vaccines first to the high impact cluster because of their high mortality rates and high at-risk population. Next would be the medium impact cluster due to their shortage of supplies. Lastly would be the low impact cluster because of their low mortality rate. Once a plan was developed, communicating that plan would be key to avoiding the same issues we saw with the H1N1 vaccine distribution.

<img src="images/covid_nursing_home_img2.png?raw=true"/>
<img src="images/covid_nursing_home_img3.png?raw=true"/>

***Technical skills:*** K-Means Clustering, API

***Tools:*** Python

***Team:*** Eric Chen, Allen Lee, Hyoungmin (Stella) Lee, Smitha Kannanaikkal, Marianna Carini


[![Open Code](https://img.shields.io/badge/Jupyter-Open_Files-red?logo=Jupyter)](/H1N1_pred/)
[![Open Slides](https://img.shields.io/badge/GitHub-View_Slides-red?logo=GitHub)](docs/COVID_Nursing_Home.pdf)
[![Open Report](https://img.shields.io/badge/PDF-View_Report-red?logo=Microsoft)](docs/COVID_Nursing_Home_Report.pdf)

---

#### Predicting Total Nitrate (NO3) in the Atmosphere

**Project overview:** This hackathon was hosted by the Data Science Go (DSGO) conference. Our team was provided time-series environmental data from the EPA on national parks in California. The goal was to garner insights into total nitrate levels.

Our group explored common environmental pollutants to find possible links between them and the total nitrate in the atmosphere. Among the pollutants, we found that ammonium and sulfate were associated with the strongest positive correlation to nitrate levels. Our project was awarded "Best Insights" for our in-depth exploratory data analysis and crisp presentation.

<img src="images/nitrate_img3.png?raw=true"/>


**Improvements:** Given more time, we would have looked into measuring and improving our model accuracy, along with any other algorithms. Ideally, we would also search for factors that correlate with nitrate levels which we can control (ex. number of park visitors).

***Technical skills:*** Correlation, t-test, Gamma regression

***Tools:*** Python, Tableau

***Team:*** Ali Khan, Sasha Prokhorova, Marquise Piton, Marianna Carini


[![Open Code](https://img.shields.io/badge/Jupyter-Open_Files-red?logo=Jupyter)](projects/nitrate_pred/)
[![Open Slides](https://img.shields.io/badge/GitHub-View_Slides-red?logo=GitHub)](docs/nitrate_pred_slides.pdf)

---
[Project 2 Title](/pdf/sample_presentation.pdf)
<img src="images/dummy_thumbnail.jpg?raw=true"/>

---
[Project 3 Title](http://example.com/)
<img src="images/dummy_thumbnail.jpg?raw=true"/>

---

### Category Name 2

- [Project 1 Title](http://example.com/)
- [Project 2 Title](http://example.com/)
- [Project 3 Title](http://example.com/)
- [Project 4 Title](http://example.com/)
- [Project 5 Title](http://example.com/)

---




---
<p style="font-size:11px">Page template forked from <a href="https://github.com/evanca/quick-portfolio">evanca</a></p>
<!-- Remove above link if you don't want to attibute -->
