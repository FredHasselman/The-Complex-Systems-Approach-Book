---
title: "DCS Assignments Part X"
author: "Fred Hasselman & Maarten Wijnants"
date: "1/14/2018"
output: 
  bookdown::html_document2: 
    variant: markdown+hard_line_breaks
    fig_caption: yes
    highlight: pygments
    keep_md: yes
    number_sections: yes
    theme: spacelab
    toc: yes
    toc_float: true
    collapsed: false
    smooth_scroll: true
    code_folding: show
    bibliography: [refs.bib, packages.bib]
    biblio-style: apalike
    csl: apa.csl
    includes:
        before_body: assignmentstyle.html
    pandoc_args: ["--number-offset","7"]
    
---





# **Quick Links** {-}

* [Main Assignments Page](https://darwin.pwo.ru.nl/skunkworks/courseware/1718_DCS/assignments/)
* [Assignments Part 1A: Introduction to the mathematics of change](https://darwin.pwo.ru.nl/skunkworks/courseware/1718_DCS/assignments/ASSIGNMENTS_P1A.html)
* [Assignments Part 1B: Fitting Parameters and Potential Functions](https://darwin.pwo.ru.nl/skunkworks/courseware/1718_DCS/assignments/ASSIGNMENTS_P1B.html)
* [Assignments Part 2: Time Series Analysis: Temporal Correlations and Fractal Scaling](https://darwin.pwo.ru.nl/skunkworks/courseware/1718_DCS/assignments/ASSIGNMENTS_P2.html)
* [Assignments Part 3: Quantifying Recurrences in State Space](https://darwin.pwo.ru.nl/skunkworks/courseware/1718_DCS/assignments/ASSIGNMENTS_P3.html)
  
</br>
</br>


# **Early Warning Signals and Complex Networks**


## **Early Warning Signals in a Clinical Case Study**

Dynamic assessment (e.g. experience sampling) is increasingly used in the mental health field. Process monitoring with dynamic assessment can empower patients and benefit self-insight (van Os et al., 2017). Additionally, the experience sampling (ES) time series can be analyzed and the results can be used to inform the treatment process. 
In this assignment, we will use complex systems theory and methodology to perform a quantitative case study for a real patient. 

### First Steps {.tabset .tabset-fade .tabset-pills}

You will analyze ES data from a patient who received impatient psychotherapy for mood disorders. The patient answered questions from the therapy process questionnaire on a daily basis for the full 101 days of his treatment. 
The learning objectives of the assignments are as follows:
1) You can interpret plots of raw ES time series, as well as complexity resonance diagrams and critical instability diagrams of ES time series.
2) You can describe what possible change processes in complex systems could explain the quantitative results from the case study. 


#### Questions {-}

a) Open R and load the data 'clinical.case.study.csv' 
b) Look at the data frame. Where is time in this data? In the rows or the columns?
c) Factor 7 yields the scores on 'Impairment by Symptoms and Problems' for this patient on each day. Plot the time series. What do you see?


#### Answers {-}




### First think, then analyze (,then aggregate) {.tabset .tabset-fade .tabset-pills}

Think about what you know from the literature and the lecture. Since the goal of psychotherapy is to change the existing state of a patient, we expect to find periods of destabilization in which the attraction of the existing psychopathological state is decreased. During a destabilization period, new, possibly more healthy states can emerge. Clinical improvement than constitutes the phase transition from a pathological to a more healthy state.  

Earlier in the course, we learned that destabilization and phase transitions occur as a function of changing control parameters. Additionally, strong external influences can induce destabilization and phase transitions.

#### Questions {-}

Answer the following questions, there are no wrong answers, just try to think from a complex systems perspective:
a)	Can you think of possible control parameters for phase transitions in psychotherapy? 
b)	Can you think of possible external influences and events that relate to destabilization in psychotherapy?
c)	Based on your answers on a) and b), where in the psychotherapeutic process do you expect to find periods of destabilization?
d)	Take a look again at your plot of factor 7 for our patient. Where in the psychotherapeutic process of our patient do you expect to find periods of destabilization?

#### Answers {-}


### Phase transitions in symptom severity {.tabset .tabset-fade .tabset-pills}

In question 2, you might have hypothesized the occurrence of a phase transition in the impairment by symptoms and problems of our patient. Remember, that a phase transition is an abrupt qualitative shift in the systems behaviour. Unfortunately, we cannot see qualitative shifts in our quantitative data. However, we can try to quantify abrupt shifts in factor 7 of our patient. 

#### Questions {-}

a)	Analyze the time series of factor 7 using the function ts_levels()
b)	Describe verbally the change trajectory in the symptom severity of our patient. 

#### Answers {-}



