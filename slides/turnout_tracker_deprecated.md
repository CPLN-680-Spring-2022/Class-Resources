---
title: "The Turnout Tracker"
author: Jonathan Tannen
output: 
  beamer_presentation:
    theme: "Metropolis"
    slide_level: 1
    includes:
      in_header: "preamble.tex"
---

# sixty-six wards
- A datascience blog about Philadelphia politics.
- "Fivethirtyeight for Philadelphia"
- [sixtysixwards.com](sixtysixwards.com), @sixtysixwards

\begin{figure}
  \includegraphics[width=0.1\columnwidth]{images/icon_big.png}
\end{figure} 

---
# sixty-six wards

- For me the challenge is... 
    - rigor + simplification
    - storytelling
- Alternatively: Question formation.
- Alternatively: The killer plot.

\begin{figure}
  \includegraphics[width=0.1\columnwidth]{images/icon_big.png}
\end{figure}

---
# Today

Two data visualization stories:

- The Turnout Tracker
- Philadelphia Voting Blocs

---
# The Turnout Tracker

\begin{figure}
  \includegraphics[width=0.8\columnwidth]{images/turnout_tracker_snapshot.png}
\end{figure}

---
# The Turnout Tracker
\begin{figure}
  \includegraphics[width=0.4\columnwidth]{images/turnout_tracker_fbgroup.png}
\end{figure}

---
# The Turnout Tracker

\begin{figure}
  \includegraphics[width=0.7\columnwidth]{images/turnout_tracker_raw.png}
\end{figure}


---
# The Turnout Tracker

\begin{figure}
  \includegraphics[width=0.7\columnwidth]{images/turnout_tracker_data.jpg}
\end{figure}


---
# The Turnout Tracker


A naive approach:  
- $x_i$ = Response $i$  
- $t_i$ = Time of response $i$, in hours  
- $d_i$ = Division of response $i$  
- $T_y$ = City-wide turnout in year $y$  
- $T_{d,y}$ = Final turnout for division $d$ in year $y$  

$\hat{T}_{2019} = T_{2015} * avg(\frac{x_i}{T_{d_i, 2015}} \times \frac{13}{t_i})$

\begin{figure}
  \includegraphics[width=0.3\columnwidth]{images/turnout_tracker_raw.png}
\end{figure}


---

# The Challenges

- Divisions have different baseline turnout.
- Divisions swing together (covary).
- Don't know the time pattern.
- There's \*definitely\* selection bias in the data.
- Knowing uncertainty in the estimate is everything.

\begin{figure}
  \includegraphics[width=0.3\columnwidth]{images/turnout_tracker_raw.png}
\end{figure}


---

# The Model

At time $t$ in division $d$ in year $y$, response $x_i$ is modeled as...

$log(x_i) = \mathcolor{red}{\alpha_{2019}} + \mathcolor{blue}{\mu_{d_i}} + \mathcolor{green}{\gamma_{d_i, 2019}} + \mathcolor{purple}{f(t_i)} + e_i$

$\gamma_{d_i} \sim Norm(0, \Sigma)$

---

# The Model

At time $t$ in division $d$ in year $y$, response $x_i$ is modeled as...

$log(x_i) = \mathcolor{red}{\alpha_{2019}} + \mathcolor{blue}{\mu_{d_i}} + \mathcolor{green}{\gamma_{d_i, 2019}} + \mathcolor{purple}{f(t_i)} + e_i$

$\gamma_{d_i} \sim Norm(0, \Sigma)$




