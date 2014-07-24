---
layout: page
title: About
---

<p class="message">
  explr - A shiny app for visualizing a data frame in R
</p>


The application allows you to:

* Select different variables to view on just x, or x v y axes (continuous variables)
* Achieve 5D visualizing by faceting on color, width and column (discrete variables)
* Transform your numbers using some standard transformations
* jitter points
* Fit lines or splines to your plots
* Download an image to share

## Install from GitHub:

From R command line, if you don't already have devtools installed:

```
install.packages(devtools)
```

Otherwise:

```
library(devtools)

install_github('explr', 'johncollins')
```

## Quickstart:

```R
library(explr)

?dexplr

library(MASS)

dexplr(Aids2)
```

A browser window will open with the application running.

## Contact:

Have questions or suggestions? Feel free to [open an issue on GitHub](https://github.com/johncollins/explr/issues/new)

