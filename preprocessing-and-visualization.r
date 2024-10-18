{
 "cells": [
  {
   "cell_type": "markdown",
   "id": "1e9a24f4",
   "metadata": {
    "papermill": {
     "duration": 0.010545,
     "end_time": "2024-10-18T07:25:43.368908",
     "exception": false,
     "start_time": "2024-10-18T07:25:43.358363",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "## Description\n",
    "In this lab, you will continue working with the airline delay dataset, focusing on data cleaning, preprocessing, and visualization techniques. You'll practice handling missing values, data normalization, binning, and creating indicator variables using R and the tidyverse package."
   ]
  },
  {
   "cell_type": "markdown",
   "id": "a3bfcd7b",
   "metadata": {
    "papermill": {
     "duration": 0.009781,
     "end_time": "2024-10-18T07:25:43.389594",
     "exception": false,
     "start_time": "2024-10-18T07:25:43.379813",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "# Tasks\n",
    "### Task 1: Data Inspection and Handling Missing Values (25 points)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 1,
   "id": "913fb63a",
   "metadata": {
    "_execution_state": "idle",
    "_uuid": "051d70d956493feee0c6d64651c6a088724dca2a",
    "execution": {
     "iopub.execute_input": "2024-10-18T07:25:43.415203Z",
     "iopub.status.busy": "2024-10-18T07:25:43.412317Z",
     "iopub.status.idle": "2024-10-18T07:25:44.843272Z",
     "shell.execute_reply": "2024-10-18T07:25:44.841048Z"
    },
    "papermill": {
     "duration": 1.447517,
     "end_time": "2024-10-18T07:25:44.846841",
     "exception": false,
     "start_time": "2024-10-18T07:25:43.399324",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "name": "stderr",
     "output_type": "stream",
     "text": [
      "── \u001b[1mAttaching core tidyverse packages\u001b[22m ──────────────────────── tidyverse 2.0.0 ──\n",
      "\u001b[32m✔\u001b[39m \u001b[34mdplyr    \u001b[39m 1.1.4     \u001b[32m✔\u001b[39m \u001b[34mreadr    \u001b[39m 2.1.5\n",
      "\u001b[32m✔\u001b[39m \u001b[34mforcats  \u001b[39m 1.0.0     \u001b[32m✔\u001b[39m \u001b[34mstringr  \u001b[39m 1.5.1\n",
      "\u001b[32m✔\u001b[39m \u001b[34mggplot2  \u001b[39m 3.5.1     \u001b[32m✔\u001b[39m \u001b[34mtibble   \u001b[39m 3.2.1\n",
      "\u001b[32m✔\u001b[39m \u001b[34mlubridate\u001b[39m 1.9.3     \u001b[32m✔\u001b[39m \u001b[34mtidyr    \u001b[39m 1.3.1\n",
      "\u001b[32m✔\u001b[39m \u001b[34mpurrr    \u001b[39m 1.0.2     \n"
     ]
    },
    {
     "name": "stderr",
     "output_type": "stream",
     "text": [
      "── \u001b[1mConflicts\u001b[22m ────────────────────────────────────────── tidyverse_conflicts() ──\n",
      "\u001b[31m✖\u001b[39m \u001b[34mdplyr\u001b[39m::\u001b[32mfilter()\u001b[39m masks \u001b[34mstats\u001b[39m::filter()\n",
      "\u001b[31m✖\u001b[39m \u001b[34mdplyr\u001b[39m::\u001b[32mlag()\u001b[39m    masks \u001b[34mstats\u001b[39m::lag()\n",
      "\u001b[36mℹ\u001b[39m Use the conflicted package (\u001b[3m\u001b[34m<http://conflicted.r-lib.org/>\u001b[39m\u001b[23m) to force all conflicts to become errors\n"
     ]
    },
    {
     "data": {
      "text/html": [],
      "text/latex": [],
      "text/markdown": [],
      "text/plain": [
       "character(0)"
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "# This R environment comes with many helpful analytics packages installed\n",
    "# It is defined by the kaggle/rstats Docker image: https://github.com/kaggle/docker-rstats\n",
    "# For example, here's a helpful package to load\n",
    "\n",
    "library(tidyverse) # metapackage of all tidyverse packages\n",
    "\n",
    "# Input data files are available in the read-only \"../input/\" directory\n",
    "# For example, running this (by clicking run or pressing Shift+Enter) will list all files under the input directory\n",
    "\n",
    "list.files(path = \"../input\")\n",
    "\n",
    "# You can write up to 20GB to the current directory (/kaggle/working/) that gets preserved as output when you create a version using \"Save & Run All\" \n",
    "# You can also write temporary files to /kaggle/temp/, but they won't be saved outside of the current session"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 2,
   "id": "a9a61f68",
   "metadata": {
    "_kg_hide-output": true,
    "execution": {
     "iopub.execute_input": "2024-10-18T07:25:44.905596Z",
     "iopub.status.busy": "2024-10-18T07:25:44.869583Z",
     "iopub.status.idle": "2024-10-18T07:25:45.223554Z",
     "shell.execute_reply": "2024-10-18T07:25:45.221380Z"
    },
    "papermill": {
     "duration": 0.369548,
     "end_time": "2024-10-18T07:25:45.226805",
     "exception": false,
     "start_time": "2024-10-18T07:25:44.857257",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [],
   "source": [
    "url <- 'https://dax-cdn.cdn.appdomain.cloud/dax-airline/1.0.1/lax_to_jfk.tar.gz'\n",
    "\n",
    "download.file(url, destfile = \"/kaggle/working/lax_to_jfk.tar.gz\")\n",
    "\n",
    "untar(\"lax_to_jfk.tar.gz\", exdir =\"internal\")"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 3,
   "id": "1008fafa",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2024-10-18T07:25:45.251721Z",
     "iopub.status.busy": "2024-10-18T07:25:45.249928Z",
     "iopub.status.idle": "2024-10-18T07:25:45.461454Z",
     "shell.execute_reply": "2024-10-18T07:25:45.459359Z"
    },
    "papermill": {
     "duration": 0.227006,
     "end_time": "2024-10-18T07:25:45.464443",
     "exception": false,
     "start_time": "2024-10-18T07:25:45.237437",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [],
   "source": [
    "sub_airline <- read_csv(\"/kaggle/working/internal/lax_to_jfk/lax_to_jfk.csv\",\n",
    "                        col_types = cols(\n",
    "                        DivDistance = col_number(),\n",
    "                        DivArrDelay = col_number()\n",
    "                        ))"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 4,
   "id": "dbfd576d",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2024-10-18T07:25:45.489206Z",
     "iopub.status.busy": "2024-10-18T07:25:45.487398Z",
     "iopub.status.idle": "2024-10-18T07:25:45.571969Z",
     "shell.execute_reply": "2024-10-18T07:25:45.569403Z"
    },
    "papermill": {
     "duration": 0.100326,
     "end_time": "2024-10-18T07:25:45.575300",
     "exception": false,
     "start_time": "2024-10-18T07:25:45.474974",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A tibble: 6 × 21</caption>\n",
       "<thead>\n",
       "\t<tr><th scope=col>Month</th><th scope=col>DayOfWeek</th><th scope=col>FlightDate</th><th scope=col>Reporting_Airline</th><th scope=col>Origin</th><th scope=col>Dest</th><th scope=col>CRSDepTime</th><th scope=col>CRSArrTime</th><th scope=col>DepTime</th><th scope=col>ArrTime</th><th scope=col>⋯</th><th scope=col>ArrDelayMinutes</th><th scope=col>CarrierDelay</th><th scope=col>WeatherDelay</th><th scope=col>NASDelay</th><th scope=col>SecurityDelay</th><th scope=col>LateAircraftDelay</th><th scope=col>DepDelay</th><th scope=col>DepDelayMinutes</th><th scope=col>DivDistance</th><th scope=col>DivArrDelay</th></tr>\n",
       "\t<tr><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;date&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>⋯</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><td> 3</td><td>5</td><td>2003-03-28</td><td>UA</td><td>LAX</td><td>JFK</td><td>2210</td><td>0615</td><td>2209</td><td>0617</td><td>⋯</td><td>2</td><td>NA</td><td>NA</td><td>NA</td><td>NA</td><td>NA</td><td>-1</td><td>0</td><td>NA</td><td>NA</td></tr>\n",
       "\t<tr><td>11</td><td>4</td><td>2018-11-29</td><td>AS</td><td>LAX</td><td>JFK</td><td>1045</td><td>1912</td><td>1049</td><td>1851</td><td>⋯</td><td>0</td><td>NA</td><td>NA</td><td>NA</td><td>NA</td><td>NA</td><td> 4</td><td>4</td><td>NA</td><td>NA</td></tr>\n",
       "\t<tr><td> 8</td><td>5</td><td>2015-08-28</td><td>UA</td><td>LAX</td><td>JFK</td><td>0805</td><td>1634</td><td>0757</td><td>1620</td><td>⋯</td><td>0</td><td>NA</td><td>NA</td><td>NA</td><td>NA</td><td>NA</td><td>-8</td><td>0</td><td>NA</td><td>NA</td></tr>\n",
       "\t<tr><td> 4</td><td>7</td><td>2003-04-20</td><td>DL</td><td>LAX</td><td>JFK</td><td>2205</td><td>0619</td><td>2212</td><td>0616</td><td>⋯</td><td>0</td><td>NA</td><td>NA</td><td>NA</td><td>NA</td><td>NA</td><td> 7</td><td>7</td><td>NA</td><td>NA</td></tr>\n",
       "\t<tr><td>11</td><td>3</td><td>2005-11-30</td><td>UA</td><td>LAX</td><td>JFK</td><td>0840</td><td>1653</td><td>0836</td><td>1640</td><td>⋯</td><td>0</td><td>NA</td><td>NA</td><td>NA</td><td>NA</td><td>NA</td><td>-4</td><td>0</td><td>NA</td><td>NA</td></tr>\n",
       "\t<tr><td> 4</td><td>1</td><td>1992-04-06</td><td>UA</td><td>LAX</td><td>JFK</td><td>1450</td><td>2308</td><td>1452</td><td>2248</td><td>⋯</td><td>0</td><td>NA</td><td>NA</td><td>NA</td><td>NA</td><td>NA</td><td> 2</td><td>2</td><td>NA</td><td>NA</td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A tibble: 6 × 21\n",
       "\\begin{tabular}{lllllllllllllllllllll}\n",
       " Month & DayOfWeek & FlightDate & Reporting\\_Airline & Origin & Dest & CRSDepTime & CRSArrTime & DepTime & ArrTime & ⋯ & ArrDelayMinutes & CarrierDelay & WeatherDelay & NASDelay & SecurityDelay & LateAircraftDelay & DepDelay & DepDelayMinutes & DivDistance & DivArrDelay\\\\\n",
       " <dbl> & <dbl> & <date> & <chr> & <chr> & <chr> & <chr> & <chr> & <chr> & <chr> & ⋯ & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl>\\\\\n",
       "\\hline\n",
       "\t  3 & 5 & 2003-03-28 & UA & LAX & JFK & 2210 & 0615 & 2209 & 0617 & ⋯ & 2 & NA & NA & NA & NA & NA & -1 & 0 & NA & NA\\\\\n",
       "\t 11 & 4 & 2018-11-29 & AS & LAX & JFK & 1045 & 1912 & 1049 & 1851 & ⋯ & 0 & NA & NA & NA & NA & NA &  4 & 4 & NA & NA\\\\\n",
       "\t  8 & 5 & 2015-08-28 & UA & LAX & JFK & 0805 & 1634 & 0757 & 1620 & ⋯ & 0 & NA & NA & NA & NA & NA & -8 & 0 & NA & NA\\\\\n",
       "\t  4 & 7 & 2003-04-20 & DL & LAX & JFK & 2205 & 0619 & 2212 & 0616 & ⋯ & 0 & NA & NA & NA & NA & NA &  7 & 7 & NA & NA\\\\\n",
       "\t 11 & 3 & 2005-11-30 & UA & LAX & JFK & 0840 & 1653 & 0836 & 1640 & ⋯ & 0 & NA & NA & NA & NA & NA & -4 & 0 & NA & NA\\\\\n",
       "\t  4 & 1 & 1992-04-06 & UA & LAX & JFK & 1450 & 2308 & 1452 & 2248 & ⋯ & 0 & NA & NA & NA & NA & NA &  2 & 2 & NA & NA\\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A tibble: 6 × 21\n",
       "\n",
       "| Month &lt;dbl&gt; | DayOfWeek &lt;dbl&gt; | FlightDate &lt;date&gt; | Reporting_Airline &lt;chr&gt; | Origin &lt;chr&gt; | Dest &lt;chr&gt; | CRSDepTime &lt;chr&gt; | CRSArrTime &lt;chr&gt; | DepTime &lt;chr&gt; | ArrTime &lt;chr&gt; | ⋯ ⋯ | ArrDelayMinutes &lt;dbl&gt; | CarrierDelay &lt;dbl&gt; | WeatherDelay &lt;dbl&gt; | NASDelay &lt;dbl&gt; | SecurityDelay &lt;dbl&gt; | LateAircraftDelay &lt;dbl&gt; | DepDelay &lt;dbl&gt; | DepDelayMinutes &lt;dbl&gt; | DivDistance &lt;dbl&gt; | DivArrDelay &lt;dbl&gt; |\n",
       "|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|\n",
       "|  3 | 5 | 2003-03-28 | UA | LAX | JFK | 2210 | 0615 | 2209 | 0617 | ⋯ | 2 | NA | NA | NA | NA | NA | -1 | 0 | NA | NA |\n",
       "| 11 | 4 | 2018-11-29 | AS | LAX | JFK | 1045 | 1912 | 1049 | 1851 | ⋯ | 0 | NA | NA | NA | NA | NA |  4 | 4 | NA | NA |\n",
       "|  8 | 5 | 2015-08-28 | UA | LAX | JFK | 0805 | 1634 | 0757 | 1620 | ⋯ | 0 | NA | NA | NA | NA | NA | -8 | 0 | NA | NA |\n",
       "|  4 | 7 | 2003-04-20 | DL | LAX | JFK | 2205 | 0619 | 2212 | 0616 | ⋯ | 0 | NA | NA | NA | NA | NA |  7 | 7 | NA | NA |\n",
       "| 11 | 3 | 2005-11-30 | UA | LAX | JFK | 0840 | 1653 | 0836 | 1640 | ⋯ | 0 | NA | NA | NA | NA | NA | -4 | 0 | NA | NA |\n",
       "|  4 | 1 | 1992-04-06 | UA | LAX | JFK | 1450 | 2308 | 1452 | 2248 | ⋯ | 0 | NA | NA | NA | NA | NA |  2 | 2 | NA | NA |\n",
       "\n"
      ],
      "text/plain": [
       "  Month DayOfWeek FlightDate Reporting_Airline Origin Dest CRSDepTime\n",
       "1  3    5         2003-03-28 UA                LAX    JFK  2210      \n",
       "2 11    4         2018-11-29 AS                LAX    JFK  1045      \n",
       "3  8    5         2015-08-28 UA                LAX    JFK  0805      \n",
       "4  4    7         2003-04-20 DL                LAX    JFK  2205      \n",
       "5 11    3         2005-11-30 UA                LAX    JFK  0840      \n",
       "6  4    1         1992-04-06 UA                LAX    JFK  1450      \n",
       "  CRSArrTime DepTime ArrTime ⋯ ArrDelayMinutes CarrierDelay WeatherDelay\n",
       "1 0615       2209    0617    ⋯ 2               NA           NA          \n",
       "2 1912       1049    1851    ⋯ 0               NA           NA          \n",
       "3 1634       0757    1620    ⋯ 0               NA           NA          \n",
       "4 0619       2212    0616    ⋯ 0               NA           NA          \n",
       "5 1653       0836    1640    ⋯ 0               NA           NA          \n",
       "6 2308       1452    2248    ⋯ 0               NA           NA          \n",
       "  NASDelay SecurityDelay LateAircraftDelay DepDelay DepDelayMinutes DivDistance\n",
       "1 NA       NA            NA                -1       0               NA         \n",
       "2 NA       NA            NA                 4       4               NA         \n",
       "3 NA       NA            NA                -8       0               NA         \n",
       "4 NA       NA            NA                 7       7               NA         \n",
       "5 NA       NA            NA                -4       0               NA         \n",
       "6 NA       NA            NA                 2       2               NA         \n",
       "  DivArrDelay\n",
       "1 NA         \n",
       "2 NA         \n",
       "3 NA         \n",
       "4 NA         \n",
       "5 NA         \n",
       "6 NA         "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    },
    {
     "data": {
      "text/html": [
       "<style>\n",
       ".list-inline {list-style: none; margin:0; padding: 0}\n",
       ".list-inline>li {display: inline-block}\n",
       ".list-inline>li:not(:last-child)::after {content: \"\\00b7\"; padding: 0 .5ex}\n",
       "</style>\n",
       "<ol class=list-inline><li>2855</li><li>21</li></ol>\n"
      ],
      "text/latex": [
       "\\begin{enumerate*}\n",
       "\\item 2855\n",
       "\\item 21\n",
       "\\end{enumerate*}\n"
      ],
      "text/markdown": [
       "1. 2855\n",
       "2. 21\n",
       "\n",
       "\n"
      ],
      "text/plain": [
       "[1] 2855   21"
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "head(sub_airline)\n",
    "dim(sub_airline)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 5,
   "id": "3ceeeb65",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2024-10-18T07:25:45.601854Z",
     "iopub.status.busy": "2024-10-18T07:25:45.600112Z",
     "iopub.status.idle": "2024-10-18T07:25:45.630184Z",
     "shell.execute_reply": "2024-10-18T07:25:45.627547Z"
    },
    "papermill": {
     "duration": 0.046482,
     "end_time": "2024-10-18T07:25:45.633488",
     "exception": false,
     "start_time": "2024-10-18T07:25:45.587006",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "<dl>\n",
       "\t<dt>$Month</dt>\n",
       "\t\t<dd>0</dd>\n",
       "\t<dt>$DayOfWeek</dt>\n",
       "\t\t<dd>0</dd>\n",
       "\t<dt>$FlightDate</dt>\n",
       "\t\t<dd>0</dd>\n",
       "\t<dt>$Reporting_Airline</dt>\n",
       "\t\t<dd>0</dd>\n",
       "\t<dt>$Origin</dt>\n",
       "\t\t<dd>0</dd>\n",
       "\t<dt>$Dest</dt>\n",
       "\t\t<dd>0</dd>\n",
       "\t<dt>$CRSDepTime</dt>\n",
       "\t\t<dd>0</dd>\n",
       "\t<dt>$CRSArrTime</dt>\n",
       "\t\t<dd>0</dd>\n",
       "\t<dt>$DepTime</dt>\n",
       "\t\t<dd>0</dd>\n",
       "\t<dt>$ArrTime</dt>\n",
       "\t\t<dd>0</dd>\n",
       "\t<dt>$ArrDelay</dt>\n",
       "\t\t<dd>0</dd>\n",
       "\t<dt>$ArrDelayMinutes</dt>\n",
       "\t\t<dd>0</dd>\n",
       "\t<dt>$CarrierDelay</dt>\n",
       "\t\t<dd>2486</dd>\n",
       "\t<dt>$WeatherDelay</dt>\n",
       "\t\t<dd>2486</dd>\n",
       "\t<dt>$NASDelay</dt>\n",
       "\t\t<dd>2486</dd>\n",
       "\t<dt>$SecurityDelay</dt>\n",
       "\t\t<dd>2486</dd>\n",
       "\t<dt>$LateAircraftDelay</dt>\n",
       "\t\t<dd>2486</dd>\n",
       "\t<dt>$DepDelay</dt>\n",
       "\t\t<dd>0</dd>\n",
       "\t<dt>$DepDelayMinutes</dt>\n",
       "\t\t<dd>0</dd>\n",
       "\t<dt>$DivDistance</dt>\n",
       "\t\t<dd>2855</dd>\n",
       "\t<dt>$DivArrDelay</dt>\n",
       "\t\t<dd>2855</dd>\n",
       "</dl>\n"
      ],
      "text/latex": [
       "\\begin{description}\n",
       "\\item[\\$Month] 0\n",
       "\\item[\\$DayOfWeek] 0\n",
       "\\item[\\$FlightDate] 0\n",
       "\\item[\\$Reporting\\_Airline] 0\n",
       "\\item[\\$Origin] 0\n",
       "\\item[\\$Dest] 0\n",
       "\\item[\\$CRSDepTime] 0\n",
       "\\item[\\$CRSArrTime] 0\n",
       "\\item[\\$DepTime] 0\n",
       "\\item[\\$ArrTime] 0\n",
       "\\item[\\$ArrDelay] 0\n",
       "\\item[\\$ArrDelayMinutes] 0\n",
       "\\item[\\$CarrierDelay] 2486\n",
       "\\item[\\$WeatherDelay] 2486\n",
       "\\item[\\$NASDelay] 2486\n",
       "\\item[\\$SecurityDelay] 2486\n",
       "\\item[\\$LateAircraftDelay] 2486\n",
       "\\item[\\$DepDelay] 0\n",
       "\\item[\\$DepDelayMinutes] 0\n",
       "\\item[\\$DivDistance] 2855\n",
       "\\item[\\$DivArrDelay] 2855\n",
       "\\end{description}\n"
      ],
      "text/markdown": [
       "$Month\n",
       ":   0\n",
       "$DayOfWeek\n",
       ":   0\n",
       "$FlightDate\n",
       ":   0\n",
       "$Reporting_Airline\n",
       ":   0\n",
       "$Origin\n",
       ":   0\n",
       "$Dest\n",
       ":   0\n",
       "$CRSDepTime\n",
       ":   0\n",
       "$CRSArrTime\n",
       ":   0\n",
       "$DepTime\n",
       ":   0\n",
       "$ArrTime\n",
       ":   0\n",
       "$ArrDelay\n",
       ":   0\n",
       "$ArrDelayMinutes\n",
       ":   0\n",
       "$CarrierDelay\n",
       ":   2486\n",
       "$WeatherDelay\n",
       ":   2486\n",
       "$NASDelay\n",
       ":   2486\n",
       "$SecurityDelay\n",
       ":   2486\n",
       "$LateAircraftDelay\n",
       ":   2486\n",
       "$DepDelay\n",
       ":   0\n",
       "$DepDelayMinutes\n",
       ":   0\n",
       "$DivDistance\n",
       ":   2855\n",
       "$DivArrDelay\n",
       ":   2855\n",
       "\n",
       "\n"
      ],
      "text/plain": [
       "$Month\n",
       "[1] 0\n",
       "\n",
       "$DayOfWeek\n",
       "[1] 0\n",
       "\n",
       "$FlightDate\n",
       "[1] 0\n",
       "\n",
       "$Reporting_Airline\n",
       "[1] 0\n",
       "\n",
       "$Origin\n",
       "[1] 0\n",
       "\n",
       "$Dest\n",
       "[1] 0\n",
       "\n",
       "$CRSDepTime\n",
       "[1] 0\n",
       "\n",
       "$CRSArrTime\n",
       "[1] 0\n",
       "\n",
       "$DepTime\n",
       "[1] 0\n",
       "\n",
       "$ArrTime\n",
       "[1] 0\n",
       "\n",
       "$ArrDelay\n",
       "[1] 0\n",
       "\n",
       "$ArrDelayMinutes\n",
       "[1] 0\n",
       "\n",
       "$CarrierDelay\n",
       "[1] 2486\n",
       "\n",
       "$WeatherDelay\n",
       "[1] 2486\n",
       "\n",
       "$NASDelay\n",
       "[1] 2486\n",
       "\n",
       "$SecurityDelay\n",
       "[1] 2486\n",
       "\n",
       "$LateAircraftDelay\n",
       "[1] 2486\n",
       "\n",
       "$DepDelay\n",
       "[1] 0\n",
       "\n",
       "$DepDelayMinutes\n",
       "[1] 0\n",
       "\n",
       "$DivDistance\n",
       "[1] 2855\n",
       "\n",
       "$DivArrDelay\n",
       "[1] 2855\n"
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "map(sub_airline, ~sum(is.na(.)))"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "b167d5bb",
   "metadata": {
    "papermill": {
     "duration": 0.011075,
     "end_time": "2024-10-18T07:25:45.655786",
     "exception": false,
     "start_time": "2024-10-18T07:25:45.644711",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "#### a.  Remove rows with missing values in specific columns"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 6,
   "id": "5923eefc",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2024-10-18T07:25:45.682504Z",
     "iopub.status.busy": "2024-10-18T07:25:45.680586Z",
     "iopub.status.idle": "2024-10-18T07:25:45.706355Z",
     "shell.execute_reply": "2024-10-18T07:25:45.704362Z"
    },
    "papermill": {
     "duration": 0.043095,
     "end_time": "2024-10-18T07:25:45.709991",
     "exception": false,
     "start_time": "2024-10-18T07:25:45.666896",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [],
   "source": [
    "drop_na_columns <- sub_airline %>% select(-DivDistance, -DivArrDelay)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 7,
   "id": "c74e9a12",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2024-10-18T07:25:45.736480Z",
     "iopub.status.busy": "2024-10-18T07:25:45.734753Z",
     "iopub.status.idle": "2024-10-18T07:25:45.805272Z",
     "shell.execute_reply": "2024-10-18T07:25:45.802574Z"
    },
    "papermill": {
     "duration": 0.08736,
     "end_time": "2024-10-18T07:25:45.808652",
     "exception": false,
     "start_time": "2024-10-18T07:25:45.721292",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "<style>\n",
       ".list-inline {list-style: none; margin:0; padding: 0}\n",
       ".list-inline>li {display: inline-block}\n",
       ".list-inline>li:not(:last-child)::after {content: \"\\00b7\"; padding: 0 .5ex}\n",
       "</style>\n",
       "<ol class=list-inline><li>369</li><li>19</li></ol>\n"
      ],
      "text/latex": [
       "\\begin{enumerate*}\n",
       "\\item 369\n",
       "\\item 19\n",
       "\\end{enumerate*}\n"
      ],
      "text/markdown": [
       "1. 369\n",
       "2. 19\n",
       "\n",
       "\n"
      ],
      "text/plain": [
       "[1] 369  19"
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    },
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A tibble: 6 × 19</caption>\n",
       "<thead>\n",
       "\t<tr><th scope=col>Month</th><th scope=col>DayOfWeek</th><th scope=col>FlightDate</th><th scope=col>Reporting_Airline</th><th scope=col>Origin</th><th scope=col>Dest</th><th scope=col>CRSDepTime</th><th scope=col>CRSArrTime</th><th scope=col>DepTime</th><th scope=col>ArrTime</th><th scope=col>ArrDelay</th><th scope=col>ArrDelayMinutes</th><th scope=col>CarrierDelay</th><th scope=col>WeatherDelay</th><th scope=col>NASDelay</th><th scope=col>SecurityDelay</th><th scope=col>LateAircraftDelay</th><th scope=col>DepDelay</th><th scope=col>DepDelayMinutes</th></tr>\n",
       "\t<tr><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;date&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><td> 8</td><td>5</td><td>2018-08-03</td><td>B6</td><td>LAX</td><td>JFK</td><td>0013</td><td>0839</td><td>0034</td><td>0913</td><td>34</td><td>34</td><td>11</td><td>0</td><td>23</td><td>0</td><td> 0</td><td>21</td><td>21</td></tr>\n",
       "\t<tr><td> 6</td><td>4</td><td>2006-06-01</td><td>AA</td><td>LAX</td><td>JFK</td><td>1515</td><td>2332</td><td>1507</td><td>2353</td><td>21</td><td>21</td><td> 0</td><td>0</td><td>21</td><td>0</td><td> 0</td><td>-8</td><td> 0</td></tr>\n",
       "\t<tr><td> 1</td><td>7</td><td>2007-01-28</td><td>UA</td><td>LAX</td><td>JFK</td><td>0845</td><td>1656</td><td>0838</td><td>1713</td><td>17</td><td>17</td><td> 0</td><td>0</td><td>17</td><td>0</td><td> 0</td><td>-7</td><td> 0</td></tr>\n",
       "\t<tr><td> 6</td><td>5</td><td>2013-06-28</td><td>AA</td><td>LAX</td><td>JFK</td><td>1200</td><td>2045</td><td>1328</td><td>2220</td><td>95</td><td>95</td><td> 5</td><td>0</td><td> 7</td><td>0</td><td>83</td><td>88</td><td>88</td></tr>\n",
       "\t<tr><td> 9</td><td>1</td><td>2010-09-27</td><td>DL</td><td>LAX</td><td>JFK</td><td>1330</td><td>2208</td><td>1426</td><td>2316</td><td>68</td><td>68</td><td> 0</td><td>0</td><td>68</td><td>0</td><td> 0</td><td>56</td><td>56</td></tr>\n",
       "\t<tr><td>10</td><td>3</td><td>2005-10-12</td><td>AA</td><td>LAX</td><td>JFK</td><td>0930</td><td>1755</td><td>0958</td><td>1823</td><td>28</td><td>28</td><td> 0</td><td>0</td><td>28</td><td>0</td><td> 0</td><td>28</td><td>28</td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A tibble: 6 × 19\n",
       "\\begin{tabular}{lllllllllllllllllll}\n",
       " Month & DayOfWeek & FlightDate & Reporting\\_Airline & Origin & Dest & CRSDepTime & CRSArrTime & DepTime & ArrTime & ArrDelay & ArrDelayMinutes & CarrierDelay & WeatherDelay & NASDelay & SecurityDelay & LateAircraftDelay & DepDelay & DepDelayMinutes\\\\\n",
       " <dbl> & <dbl> & <date> & <chr> & <chr> & <chr> & <chr> & <chr> & <chr> & <chr> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl>\\\\\n",
       "\\hline\n",
       "\t  8 & 5 & 2018-08-03 & B6 & LAX & JFK & 0013 & 0839 & 0034 & 0913 & 34 & 34 & 11 & 0 & 23 & 0 &  0 & 21 & 21\\\\\n",
       "\t  6 & 4 & 2006-06-01 & AA & LAX & JFK & 1515 & 2332 & 1507 & 2353 & 21 & 21 &  0 & 0 & 21 & 0 &  0 & -8 &  0\\\\\n",
       "\t  1 & 7 & 2007-01-28 & UA & LAX & JFK & 0845 & 1656 & 0838 & 1713 & 17 & 17 &  0 & 0 & 17 & 0 &  0 & -7 &  0\\\\\n",
       "\t  6 & 5 & 2013-06-28 & AA & LAX & JFK & 1200 & 2045 & 1328 & 2220 & 95 & 95 &  5 & 0 &  7 & 0 & 83 & 88 & 88\\\\\n",
       "\t  9 & 1 & 2010-09-27 & DL & LAX & JFK & 1330 & 2208 & 1426 & 2316 & 68 & 68 &  0 & 0 & 68 & 0 &  0 & 56 & 56\\\\\n",
       "\t 10 & 3 & 2005-10-12 & AA & LAX & JFK & 0930 & 1755 & 0958 & 1823 & 28 & 28 &  0 & 0 & 28 & 0 &  0 & 28 & 28\\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A tibble: 6 × 19\n",
       "\n",
       "| Month &lt;dbl&gt; | DayOfWeek &lt;dbl&gt; | FlightDate &lt;date&gt; | Reporting_Airline &lt;chr&gt; | Origin &lt;chr&gt; | Dest &lt;chr&gt; | CRSDepTime &lt;chr&gt; | CRSArrTime &lt;chr&gt; | DepTime &lt;chr&gt; | ArrTime &lt;chr&gt; | ArrDelay &lt;dbl&gt; | ArrDelayMinutes &lt;dbl&gt; | CarrierDelay &lt;dbl&gt; | WeatherDelay &lt;dbl&gt; | NASDelay &lt;dbl&gt; | SecurityDelay &lt;dbl&gt; | LateAircraftDelay &lt;dbl&gt; | DepDelay &lt;dbl&gt; | DepDelayMinutes &lt;dbl&gt; |\n",
       "|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|\n",
       "|  8 | 5 | 2018-08-03 | B6 | LAX | JFK | 0013 | 0839 | 0034 | 0913 | 34 | 34 | 11 | 0 | 23 | 0 |  0 | 21 | 21 |\n",
       "|  6 | 4 | 2006-06-01 | AA | LAX | JFK | 1515 | 2332 | 1507 | 2353 | 21 | 21 |  0 | 0 | 21 | 0 |  0 | -8 |  0 |\n",
       "|  1 | 7 | 2007-01-28 | UA | LAX | JFK | 0845 | 1656 | 0838 | 1713 | 17 | 17 |  0 | 0 | 17 | 0 |  0 | -7 |  0 |\n",
       "|  6 | 5 | 2013-06-28 | AA | LAX | JFK | 1200 | 2045 | 1328 | 2220 | 95 | 95 |  5 | 0 |  7 | 0 | 83 | 88 | 88 |\n",
       "|  9 | 1 | 2010-09-27 | DL | LAX | JFK | 1330 | 2208 | 1426 | 2316 | 68 | 68 |  0 | 0 | 68 | 0 |  0 | 56 | 56 |\n",
       "| 10 | 3 | 2005-10-12 | AA | LAX | JFK | 0930 | 1755 | 0958 | 1823 | 28 | 28 |  0 | 0 | 28 | 0 |  0 | 28 | 28 |\n",
       "\n"
      ],
      "text/plain": [
       "  Month DayOfWeek FlightDate Reporting_Airline Origin Dest CRSDepTime\n",
       "1  8    5         2018-08-03 B6                LAX    JFK  0013      \n",
       "2  6    4         2006-06-01 AA                LAX    JFK  1515      \n",
       "3  1    7         2007-01-28 UA                LAX    JFK  0845      \n",
       "4  6    5         2013-06-28 AA                LAX    JFK  1200      \n",
       "5  9    1         2010-09-27 DL                LAX    JFK  1330      \n",
       "6 10    3         2005-10-12 AA                LAX    JFK  0930      \n",
       "  CRSArrTime DepTime ArrTime ArrDelay ArrDelayMinutes CarrierDelay WeatherDelay\n",
       "1 0839       0034    0913    34       34              11           0           \n",
       "2 2332       1507    2353    21       21               0           0           \n",
       "3 1656       0838    1713    17       17               0           0           \n",
       "4 2045       1328    2220    95       95               5           0           \n",
       "5 2208       1426    2316    68       68               0           0           \n",
       "6 1755       0958    1823    28       28               0           0           \n",
       "  NASDelay SecurityDelay LateAircraftDelay DepDelay DepDelayMinutes\n",
       "1 23       0              0                21       21             \n",
       "2 21       0              0                -8        0             \n",
       "3 17       0              0                -7        0             \n",
       "4  7       0             83                88       88             \n",
       "5 68       0              0                56       56             \n",
       "6 28       0              0                28       28             "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "drop_na_rows <- drop_na_columns %>% drop_na(CarrierDelay)\n",
    "\n",
    "dim(drop_na_rows)\n",
    "head(drop_na_rows)"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "e2dff408",
   "metadata": {
    "papermill": {
     "duration": 0.011907,
     "end_time": "2024-10-18T07:25:45.832524",
     "exception": false,
     "start_time": "2024-10-18T07:25:45.820617",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "#### b. Replace missing values with appropriate measures (e.g., mean, median)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 8,
   "id": "2a6c7687",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2024-10-18T07:25:45.860467Z",
     "iopub.status.busy": "2024-10-18T07:25:45.858661Z",
     "iopub.status.idle": "2024-10-18T07:25:45.888328Z",
     "shell.execute_reply": "2024-10-18T07:25:45.886409Z"
    },
    "papermill": {
     "duration": 0.047638,
     "end_time": "2024-10-18T07:25:45.891921",
     "exception": false,
     "start_time": "2024-10-18T07:25:45.844283",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [],
   "source": [
    "meanC = mean(sub_airline$CarrierDelay, na.rm=TRUE)\n",
    "meanW = mean(sub_airline$WeatherDelay,na.rm=TRUE)\n",
    "meanN = mean(sub_airline$NASDelay,na.rm=TRUE)\n",
    "meanS = mean(sub_airline$SecurityDelay,na.rm=TRUE)\n",
    "meanL = mean(sub_airline$LateAircraftDelay,na.rm=TRUE)\n",
    "\n",
    "sub_airline <- sub_airline %>% replace_na(list(CarrierDelay=meanC,\n",
    "                                                  WeatherDelay=meanW,\n",
    "                                                  NASDelay=meanN,\n",
    "                                                  SecurityDelay=meanS,\n",
    "                                                  LateAircraftDelay=meanL))\n"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 9,
   "id": "b78e2b51",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2024-10-18T07:25:45.919306Z",
     "iopub.status.busy": "2024-10-18T07:25:45.917556Z",
     "iopub.status.idle": "2024-10-18T07:25:45.960688Z",
     "shell.execute_reply": "2024-10-18T07:25:45.958129Z"
    },
    "papermill": {
     "duration": 0.060295,
     "end_time": "2024-10-18T07:25:45.963952",
     "exception": false,
     "start_time": "2024-10-18T07:25:45.903657",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "<style>\n",
       ".list-inline {list-style: none; margin:0; padding: 0}\n",
       ".list-inline>li {display: inline-block}\n",
       ".list-inline>li:not(:last-child)::after {content: \"\\00b7\"; padding: 0 .5ex}\n",
       "</style>\n",
       "<ol class=list-inline><li>2855</li><li>21</li></ol>\n"
      ],
      "text/latex": [
       "\\begin{enumerate*}\n",
       "\\item 2855\n",
       "\\item 21\n",
       "\\end{enumerate*}\n"
      ],
      "text/markdown": [
       "1. 2855\n",
       "2. 21\n",
       "\n",
       "\n"
      ],
      "text/plain": [
       "[1] 2855   21"
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "dim(sub_airline)"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "60b61ea4",
   "metadata": {
    "papermill": {
     "duration": 0.01194,
     "end_time": "2024-10-18T07:25:45.987906",
     "exception": false,
     "start_time": "2024-10-18T07:25:45.975966",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "### Student Evaluation and Comments\n",
    "After completing Task 1, evaluate your approach:\n",
    "\n",
    "<h3> Which columns had the most missing values? </h3>\n",
    "DivDistance (2855) and DivArrDelay (2855) have the most missing value.\n",
    "<h3>What were the pros and cons of each missing value strategy you implemented? </h3>\n",
    "Replacing NA with the mean is fast and useful for normally distributed data but can introduce bias and reduce variability in complex datasets.\n",
    "<h3>How did the dimensions of the dataset change after handling missing values?</h3>\n",
    "2855.19"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "c7f9c1bc",
   "metadata": {
    "papermill": {
     "duration": 0.012132,
     "end_time": "2024-10-18T07:25:46.011931",
     "exception": false,
     "start_time": "2024-10-18T07:25:45.999799",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "## Task 2: Data Normalization (25 points)\n"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "6ab1870f",
   "metadata": {
    "papermill": {
     "duration": 0.011834,
     "end_time": "2024-10-18T07:25:46.035808",
     "exception": false,
     "start_time": "2024-10-18T07:25:46.023974",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "Implement three different normalization techniques on the \"ArrDelay\" and \"DepDelay\" columns: a. Simple scaling b. Min-Max scaling c. Z-score standardization"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 10,
   "id": "52c9f035",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2024-10-18T07:25:46.063786Z",
     "iopub.status.busy": "2024-10-18T07:25:46.062100Z",
     "iopub.status.idle": "2024-10-18T07:25:46.091631Z",
     "shell.execute_reply": "2024-10-18T07:25:46.089755Z"
    },
    "papermill": {
     "duration": 0.047321,
     "end_time": "2024-10-18T07:25:46.095140",
     "exception": false,
     "start_time": "2024-10-18T07:25:46.047819",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [],
   "source": [
    "# MIN-MAX SCALLING \n",
    "sub_airline <- sub_airline %>%\n",
    "   mutate(ArrScaled = (ArrDelay - min(ArrDelay, na.rm=TRUE)) / (max(ArrDelay,na.rm=TRUE) - min(ArrDelay,na.rm=TRUE)))# mutate: create a modify columns within a dataframe\n",
    "\n",
    "sub_airline <- sub_airline %>%\n",
    "   mutate(DepScaled = (DepDelay - min(DepDelay, na.rm=TRUE)) / (max(DepDelay,na.rm=TRUE) - min(DepDelay,na.rm=TRUE)))"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 11,
   "id": "906ec1ee",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2024-10-18T07:25:46.123151Z",
     "iopub.status.busy": "2024-10-18T07:25:46.121398Z",
     "iopub.status.idle": "2024-10-18T07:25:46.144345Z",
     "shell.execute_reply": "2024-10-18T07:25:46.142443Z"
    },
    "papermill": {
     "duration": 0.040733,
     "end_time": "2024-10-18T07:25:46.147770",
     "exception": false,
     "start_time": "2024-10-18T07:25:46.107037",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [],
   "source": [
    "# Z-SCORE\n",
    "sub_airline <- sub_airline %>%\n",
    "  mutate(zs_ArrDelay = ((ArrDelay - mean(ArrDelay,na.rm=TRUE))/sd(ArrDelay, na.rm=TRUE)))\n",
    "\n",
    "sub_airline <- sub_airline %>%\n",
    "  mutate(zs_DepDelay = ((DepDelay - mean(DepDelay,na.rm=TRUE))/sd(DepDelay, na.rm=TRUE)))"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 12,
   "id": "aa19cac9",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2024-10-18T07:25:46.175541Z",
     "iopub.status.busy": "2024-10-18T07:25:46.173608Z",
     "iopub.status.idle": "2024-10-18T07:25:46.235111Z",
     "shell.execute_reply": "2024-10-18T07:25:46.232335Z"
    },
    "papermill": {
     "duration": 0.078645,
     "end_time": "2024-10-18T07:25:46.238314",
     "exception": false,
     "start_time": "2024-10-18T07:25:46.159669",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A tibble: 6 × 25</caption>\n",
       "<thead>\n",
       "\t<tr><th scope=col>Month</th><th scope=col>DayOfWeek</th><th scope=col>FlightDate</th><th scope=col>Reporting_Airline</th><th scope=col>Origin</th><th scope=col>Dest</th><th scope=col>CRSDepTime</th><th scope=col>CRSArrTime</th><th scope=col>DepTime</th><th scope=col>ArrTime</th><th scope=col>⋯</th><th scope=col>SecurityDelay</th><th scope=col>LateAircraftDelay</th><th scope=col>DepDelay</th><th scope=col>DepDelayMinutes</th><th scope=col>DivDistance</th><th scope=col>DivArrDelay</th><th scope=col>ArrScaled</th><th scope=col>DepScaled</th><th scope=col>zs_ArrDelay</th><th scope=col>zs_DepDelay</th></tr>\n",
       "\t<tr><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;date&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>⋯</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><td> 3</td><td>5</td><td>2003-03-28</td><td>UA</td><td>LAX</td><td>JFK</td><td>2210</td><td>0615</td><td>2209</td><td>0617</td><td>⋯</td><td>0.7262873</td><td>12.66667</td><td>-1</td><td>0</td><td>NA</td><td>NA</td><td>0.09933775</td><td>0.02409639</td><td>-0.04815631</td><td>-0.28063352</td></tr>\n",
       "\t<tr><td>11</td><td>4</td><td>2018-11-29</td><td>AS</td><td>LAX</td><td>JFK</td><td>1045</td><td>1912</td><td>1049</td><td>1851</td><td>⋯</td><td>0.7262873</td><td>12.66667</td><td> 4</td><td>4</td><td>NA</td><td>NA</td><td>0.06887417</td><td>0.03078983</td><td>-0.60922513</td><td>-0.14031185</td></tr>\n",
       "\t<tr><td> 8</td><td>5</td><td>2015-08-28</td><td>UA</td><td>LAX</td><td>JFK</td><td>0805</td><td>1634</td><td>0757</td><td>1620</td><td>⋯</td><td>0.7262873</td><td>12.66667</td><td>-8</td><td>0</td><td>NA</td><td>NA</td><td>0.07814570</td><td>0.01472557</td><td>-0.43846505</td><td>-0.47708387</td></tr>\n",
       "\t<tr><td> 4</td><td>7</td><td>2003-04-20</td><td>DL</td><td>LAX</td><td>JFK</td><td>2205</td><td>0619</td><td>2212</td><td>0616</td><td>⋯</td><td>0.7262873</td><td>12.66667</td><td> 7</td><td>7</td><td>NA</td><td>NA</td><td>0.09271523</td><td>0.03480589</td><td>-0.17012779</td><td>-0.05611884</td></tr>\n",
       "\t<tr><td>11</td><td>3</td><td>2005-11-30</td><td>UA</td><td>LAX</td><td>JFK</td><td>0840</td><td>1653</td><td>0836</td><td>1640</td><td>⋯</td><td>0.7262873</td><td>12.66667</td><td>-4</td><td>0</td><td>NA</td><td>NA</td><td>0.07947020</td><td>0.02008032</td><td>-0.41407075</td><td>-0.36482653</td></tr>\n",
       "\t<tr><td> 4</td><td>1</td><td>1992-04-06</td><td>UA</td><td>LAX</td><td>JFK</td><td>1450</td><td>2308</td><td>1452</td><td>2248</td><td>⋯</td><td>0.7262873</td><td>12.66667</td><td> 2</td><td>2</td><td>NA</td><td>NA</td><td>0.07019868</td><td>0.02811245</td><td>-0.58483083</td><td>-0.19644052</td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A tibble: 6 × 25\n",
       "\\begin{tabular}{lllllllllllllllllllll}\n",
       " Month & DayOfWeek & FlightDate & Reporting\\_Airline & Origin & Dest & CRSDepTime & CRSArrTime & DepTime & ArrTime & ⋯ & SecurityDelay & LateAircraftDelay & DepDelay & DepDelayMinutes & DivDistance & DivArrDelay & ArrScaled & DepScaled & zs\\_ArrDelay & zs\\_DepDelay\\\\\n",
       " <dbl> & <dbl> & <date> & <chr> & <chr> & <chr> & <chr> & <chr> & <chr> & <chr> & ⋯ & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl>\\\\\n",
       "\\hline\n",
       "\t  3 & 5 & 2003-03-28 & UA & LAX & JFK & 2210 & 0615 & 2209 & 0617 & ⋯ & 0.7262873 & 12.66667 & -1 & 0 & NA & NA & 0.09933775 & 0.02409639 & -0.04815631 & -0.28063352\\\\\n",
       "\t 11 & 4 & 2018-11-29 & AS & LAX & JFK & 1045 & 1912 & 1049 & 1851 & ⋯ & 0.7262873 & 12.66667 &  4 & 4 & NA & NA & 0.06887417 & 0.03078983 & -0.60922513 & -0.14031185\\\\\n",
       "\t  8 & 5 & 2015-08-28 & UA & LAX & JFK & 0805 & 1634 & 0757 & 1620 & ⋯ & 0.7262873 & 12.66667 & -8 & 0 & NA & NA & 0.07814570 & 0.01472557 & -0.43846505 & -0.47708387\\\\\n",
       "\t  4 & 7 & 2003-04-20 & DL & LAX & JFK & 2205 & 0619 & 2212 & 0616 & ⋯ & 0.7262873 & 12.66667 &  7 & 7 & NA & NA & 0.09271523 & 0.03480589 & -0.17012779 & -0.05611884\\\\\n",
       "\t 11 & 3 & 2005-11-30 & UA & LAX & JFK & 0840 & 1653 & 0836 & 1640 & ⋯ & 0.7262873 & 12.66667 & -4 & 0 & NA & NA & 0.07947020 & 0.02008032 & -0.41407075 & -0.36482653\\\\\n",
       "\t  4 & 1 & 1992-04-06 & UA & LAX & JFK & 1450 & 2308 & 1452 & 2248 & ⋯ & 0.7262873 & 12.66667 &  2 & 2 & NA & NA & 0.07019868 & 0.02811245 & -0.58483083 & -0.19644052\\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A tibble: 6 × 25\n",
       "\n",
       "| Month &lt;dbl&gt; | DayOfWeek &lt;dbl&gt; | FlightDate &lt;date&gt; | Reporting_Airline &lt;chr&gt; | Origin &lt;chr&gt; | Dest &lt;chr&gt; | CRSDepTime &lt;chr&gt; | CRSArrTime &lt;chr&gt; | DepTime &lt;chr&gt; | ArrTime &lt;chr&gt; | ⋯ ⋯ | SecurityDelay &lt;dbl&gt; | LateAircraftDelay &lt;dbl&gt; | DepDelay &lt;dbl&gt; | DepDelayMinutes &lt;dbl&gt; | DivDistance &lt;dbl&gt; | DivArrDelay &lt;dbl&gt; | ArrScaled &lt;dbl&gt; | DepScaled &lt;dbl&gt; | zs_ArrDelay &lt;dbl&gt; | zs_DepDelay &lt;dbl&gt; |\n",
       "|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|\n",
       "|  3 | 5 | 2003-03-28 | UA | LAX | JFK | 2210 | 0615 | 2209 | 0617 | ⋯ | 0.7262873 | 12.66667 | -1 | 0 | NA | NA | 0.09933775 | 0.02409639 | -0.04815631 | -0.28063352 |\n",
       "| 11 | 4 | 2018-11-29 | AS | LAX | JFK | 1045 | 1912 | 1049 | 1851 | ⋯ | 0.7262873 | 12.66667 |  4 | 4 | NA | NA | 0.06887417 | 0.03078983 | -0.60922513 | -0.14031185 |\n",
       "|  8 | 5 | 2015-08-28 | UA | LAX | JFK | 0805 | 1634 | 0757 | 1620 | ⋯ | 0.7262873 | 12.66667 | -8 | 0 | NA | NA | 0.07814570 | 0.01472557 | -0.43846505 | -0.47708387 |\n",
       "|  4 | 7 | 2003-04-20 | DL | LAX | JFK | 2205 | 0619 | 2212 | 0616 | ⋯ | 0.7262873 | 12.66667 |  7 | 7 | NA | NA | 0.09271523 | 0.03480589 | -0.17012779 | -0.05611884 |\n",
       "| 11 | 3 | 2005-11-30 | UA | LAX | JFK | 0840 | 1653 | 0836 | 1640 | ⋯ | 0.7262873 | 12.66667 | -4 | 0 | NA | NA | 0.07947020 | 0.02008032 | -0.41407075 | -0.36482653 |\n",
       "|  4 | 1 | 1992-04-06 | UA | LAX | JFK | 1450 | 2308 | 1452 | 2248 | ⋯ | 0.7262873 | 12.66667 |  2 | 2 | NA | NA | 0.07019868 | 0.02811245 | -0.58483083 | -0.19644052 |\n",
       "\n"
      ],
      "text/plain": [
       "  Month DayOfWeek FlightDate Reporting_Airline Origin Dest CRSDepTime\n",
       "1  3    5         2003-03-28 UA                LAX    JFK  2210      \n",
       "2 11    4         2018-11-29 AS                LAX    JFK  1045      \n",
       "3  8    5         2015-08-28 UA                LAX    JFK  0805      \n",
       "4  4    7         2003-04-20 DL                LAX    JFK  2205      \n",
       "5 11    3         2005-11-30 UA                LAX    JFK  0840      \n",
       "6  4    1         1992-04-06 UA                LAX    JFK  1450      \n",
       "  CRSArrTime DepTime ArrTime ⋯ SecurityDelay LateAircraftDelay DepDelay\n",
       "1 0615       2209    0617    ⋯ 0.7262873     12.66667          -1      \n",
       "2 1912       1049    1851    ⋯ 0.7262873     12.66667           4      \n",
       "3 1634       0757    1620    ⋯ 0.7262873     12.66667          -8      \n",
       "4 0619       2212    0616    ⋯ 0.7262873     12.66667           7      \n",
       "5 1653       0836    1640    ⋯ 0.7262873     12.66667          -4      \n",
       "6 2308       1452    2248    ⋯ 0.7262873     12.66667           2      \n",
       "  DepDelayMinutes DivDistance DivArrDelay ArrScaled  DepScaled  zs_ArrDelay\n",
       "1 0               NA          NA          0.09933775 0.02409639 -0.04815631\n",
       "2 4               NA          NA          0.06887417 0.03078983 -0.60922513\n",
       "3 0               NA          NA          0.07814570 0.01472557 -0.43846505\n",
       "4 7               NA          NA          0.09271523 0.03480589 -0.17012779\n",
       "5 0               NA          NA          0.07947020 0.02008032 -0.41407075\n",
       "6 2               NA          NA          0.07019868 0.02811245 -0.58483083\n",
       "  zs_DepDelay\n",
       "1 -0.28063352\n",
       "2 -0.14031185\n",
       "3 -0.47708387\n",
       "4 -0.05611884\n",
       "5 -0.36482653\n",
       "6 -0.19644052"
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "head(sub_airline)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 13,
   "id": "9ab98d57",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2024-10-18T07:25:46.267135Z",
     "iopub.status.busy": "2024-10-18T07:25:46.265431Z",
     "iopub.status.idle": "2024-10-18T07:25:47.573187Z",
     "shell.execute_reply": "2024-10-18T07:25:47.570244Z"
    },
    "papermill": {
     "duration": 1.325712,
     "end_time": "2024-10-18T07:25:47.576675",
     "exception": false,
     "start_time": "2024-10-18T07:25:46.250963",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "image/png": "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\nTSuXWNJQ9d6Nl5z1nUMO2G6LjQf1qyjsueZ3L/7v0lfMyW/mR1zcwslrLdmiR0EI4am35rSy\nzpWXXXrJJZf8p6ohZLcHOj7hPv2Kl1jSc+OdQghz3nyj6cssd1FobvcuapkHQJu2t2JkxTI3\nrXW5hUMHFqSTpPEv06paX/Odf3wcQui/W/9FF7aysW09LJewzE3L/ifSip556UU/6mC3+z7M\n5lqFlXsdtVrJtJdPanr9fvUXN982rar/ducvfZ5mSzr+g+vISNnvunUO//Npm/WZ+/YX5YOP\n+fuxGy9zjLbuz8baD8aO/tHcxszqu/3yb+M3asdNpXLLNt1pn5+edclDz7/7/pN/3rZXUe2c\nl8aNvTWEUDvr4RBCUe99lrhKTl7vNddcc0Dvgjb9roXFj/bGmnffrWlorJ9WmLPkB2Zsdfmr\nIYQ5r7V2FwcrC588sWyla379wTc/e/b+2/5+zwOPPv7ks4/+45l/3XXRL078+sm33nnuvs1d\no8W330ilUyGETF0mydSEEFJLvaNBKpVu5moh5C5+8uP0F67bYocfTZlX33vYpjtutcX2Xzt4\n6DrrbTB48hZbXti2bcvO7oesdco5L73ym6fCmG80u0LNzHvGH/uTVCr11g+OCSFkswc6PtXS\nf/5SOfkhhCRTF9q4i3JbPrc0ZHUAtGF7m5Z0SCr3lCEV41+bfsWN/xv305EtrZU0zpn43Bch\nhL0PW3vR5a1sbFsPyyVXa3XTOuugPeTwI+Y3frU/1x9YkuUVjz1u3etPfm7C05/dtH3/t647\nP4Sw5y9HZ/99O+EH196R2rTrMg0zXvmoKoRQ9cn9/6mqH9XCmewLtXV/XnnQ9g98UV1YOfrh\nOyYssUdauqmfjTv4neqGy2+6pd9S/2BbY+tv3fHQc302vuCzf58XwrcXHIHpVn4f23bfsujR\nniT1IYTcwrUmHPetZm9htS37tPx9YaUh7LKTyt9894M33/3gEEJj9ecP3Xrdt4/6+V2/2v+m\n4+cf0qdoiXXze2yZTqVqZv6zMYQl/h5OmfxZCGHABhX5pZuFEGpmPRzCxEVXqJn9r2zGGb/X\ncVPm1R9/07MXHrzZwoVz3vt32zcsK8PHH5M693tTH/7hM3P32aJHM5/8895fzwshFPc9bGhh\nOmS3Bzo+1V2fVe1UXrDoklmv/SuEUDJoROj0XdTqAbB8tndR+17y9fG7TnrprO9M+fHTgwub\nr65Xr/3Wy/Pqinrv/fO1y7O82Q4elq3rrJ/I5ddd374Bhh11cjj5G/866f7w1OGXXfpGOr//\nLzfs3b6b6ixZjtSmXXfv8Tv//dP5o7416sWbX9zngCs+vO+41mdo0/58/YZDjr3z/VRO0fmP\n3Ln0W+20dFOfPXDXrZ/O3+7iqmMHNvOWKCUDNg1f/uMhv2yrEK6qnvZQCPstuk5D9Ru3/O35\ngrKt99+1/b9ruYVD+uSlZ2Sqzv3lL1eONwmEdvFU7DJUff7HYcOGbbjV/y1cki7qu9thp1w6\nrDJJkgdm1ix9lXThkHH9ihuq3znp6c8WXd5Q/db/vTAtlZN/wvDKvNJR3+hdXDv7sWs/XOxt\nOZ//1V+WOVLSOPsvn1flFqyx6L18CGHOW6+1bduyVtL/qPO26NtYP23fvU6bs9TbATdUv3H4\nhKdCCJudelLTkmz2QMen+tsJ/1h8QXLZsU+GEDY5Yf1O3EXZHADLZ3sXNXDMNYesXVY397kd\n9jtjZkMzj2F89sRVOx57fwjhO3/57dJPWrWkI4dl65b/Qbu0ot4HHtK3+IsXTvzw83uv/3R+\n381/0zP7XdN9I7Vp10178fz9rvhP5Ygf/ftPTx+9TsVH9x8//u6snqrOxtz3bxl99C0hhDHn\nPDx+ZM/sr3j4nquHEM474qpmH6h/7YZLQggVI44OIRT3OXiDkrz5n1x997TqRdeZ8ucffPvb\n3/7ZzR916HctlXfS8IrGus9P/ffni1+QOWajIf37979zejP357DSEXbLUFi526z33/3vM5f+\n/M6vXtEy7dV/nPHu7FQqd9wiL/NKGr96fcbpl3w9hHD5nvve8/qCF3w0zJ/ys6/t9FFtw6A9\nrt6iR14I4ddX7B9COHHX8a/PWfCB31MevGj/a98KIYRUaz+XVLrH2oXpxroPb3h15sKFz956\n4S77/yOE0NjqWw2327H33TGyJO/Tx3+zzrYH3/b4a1++E2jjKw//ee8Ntnxmbl3Janvc9sMR\nC9fPZg900Ad3H/mDqx5qmiRpmH3DhDHnvTEzv3TUtXsM6sRdlOUB0LnbO/OVB2+77bY7736h\nxTVS+dc+edPwkryP7jtn2Kb7/O7ef8/PLMi7uR/99+pTD1tnx2Om1zduPv4Pl+80oE3fut2H\nZeu65aBd2oSjhzfWfT725B+HEHb+9c7L55u2bpkjZb/rMnUfH7TL6Zl0j2sfOi8vJ/83D11d\n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\nAACREHYAAJEQdgAAkRB2AACREHYAAJEQdgAAkRB2AACREHYAAJEQdgAAkRB2AACREHYAAJEQ\ndgAAkRB2AACREHYAAJEQdgAAkRB2AACREHYAAJEQdgAAkRB2AACREHYAAJEQdgAAkRB2AACR\nEHYAAJEQdgAAkRB2AACREHYAAJEQdgAAkRB2AACREHYAAJEQdgAAkRB2AACREHYAAJEQdgAA\nkRB2AACREHYAAJEQdgAAkRB2AACREHYAAJEQdgAAkRB2AACREHYAAJEQdgAAkRB2AACREHYA\nAJEQdgAAkRB2AACREHYAAJHI7e4BulZjY2MIob6+vrsHiUGSJCGExsZG+7PjGhsbkySxJzuR\nI7NTODI7S9MdZgihoaGheyeJQyaTCf6aLyIvL6+liyIPu5qamiRJ5syZ092DxKDpfqq2trau\nrq67Z4mBI7NzVVdXV1dXd/cUkXBkdqKqqqruHiEGTX+AhF2TdDpdUVHR0qWRh11JScmcOXN6\n9erV3YPEYMaMGSGE4uLi4uLi7p5lpVdbW1tVVVVZWdndg8Rg2rRpIYTS0tKCgoLunmWlV11d\nXV9fX1ZW1t2DrPQymUzTfWZZWVkrD66QpXnz5oUQSktLu3uQlYDX2AEARELYAQBEQtgBAERC\n2AEARELYAQBEQtgBAERC2AEARELYAQBEQtgBAERC2AEARELYAQBEQtgBAERC2AEARELYAQBE\nQtgBAERC2AEARELYAQBEQtgBAERC2AEARELYAQBEQtgBAERC2AEARELYAQBEQtgBAERC2AEA\nRELYAQBEQtgBAERC2AEARELYAQBEQtgBAERC2AEARELYAQBEQtgBAERC2AEARELYAQBEQtgB\nAERC2AEARELYAQBEQtgBAERC2AEARELYAQBEQtgBAERC2AEARELYAQBEQtgBAERC2AEARELY\nAQBEQtgBAERC2AEARELYAQBEQtgBAERC2AEARELYAQBEQtgBAERC2AEARELYAQBEQtgBAERC\n2AEARELYAQBEQtgBAERC2AEARELYAQBEQtgBAERC2AEARELYAQBEQtgBAERC2AEARELYAQBE\nQtgBAERC2AEARELYAQBEQtgBAERC2AEARELYAQBEQtgBAERC2AEARELYAQBEQtgBAERC2AEA\nRELYAQBEQtgBAERC2AEARELYAQBEQtgBAERC2AEARELYAQBEQtgBAERC2KwyN9AAACAASURB\n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\nc3LLDjvz9t8fOqRrZgMAoA3a8Fmxm3/nV+8eevxDd9/38psfzG9Mr7bmiJ322mt4r4KuGw4A\ngOy17SPF3nl88pNPv/D6m2+t9b2fHLF3j08/md1FYwEA0FbZP2KXXHnk6PGTnmz6ovj0S/ee\nd+lOo/6x/Xcve/Ca8bnNnC8LAMByle0jdv/70wHjJz05ZvzFL7/9cdOSymHnnfv9rR+59ph9\nrn6jy8YDACBb2Ybd2Sc80HPdkx+8/CcbDh3QtCS3eMTJVz/xi5G9Hpl4VpeNBwBAtrINu1un\nVQ854pCll+8/bnDN9Ls6dSQAANoj27BboyA99+05Sy+f+ersdMGATh0JAID2yDbsTtmy7zt/\nHPf0tJpFF1ZNffjIW6b0HnVSFwwGAEDbZBt2B9zy2zVSH+yw9sY/mHBmCOHVm28466dHrDds\n9w8y/S/76ze7ckIAALKSbdgV9dnrxZf/fuDmOdddODGEMPm0E8644I89thp7+4uvHNi/pAsH\nBAAgO1m+j12mtra+aOieNz285/VfvPvq/6Y2pItWH7b+6hU+dgIAYEWRVdgljXMriiu3vOnt\nyQcNKeqz9mZ91u7qsQAAaKusnopNpctPWLfnlBue7eppAABot2w/Uuz0x+55adu9x19adOYP\nvtarIN2lM9FdJk5s7dLq6qIndsk7Z3JeXl77bwQA6DrZht3Xvnlqpt8aVx23/1XHF/br36cw\nb7GH+t59990umA0AgDbINuwKCwtDGLD33t6LGABgBZVt2N11l88NAwBYobV28sSgQYN2/tnz\ny20UAAA6orWw++ijjz6dVbfokry8vA3HP93FIwEA0B7ZfvJEk4aGhoZM0kWjAADQEW0LOwAA\nVljCDgAgEsIOACASwg4AIBLLeB+7Ga/85ZJLnml9SQjhJz/5SSfPBQBAGy0j7D578uLjnlzG\nkiDsAABWAK2F3R133LHc5gAAoINaC7t99913uc0BAEAHOXkCACASwg4AIBLCDgAgEsIOACAS\nwg4AIBLCDgAgEsIOACASwg4AIBLCDgAgEsIOACASwg4AIBLCDgAgEsIOACASwg4AIBLCDgAg\nEsIOACASwg4AIBLCDgAgEsIOACASwg4AIBLCDgAgEsIOACASwg4AIBLCDgAgEsIOACASwg4A\nIBLCDgAgEsIOACASwg4AIBLCDgAgEsIOACASwg4AIBLCDgAgEsIOACASwg4AIBLCDgAgEsIO\nACASwg4AIBLCDgAgEsIOACASwg4AIBLCDgAgEsIOACASwg4AIBLCDgAgEsIOACASwo42OKrq\nse4eAQBoUe5y/n6Tfnh44ZlXf6tP0ZcLMpNvvvKuR1/4cG56xAZbHPHjIwcX5y7rolauAgCw\n6lqej9glbz923e1TZzUkycJFU2477aJbntrqgO+dcdy40v89dOrx12SWdVErVwEAWJUtp8e6\nPn/q4pMue3z6vLrFliZ1F97y+pCDzx+7y5AQwtDzUmPHnfenj484bGBJixcNyGvxKgAAq7bl\n9IhdxfpjTz3zV+f/+qRFF9bOfvSDmsZddx3Y9GVBxehRpfnPT/60lYtauQoAwCpuOT1il182\ncGhZaKwrXHRh3fxXQgjrFectXLJuce4/X5kdDm3xorodW7xKs+rr60MI1dXVnbgtEWtoyFvm\nOplMpqGhoZUVqqvrO2+iaDU0NCRJ4sjsRHV1dZmM12V0VH19fSaTcWR2XPLli45qa2tbv88k\nG42NjcFf8y+lUqnCwsKWLu3O0w4ytfNDCL1yv3rUsHdeumFeTSsXtXKVZtXV1SVJMn/+/C4Y\nP0J1dcXLXKexsbHpF6wl8+dXdd5EkXNkdqLa2tra2truniISQqQT1dS0+BeKtmp6sIZ0Or2C\nhl1OflEIYWZDpjSdbloyvb4xXZHfykWtXKVZqVQqhJD+cmVal5PT2lPzTQ+HpFKppr3aEns7\nG0mSJEnS+g4nS03/0sjJyWn9yCQbjsxO5MjsRE1/gByZTVrfD90ZdnklI0N49M3qhkEFC1Lg\n7eqG8tEVrVzUylWaVVxcPGfOnMrKyi7elEi0/A+AEL58DDw3Nzcvr7VnbCsrW70VQggh1NbW\nVlVVOTI7xbRp00IIJSUlBQUF3T3LSq+6urq+vr6srKy7B1npZTKZGTNmhBB69OjR+n0m2Zg3\nb14IobS0tLsHWQl0Z/wWVuw0ID993+OfN31ZP/+lZ+bWbbLLaq1c1MpVAABWcd36qGYqf8I3\nRrwzaeKDz7/5yZT/3vDzC4r7jxm3emlrF7VyFQCAVVs3f2bD0IPO/lHtxTdf9PPpNakhG+1w\n9pnfy1nWRa1cBQBgVZZKFvkciPjU19fPmTOnV69e3T3IymHixNYura6uHr7N7v975qHWXy/S\n+o3QxGvsOlHTa+x69OjhNXYd5zV2nWXha+zKy8u9xq7jvMYuex7tAgCIhLADAIiEsAMAiISw\nAwCIhLAjW7uuds6o+ve7ewoAoEXCDgAgEsIOACASwg4AIBLCDgAgEsIOACASwg4AIBLCDgAg\nEsIOACASwg4AIBLCDgAgEsIOACASwg4AIBLCDgAgEsIOACASwg4AIBLCDgAgEsIOACASwg4A\nIBLCDgAgEsIOACASwg4AIBLCDgAgEsIOACASwg4AIBLCDgAgEsIOACASwg4AIBLCDgAgEsIO\nACASwg4AIBK53T0AnWbixI7ewuTJYccdOz4IANA9PGIHABAJYQcAEAlhBwAQCWEHABAJYQcA\nEAlhBwAQCWEHABAJYQcAEAlhBwAQCWEHABAJYQcAEAlhBwAQCWEHABAJYQcAEAlhBwAQCWEH\nABAJYQcAEAlhBwAQCWEHABAJYQcAEAlhBwAQCWEHABAJYQcAEAlhBwAQCWEHABAJYQcAEAlh\nBwAQCWEHABAJYQcAEAlhBwAQCWEHABAJYQcAEAlhBwAQCWEHABAJYQcAEAlhBwAQCWEHABAJ\nYQcAEAlhBwAQCWEHABAJYQcAEAlhBwAQCWEHABAJYQcAEAlhBwAQCWEHABAJYQcAEAlhBwAQ\nCWEHABAJYQcAEAlhBwAQCWEHABAJYQcAEAlhBwAQCWEHABAJYQcAEAlhBwAQCWEHABAJYQcA\nEAlhBwAQCWEHABAJYQcAEAlhBwAQCWEHABAJYQcAEAlhBwAQCWEHABAJYQcAEAlhBwAQCWEH\nABAJYQcAEAlhBwAQCWEHABAJYQcAEAlhBwAQCWEHABAJYQcAEInc7h6ga2UymRBCY2Njdw+y\nPCRJxzM9lSTJsr5L0vo6jY2ZDo8Rv1XqyFw+MpmM/dlxmUwmSRJ7suOafseDI7OTNP3dsSeb\npFKpnJwW/+JHHnbV1dVJksycObO7B1keqquLO3gL9fV51dX1LV2alCchhIaGhoaGhlZuZObM\nqg6OsepYRY7M5WP+/Pnz58/v7iki4cjsRHPnzu3uEeJRW1vb3SOsENLpdGVlZUuXRh52xcXF\nc+fO7dmzZ3cPsjwUF6c6eAt5eaG4OK+lS1OpVAghLy8vL6/FdUIIvXoVdXCMVUFtbW11dXVF\nRUV3DxKD6dOnhxBKS0sLCgq6e5aVXnV1dUNDQ48ePbp7kJVeJpNp6uOysrLW7zPJRtM/20pK\nSrp7kJVA5GHX1CJN/2X5sLez4cjsdKlUyv7sOEdmZ1m4Dx2ZnciezIaTJwAAIiHsAAAiIewA\nACIh7AAAIiHsAAAiIewAACIh7AAAIiHsAAAiIewAACIh7AAAIiHsAAAiIewAACIh7AAAIiHs\nAAAiIewAACKR290DEJXJk8PEiR29kY7fAgCsmjxiBwAQCWEHABAJYQcAEAlhBwAQCWEHABAJ\nYQcAEAlhBwAQCWEHABAJYQcAEAlhBwAQCWEHABAJYQcAEAlhBwAQCWEHABAJYQcAEAlhBwAQ\nCWEHABAJYQcAEAlhBwAQCWEHABAJYQcAEAlhBwAQCWEHABAJYUcb9G+c3d0jAAAtEnYAAJEQ\ndgAAkRB2AACREHYAAJEQdgAAkRB2AACREHYAAJEQdgAAkRB2AACREHYAAJEQdgAAkRB2AACR\nEHYAAJEQdgAAkRB2AACREHYAAJEQdgAAkRB2AACREHZka3Dpo909AgDQGmEHABAJYQcAEAlh\nBwAQCWEHABAJYQcAEAlhBwAQCWEHABAJYQcAEAlhBwAQCWEHABAJYQcAEAlhBwAQCWEHABAJ\nYQcAEAlhBwAQCWEHABAJYQcAEAlhBwAQCWEHABAJYQcAEAlhBwAQCWEHABAJYQcAEAlhBwAQ\nCWEHABAJYQcAEAlhBwAQCWEHABAJYQcAEAlhBwAQCWEHABCJ3O4eABYzeXKYOLGjN9LxWwCA\nlZFH7GiD0qRmTN+zunsKAKB5wg4AIBLCDgAgEsIOACASwg4AIBLCDgAgEsIOACASwg4AIBLC\nDgAgEsIOACASwg4AIBI+K3aF0CmfbTp5cthxx064ndatXfLIozO7/LsAAO3gETsAgEgIOwCA\nSHgqljbI5DR09wjLNnlyJzy13SlPjgPAcuYROwCASAg7AIBICDsAgEgIOwCASDh5ApbUKadf\nBGdgALDcecSOtqnMe3/HXhO7ewoAoBnCjjZbq3hyd48AADRjZXwqNjP55ivvevSFD+emR2yw\nxRE/PnJw8cq4FSuxirz3duw1cfL0id09yAqt9edzGxtz6+uLCguXcSOezAWgTVa+R+ym3Hba\nRbc8tdUB3zvjuHGl/3vo1OOvyXT3SKuCHXtNrMx/v7unAABas7I91pXUXXjL60MOPn/sLkNC\nCEPPS40dd96fPj7isIEl3T0ZrHCcAgKwqlnJwq529qMf1DT+cNeBTV8WVIweVXrx85M/PezQ\nId072Kpm4/JJaxVPnvTh5O4eJGYdPzl38uSw446dMks3a30/VFUVhxAKCnLT6fbfCEAcVrKw\nq5v/SghhveK8hUvWLc795yuzw6HNr19VVZUkyfTp05fPeO1WXV3c8RtpaMirrq7voltoaGgI\nSUhSmZrCWQU15SGE8tx3xw3c/pp37mv2FnZd7ZwQwgOfntqJM6xEt5DNjSRJUl1d3aVjdPwW\nnniiE25h2207ujOzuZG6urrWV5g+vaqDY6wKkiQJIaz495krkTlz5nT3CDFoOjJra2u79Luc\nd14n/C0+8cQuv6tJp9MVFRUtXZpq2lkri9lTzjrsuGdvuv3O0nSqacmDPzx0Us74P16xTbPr\nz5o1q6Ghyz+3PstD4YDtBwxomFfe0Dg7d8EDCwv/P0lCRWMzy9v0/0kSUqllr9/KCrPS6VSq\n/QN0yoa0b4bFFtY3zs5bHntyee7MbtuQrtyZ0WxIS/+/Av5+dXxnriAbEsnv1/LamavC71d3\nbcjrheV/e3RqWMTyCbvKysqWLl3Jwm7uR+cf+qNHr/jr7YMKFuzWW777rXsqJtz4/+3de1hU\ndR7H8d9hmBsgjIDlDSvwQt6A3Kc10yzRxzJtrWzxUnlbsdIS0NTENdLMvJturGaLabmp3S+S\nrllJrrWmrZdUvFTiFVERBGYY5nL2j9EJgQHXcEZ+vF9/8HB+53eG73Oe7zN85jdnzsz7Q5Xz\nzWazxWIJCKiFDA7X8qdWq9XpdL6upc6z2+02m81oNPq6EBmUlJQIIfR6vb9/HXsL4gZks9mc\nTqder/d1IXWeqqpms1kIYTAYNNVfJYCr4FqS57+Pi6IoBs93Vahjz4PawA5CZB202N3B7rDF\nHtLV44KkVqu1WCz8+6wVFovFFew4n7+f1Wq12+2cyVrhCnY6nY44Uit4yVErnE6nK9jp9Xqt\nVlvjfFTP4XAIIejMq1HHbndiMN3XVKfZuDXPtWkr2bW9qOyOno19WxUAAMCNoI4FO6HoJgyI\nPvJW2pc7D57+5aeMafMDmsQ/2TzI12UBAAD4Xh17K1YI0TLh5Wesi9YsnHa+VImK6f7y9FF1\nLZwCAABcF3Uv2AlF02vo+F5DfV0GAADADYbVLgAAAEkQ7AAAACRBsAMAAJAEwQ4AAEASBDsA\nAABJEOwAAAAkQbADAACQBMEOAABAEgQ7AAAASRDsAAAAJEGwAwAA9IlpngAACx5JREFUkATB\nDgAAQBIEOwAAAEkQ7AAAACRBsAMAAJAEwQ4AAEASBDsAAABJEOwAAAAkQbADAACQBMEOAABA\nEgQ7AAAASRDsAAAAJEGwAwAAkATBDgAAQBIEOwAAAEkQ7AAAACRBsAMAAJCEoqqqr2u4vlRV\nVRTF11XIwN0qnM9aQWfWFldncjJrBSezFnEyaxEn8+rJH+wAAADqCd6KBQAAkATBDgAAQBIE\nOwAAAEkQ7AAAACRBsAMAAJAEwQ4AAEAS/r4uAHWC85s16Z9l/Xi8SBPd/s5hzw6PDKBz4D2q\n/cJHy5d9sW33+VK/JhGtHnriqd5xjYUQZ75LHTVrb/mZI1as6x9mEELQtPACzx3oqf1oS1x3\ntBRq9ssHUxeuzXl8zNgRDe3rl72emly2etkYFnvhNf96ZcLq/cHDEp+Lbhq4Z/O76WljLH9b\n2T8iqGBXgTGs37hR7dwzb2mgdf1C08ILPHWgp/ajLeEFBDvURC1bsPZA1KB5j/WMEkK0nKM8\n9uSc1SeHPdEs0NeVoV5wWI8v3Xmu+yvz+rVrKIRoFd3h9PaEj9N/6j+rc97+i6a2Xbp0aVfx\nGJoWXlF1B3pqv6Za2hJewEsF1MBamHWs1NGrVzPXpt7UNS5It/ObXN9WhfrDUXr0lttu6xMZ\nfHlAiQvR2wqKhRC7Llobxpkclou5eQXlv0KHpoV3VNmBntqPtoR3sGKHGpSV7BFCtA3Qukdu\nD/DfsKdQDPFdTahPdCHdFi3q5t60FWdnnCq+ZXgbIcR/i23q1sV/XpJtU1X/wEa9B48b3a+j\noGnhLVV2oKf2K7uXtoQ3EOxQA6e1RAgR5v/b4m64VmMvLvVdRai/cnZkLn4twxb5QOr9zR1l\nJ4s12lvDu8xePd2kFv0nM2Pu8qn6VquGRZtoWniBpw58WFd1+9GW8A6CHWrgpzMKIS7YnUEa\njWvkvM2hMel8WhTqnbILBzOWLP7iv/ndBzw9c3APg6IITbN169Zd3q/vljDx0IadX73507B5\nXWlaeIFGV3UHPppUdfvRlvAOrrFDDbSBHYQQBy1298hhiz2kvcl3FaHeKcrZPDZx8m4RM2f5\nipQh8QZFqXJa3M1G28WzgqaFj7g60FP70ZbwDoIdamAw3ddUp9m4Nc+1aSvZtb2o7I6ejX1b\nFeoP1WmeOSldH/9c+rTENuEG93jBoddH/mVMbpnz8oBzyymzqW1rQdPCKzx1oKf2oy3hHZq0\ntDRf14Abm6KJdu5e+8/14VHRxtLcNXPmntR3nT7knqrXTIDaZj7z1tIPDzzySHxJXu6py/Iu\nBLRo1XbburUf78pvfnOw+eyJTf+cn3nEmTJjaBOdhqaFF+hCIqvuQL2u6vajLeEViqqqNc9C\nPac6Nq1atHbT9vOlSlRM96dSRrUM5OpMeEnu1tTEOXsrDAZHTHnn9c7WC/tWLF39792HSzUN\nIlu17z8i8a4WQZdm0LS4/jx2oKf2oy1x/RHsAAAAJME1dgAAAJIg2AEAAEiCYAcAACAJgh0A\nAIAkCHYAAACSINgBAABIgmAHAAAgCYIdAACAJAh2AOoF1VF4m1GrKEpEr/ev+UHOH3hUuVKg\nqVH7rn1nZGx2XPWDLIxqGBDW95prAIBq8GUmAOqFvJ3jj5bahRCnv03Ktz8a6n/tX9EZ0fcv\nCdEmIYRQHRfycr79InPayPVvr5+5570pBl4sA/Apgh2AemFjSqaiKC+Pap36xsHxO/JWdL75\nmh8q8vHJcxOi3JtOW97sQV2nfJDad9GDX6bE1EaxAHCNeHUJQH6OshPJ288ENXtuXFqyEGLj\n+I3VTHbaCxw1jZTnp71p0rvbugTrs6YNKXbw7dsAfIlgB0B+p74el29zxvz1qcAmo+NNhrwf\nUk6VOctPWNEmrGHUQmvB9sfvbRukDy12qJVHqnl8P234whGtbCX7Xj1e5BopzslKGti7RSOT\nPjA0Oq7HS8synZ4PP/Dp6/3vvSM8JNBfZ2wS1XHoxMX5dlUIcSD9bkVRlpwsLjfXGd/QGNRk\nxDWfCgByI9gBkN/7E7Yoimb2wEghxEuP3eqwnU/+9nSFOU57/tDY+89E9HplcbrRT6lypBqR\nw2OEEFlbzgghSk59HHt7z/TPDsUnjJr2fGLHkJy0px7sNPStKg88vn5M+/7PbjkTMvzZSTOm\nPt+zpXPV3HGdh2UKISIHz/BTlGVz9rknXzw6+6uC0rgXJ17zqQAgORUApGYr2Wv0U0IiU12b\nhUdnCiEaxf6t/JyM1qGKovResrOaEVVVz+1/RAjRfc2Ryn/l4rGZQoiYyTtUVU1rF6YNuH3b\nOYt770cpsUKIl38uUFV1QaTJGPqge9fKduH+hhY5pXb3SHKzBsawfq7fk5o3MIb2ce/amBCl\n+Ol3FJX932cBQP3Aih0AyeV8kmxxqp2mD3NtBreYeEeQ7vzeyUdKr7xwTtGvGh1bw0h1FNcP\nu3nfjP350U+vvCvM4N7XZ9prQoi1fz9U+bABWw+eObW/hV7j2lSdJVZVVR1m12ZiakdLfuY/\ncktcu5I+OxbWflanIO1VVwWgfuFTsQAkl5H6gxAi4uf358+/lIfamfQ/Fhcl/evE5w/d4p6m\nC4q9SXvFa93KI9UoKzwghAhuE1ya/4lDVffOv1OZX3FO4d7CygcGmELzf9iwckPWvkM/5xw7\nemDP7pMFVoPp0t7IQTP8nolf8lr2yFmdzu2eeMBsG7wo4SpLAlAPEewAyMxauGX20YtCiJUv\nvlBh13eT1oiHJrk3Fb/AChMqj1Tjl5W7hBD3dL9Z+OmEEB0mZszt0bTCHH1IFet/H4yPf2zh\n183ievS7r3Pfu+8fPz3mZGKvsXnuQ+5Lah609B+vilnvfZn8ib++xeJuja++KgD1DcEOgMyO\nrHzBoar3vJG9ZVSb30ZVexdT0PeHXtxdkhITWAtva6r2/AnLD2kD20+OaGCw9dEoSfaCNr17\nd3FPsFuyP/h0d+OYgAoHlhV9n7Dw64g+S3M+T3QPrrhyzqipMQtGv//OySMp23KbP/BRmD+X\n0ADwiCcIADJbMGuP4qdfNCjyilHFf+7gSNVpTfk45/f/Cac9f8GTd2cVWrtPfydIo/gbWqa1\nDT389tDNuWb3nHfH/GnQoEHHKj3j2s3ZDlUNje3kHjGf3jb/ZJEQv91dJTJhpkZRJo/ud9bm\nGD6/2+8vGIDEWLEDIC3LufcyckvCOy6Iq/Rpg9hpz4mlT+/86woxZOb/+7C/vjvvhV2ui+Cc\nhWePZX3+yb4zllaPzPw8+dLXTiRlpi9vPeSBqPYPD3yoU6vQn75a+/amQx2Gvf3ETRVX7AIa\nDewZ9szXc/uO1U7o1Dzgl33fv7n006jGhrLjPy5e/d7IQQMC/RRdyD3JEQ3mrc82mHpMbWkS\nAFANX38sFwCulx1TYoQQAzefqHLvw+FGRdF8W2hVVTWjdajBFF9+b+UR9fLtTsozNgi9/a4+\nL725yX7lzIKDG0b3797YFKQLCI2O7fri8i9szku7KtzupPjYl0Pv/2OzsMDgxpH3Pvj4Z/vy\nz+6Yc2vDAF1QoxPWS4+a/UZXIUTMCz/8jpMBoF5QVJUvwAGAG9qOKbF3vrrno7PmP5W7hQoA\nVEawA4AbmtN27q6wZtkNxxbmVLqBCgBciWvsAODG9cyz482HP9xeVDbywxRf1wKgDmDFDgBu\nXO1uavCrPWTA2EWrpg/wdS0A6gCCHQAAgCS4jx0AAIAkCHYAAACSINgBAABIgmAHAAAgCYId\nAACAJAh2AAAAkiDYAQAASIJgBwAAIAmCHQAAgCT+B/dSex4aqW6DAAAAAElFTkSuQmCC"
     },
     "metadata": {
      "image/png": {
       "height": 420,
       "width": 420
      }
     },
     "output_type": "display_data"
    }
   ],
   "source": [
    "library(ggplot2)\n",
    "\n",
    "ggplot(sub_airline, aes(x=ArrDelay)) +\n",
    "       geom_histogram(binwidth=25, fill=\"blue\", alpha=0.5) +\n",
    "       geom_histogram(aes(x=ArrScaled), binwidth=0.5, fill = \"green\", alpha=0.5) +\n",
    "       geom_histogram(aes(x=zs_ArrDelay), binwidth=0.5, fill =\"orange\", alpha=0.5) +\n",
    "       labs(title = \"Histogram Comparison: Original - Min_Max - Z-Score\",\n",
    "           x = 'ArrDelay',\n",
    "           y = 'Frequency') +\n",
    "       theme_minimal()"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "82c7dee7",
   "metadata": {
    "papermill": {
     "duration": 0.012982,
     "end_time": "2024-10-18T07:25:47.603701",
     "exception": false,
     "start_time": "2024-10-18T07:25:47.590719",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "#### How did the distribution of the data change after each normalization technique?\n",
    "1. Original Data Distribution\n",
    "Range: The data can have any range, depending on the dataset.\n",
    "Mean and Standard Deviation: The mean and spread (standard deviation) of the data will vary naturally depending on the dataset's original distribution (e.g., normal, skewed).\n",
    "Shape: The shape of the distribution is untouched in the original dataset.\n",
    "2. Min-Max Scaling\n",
    "Range: After min-max scaling, the values are transformed to fall within a specific range, usually between 0 and 1. The minimum value in the original data becomes 0, and the maximum becomes 1.\n",
    "Effect on Mean and Standard Deviation: The mean and standard deviation will change, but the shape of the distribution remains the same.\n",
    "Shape: The distribution's shape remains unchanged. This scaling only adjusts the range of values without altering the relationships between the data points.\n",
    "Key Points:\n",
    "Maintains the relative distances between values but compresses them into a [0,1] range.\n",
    "Useful when you want to maintain the original distribution but rescale it to a fixed range.\n",
    "3. Z-Score Normalization\n",
    "Range: Z-score normalization rescales the data such that the mean of the distribution is 0 and the standard deviation is 1. Most values will fall between -3 and +3 (depending on the spread of the original data).\n",
    "Effect on Mean and Standard Deviation: After z-score normalization, the mean of the data will be 0, and the standard deviation will be 1.\n",
    "Shape: Like min-max scaling, the shape of the distribution doesn't change. It only standardizes the values relative to the original mean and standard deviation.\n",
    "Key Points:\n",
    "Centered around 0, with a standard deviation of 1.\n",
    "The distribution's shape is preserved but scaled to have a mean of 0 and standard deviation of 1.\n",
    "#### Which normalization technique seems most appropriate for this data, and why?\n",
    "min-max scaling, because we need to keep all data points within a specific range for models sensitive to magnitude.\n",
    "#### How might the choice of normalization technique affect further analysis?\n",
    "The choice of normalization technique should be based on the characteristics of the data, the requirements of the analysis, and the assumptions of the models being used.\n",
    "\n"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "84600189",
   "metadata": {
    "papermill": {
     "duration": 0.013226,
     "end_time": "2024-10-18T07:25:47.630196",
     "exception": false,
     "start_time": "2024-10-18T07:25:47.616970",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "## Task 3: Data Binning (20 points)\n"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "f75330a0",
   "metadata": {
    "papermill": {
     "duration": 0.013113,
     "end_time": "2024-10-18T07:25:47.656691",
     "exception": false,
     "start_time": "2024-10-18T07:25:47.643578",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "#### Create a histogram of the \"ArrDelay\" column."
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 14,
   "id": "d03eba13",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2024-10-18T07:25:47.688418Z",
     "iopub.status.busy": "2024-10-18T07:25:47.686633Z",
     "iopub.status.idle": "2024-10-18T07:25:47.982344Z",
     "shell.execute_reply": "2024-10-18T07:25:47.980255Z"
    },
    "papermill": {
     "duration": 0.314647,
     "end_time": "2024-10-18T07:25:47.985005",
     "exception": false,
     "start_time": "2024-10-18T07:25:47.670358",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "image/png": "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\nrK+wDd9+p6c6d5B7uEjbz+32e3+R7f99dXn9bf6Hq76+PsuY0elMkp+fX1ZW1t52e6FV8y89\n5phj1iZTTSN//9rnT/z6o22u3NjY+E73mzBhQotDd8hXz2nz59aL0Fe007rtN3nn/hy6ZKqd\nt87yVe1vZMOnsi+sS7bfHb+aXlKk7ed2+32lyJ6sv7UJEyZ0dyBZsWJFOwkqkU6n2y8xJ9a+\n/uMTv/7I9X+4q6I4PzNyx5c/e1/Z2TN//JHWK6fT6dra2mw229DQkEqlios789nTjBkznnji\nieYjb775ZnV19Q477BBCGD58+KJFi5qmmhbnzZtXUlKy5ZZbZsbnzZu3cuXKIUOGZF7VfLFz\nUxu4kbKysu23337+/PmrV6/uju13d/3dsf0RI0ak0+kFCxb00fo3ZCMtujrTvVtssUXmvxJL\nly5tmmqn57P/c2j+du1MtX5h86l23jr7V2VZf9PPmf965uXlZfmqLA9Cp6vqaP1tTnXuIGcW\nX3vttUyTbLfddt1aZHcfhC7c/oY0SW+ov8s30jNN0v7fV5cchHb+ajL23nvvs846K2Sh05kk\nkUj069dvfbO99KPYwgFjQnjk5ZpkU7CbW5McvH/bJx4TiUT//v2z2Ww6nU4mk1mu3MIFF1zQ\niVf1cuvWrautrS0oKGjvpO5Gprq6OplMDho0KNeF9BaapDVN0oImaU2TtFBVVVVTU6NJmtuQ\nTNKOXnrxRL+yg7csyr//329nFhuqnnlibf1eh26R26oAAHqzXhrsQqLo7E+NmnfrtAfmvLxk\nwf9uuWhGybBDpmw98P+3d+9RUdV7H8e/m+twUUZAxaPoCVS0TDDX6ViZlsTRVMjro2hFZmhe\nKsCOoqiQSqamkD4R6RFTs3SlZeUlM0+pPdry0qOYeclKvIuIILcZmJl9/hiZEJoy6zC05/36\nw7X2b/9m/DF8Fusze/bs7ehlAQAANFwN9KNYEWk7bM54Y+bajJlXDUpoeM85s+IbagkFAABo\nEBpusRPFNSpuUlSco5cBAADwJ8FRMAAAAI2g2AEAAGgExQ4AAEAjKHYAAAAaQbEDAADQCIod\nAACARlDsAAAANIJiBwAAoBEUOwAAAI2g2AEAAGgExQ4AAEAjKHYAgoYBDAAAC8NJREFUAAAa\nQbEDAADQCIodAACARlDsAAAANIJiBwAAoBEUOwAAAI2g2AEAAGgExQ4AAEAjKHYAAAAaQbED\n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\n"
     },
     "metadata": {
      "image/png": {
       "height": 420,
       "width": 420
      }
     },
     "output_type": "display_data"
    }
   ],
   "source": [
    "# Create a histogram of the \"ArrDelay\" column.\n",
    "\n",
    "sub_airline %>% ggplot(aes(x=ArrDelay)) +\n",
    "                geom_histogram(binwidth = 5, fill =\"skyblue\", color = \"black\") +\n",
    "                labs(title = \"Histogarm of Arrival Delay\",\n",
    "                     x = \"ArrDelay\",\n",
    "                     y = \"Frequency\") +\n",
    "                theme_minimal()"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 15,
   "id": "c4c5a231",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2024-10-18T07:25:48.016678Z",
     "iopub.status.busy": "2024-10-18T07:25:48.014976Z",
     "iopub.status.idle": "2024-10-18T07:25:48.086055Z",
     "shell.execute_reply": "2024-10-18T07:25:48.084156Z"
    },
    "papermill": {
     "duration": 0.089908,
     "end_time": "2024-10-18T07:25:48.088662",
     "exception": false,
     "start_time": "2024-10-18T07:25:47.998754",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A tibble: 6 × 26</caption>\n",
       "<thead>\n",
       "\t<tr><th scope=col>Month</th><th scope=col>DayOfWeek</th><th scope=col>FlightDate</th><th scope=col>Reporting_Airline</th><th scope=col>Origin</th><th scope=col>Dest</th><th scope=col>CRSDepTime</th><th scope=col>CRSArrTime</th><th scope=col>DepTime</th><th scope=col>ArrTime</th><th scope=col>⋯</th><th scope=col>LateAircraftDelay</th><th scope=col>DepDelay</th><th scope=col>DepDelayMinutes</th><th scope=col>DivDistance</th><th scope=col>DivArrDelay</th><th scope=col>ArrScaled</th><th scope=col>DepScaled</th><th scope=col>zs_ArrDelay</th><th scope=col>zs_DepDelay</th><th scope=col>ArrDelay_Bin</th></tr>\n",
       "\t<tr><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;date&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>⋯</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;fct&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><td> 3</td><td>5</td><td>2003-03-28</td><td>UA</td><td>LAX</td><td>JFK</td><td>2210</td><td>0615</td><td>2209</td><td>0617</td><td>⋯</td><td>12.66667</td><td>-1</td><td>0</td><td>NA</td><td>NA</td><td>0.09933775</td><td>0.02409639</td><td>-0.04815631</td><td>-0.28063352</td><td>Low</td></tr>\n",
       "\t<tr><td>11</td><td>4</td><td>2018-11-29</td><td>AS</td><td>LAX</td><td>JFK</td><td>1045</td><td>1912</td><td>1049</td><td>1851</td><td>⋯</td><td>12.66667</td><td> 4</td><td>4</td><td>NA</td><td>NA</td><td>0.06887417</td><td>0.03078983</td><td>-0.60922513</td><td>-0.14031185</td><td>Low</td></tr>\n",
       "\t<tr><td> 8</td><td>5</td><td>2015-08-28</td><td>UA</td><td>LAX</td><td>JFK</td><td>0805</td><td>1634</td><td>0757</td><td>1620</td><td>⋯</td><td>12.66667</td><td>-8</td><td>0</td><td>NA</td><td>NA</td><td>0.07814570</td><td>0.01472557</td><td>-0.43846505</td><td>-0.47708387</td><td>Low</td></tr>\n",
       "\t<tr><td> 4</td><td>7</td><td>2003-04-20</td><td>DL</td><td>LAX</td><td>JFK</td><td>2205</td><td>0619</td><td>2212</td><td>0616</td><td>⋯</td><td>12.66667</td><td> 7</td><td>7</td><td>NA</td><td>NA</td><td>0.09271523</td><td>0.03480589</td><td>-0.17012779</td><td>-0.05611884</td><td>Low</td></tr>\n",
       "\t<tr><td>11</td><td>3</td><td>2005-11-30</td><td>UA</td><td>LAX</td><td>JFK</td><td>0840</td><td>1653</td><td>0836</td><td>1640</td><td>⋯</td><td>12.66667</td><td>-4</td><td>0</td><td>NA</td><td>NA</td><td>0.07947020</td><td>0.02008032</td><td>-0.41407075</td><td>-0.36482653</td><td>Low</td></tr>\n",
       "\t<tr><td> 4</td><td>1</td><td>1992-04-06</td><td>UA</td><td>LAX</td><td>JFK</td><td>1450</td><td>2308</td><td>1452</td><td>2248</td><td>⋯</td><td>12.66667</td><td> 2</td><td>2</td><td>NA</td><td>NA</td><td>0.07019868</td><td>0.02811245</td><td>-0.58483083</td><td>-0.19644052</td><td>Low</td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A tibble: 6 × 26\n",
       "\\begin{tabular}{lllllllllllllllllllll}\n",
       " Month & DayOfWeek & FlightDate & Reporting\\_Airline & Origin & Dest & CRSDepTime & CRSArrTime & DepTime & ArrTime & ⋯ & LateAircraftDelay & DepDelay & DepDelayMinutes & DivDistance & DivArrDelay & ArrScaled & DepScaled & zs\\_ArrDelay & zs\\_DepDelay & ArrDelay\\_Bin\\\\\n",
       " <dbl> & <dbl> & <date> & <chr> & <chr> & <chr> & <chr> & <chr> & <chr> & <chr> & ⋯ & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <fct>\\\\\n",
       "\\hline\n",
       "\t  3 & 5 & 2003-03-28 & UA & LAX & JFK & 2210 & 0615 & 2209 & 0617 & ⋯ & 12.66667 & -1 & 0 & NA & NA & 0.09933775 & 0.02409639 & -0.04815631 & -0.28063352 & Low\\\\\n",
       "\t 11 & 4 & 2018-11-29 & AS & LAX & JFK & 1045 & 1912 & 1049 & 1851 & ⋯ & 12.66667 &  4 & 4 & NA & NA & 0.06887417 & 0.03078983 & -0.60922513 & -0.14031185 & Low\\\\\n",
       "\t  8 & 5 & 2015-08-28 & UA & LAX & JFK & 0805 & 1634 & 0757 & 1620 & ⋯ & 12.66667 & -8 & 0 & NA & NA & 0.07814570 & 0.01472557 & -0.43846505 & -0.47708387 & Low\\\\\n",
       "\t  4 & 7 & 2003-04-20 & DL & LAX & JFK & 2205 & 0619 & 2212 & 0616 & ⋯ & 12.66667 &  7 & 7 & NA & NA & 0.09271523 & 0.03480589 & -0.17012779 & -0.05611884 & Low\\\\\n",
       "\t 11 & 3 & 2005-11-30 & UA & LAX & JFK & 0840 & 1653 & 0836 & 1640 & ⋯ & 12.66667 & -4 & 0 & NA & NA & 0.07947020 & 0.02008032 & -0.41407075 & -0.36482653 & Low\\\\\n",
       "\t  4 & 1 & 1992-04-06 & UA & LAX & JFK & 1450 & 2308 & 1452 & 2248 & ⋯ & 12.66667 &  2 & 2 & NA & NA & 0.07019868 & 0.02811245 & -0.58483083 & -0.19644052 & Low\\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A tibble: 6 × 26\n",
       "\n",
       "| Month &lt;dbl&gt; | DayOfWeek &lt;dbl&gt; | FlightDate &lt;date&gt; | Reporting_Airline &lt;chr&gt; | Origin &lt;chr&gt; | Dest &lt;chr&gt; | CRSDepTime &lt;chr&gt; | CRSArrTime &lt;chr&gt; | DepTime &lt;chr&gt; | ArrTime &lt;chr&gt; | ⋯ ⋯ | LateAircraftDelay &lt;dbl&gt; | DepDelay &lt;dbl&gt; | DepDelayMinutes &lt;dbl&gt; | DivDistance &lt;dbl&gt; | DivArrDelay &lt;dbl&gt; | ArrScaled &lt;dbl&gt; | DepScaled &lt;dbl&gt; | zs_ArrDelay &lt;dbl&gt; | zs_DepDelay &lt;dbl&gt; | ArrDelay_Bin &lt;fct&gt; |\n",
       "|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|\n",
       "|  3 | 5 | 2003-03-28 | UA | LAX | JFK | 2210 | 0615 | 2209 | 0617 | ⋯ | 12.66667 | -1 | 0 | NA | NA | 0.09933775 | 0.02409639 | -0.04815631 | -0.28063352 | Low |\n",
       "| 11 | 4 | 2018-11-29 | AS | LAX | JFK | 1045 | 1912 | 1049 | 1851 | ⋯ | 12.66667 |  4 | 4 | NA | NA | 0.06887417 | 0.03078983 | -0.60922513 | -0.14031185 | Low |\n",
       "|  8 | 5 | 2015-08-28 | UA | LAX | JFK | 0805 | 1634 | 0757 | 1620 | ⋯ | 12.66667 | -8 | 0 | NA | NA | 0.07814570 | 0.01472557 | -0.43846505 | -0.47708387 | Low |\n",
       "|  4 | 7 | 2003-04-20 | DL | LAX | JFK | 2205 | 0619 | 2212 | 0616 | ⋯ | 12.66667 |  7 | 7 | NA | NA | 0.09271523 | 0.03480589 | -0.17012779 | -0.05611884 | Low |\n",
       "| 11 | 3 | 2005-11-30 | UA | LAX | JFK | 0840 | 1653 | 0836 | 1640 | ⋯ | 12.66667 | -4 | 0 | NA | NA | 0.07947020 | 0.02008032 | -0.41407075 | -0.36482653 | Low |\n",
       "|  4 | 1 | 1992-04-06 | UA | LAX | JFK | 1450 | 2308 | 1452 | 2248 | ⋯ | 12.66667 |  2 | 2 | NA | NA | 0.07019868 | 0.02811245 | -0.58483083 | -0.19644052 | Low |\n",
       "\n"
      ],
      "text/plain": [
       "  Month DayOfWeek FlightDate Reporting_Airline Origin Dest CRSDepTime\n",
       "1  3    5         2003-03-28 UA                LAX    JFK  2210      \n",
       "2 11    4         2018-11-29 AS                LAX    JFK  1045      \n",
       "3  8    5         2015-08-28 UA                LAX    JFK  0805      \n",
       "4  4    7         2003-04-20 DL                LAX    JFK  2205      \n",
       "5 11    3         2005-11-30 UA                LAX    JFK  0840      \n",
       "6  4    1         1992-04-06 UA                LAX    JFK  1450      \n",
       "  CRSArrTime DepTime ArrTime ⋯ LateAircraftDelay DepDelay DepDelayMinutes\n",
       "1 0615       2209    0617    ⋯ 12.66667          -1       0              \n",
       "2 1912       1049    1851    ⋯ 12.66667           4       4              \n",
       "3 1634       0757    1620    ⋯ 12.66667          -8       0              \n",
       "4 0619       2212    0616    ⋯ 12.66667           7       7              \n",
       "5 1653       0836    1640    ⋯ 12.66667          -4       0              \n",
       "6 2308       1452    2248    ⋯ 12.66667           2       2              \n",
       "  DivDistance DivArrDelay ArrScaled  DepScaled  zs_ArrDelay zs_DepDelay\n",
       "1 NA          NA          0.09933775 0.02409639 -0.04815631 -0.28063352\n",
       "2 NA          NA          0.06887417 0.03078983 -0.60922513 -0.14031185\n",
       "3 NA          NA          0.07814570 0.01472557 -0.43846505 -0.47708387\n",
       "4 NA          NA          0.09271523 0.03480589 -0.17012779 -0.05611884\n",
       "5 NA          NA          0.07947020 0.02008032 -0.41407075 -0.36482653\n",
       "6 NA          NA          0.07019868 0.02811245 -0.58483083 -0.19644052\n",
       "  ArrDelay_Bin\n",
       "1 Low         \n",
       "2 Low         \n",
       "3 Low         \n",
       "4 Low         \n",
       "5 Low         \n",
       "6 Low         "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "# Implement a binning strategy on the \"ArrDelay\" column, creating a new column with 4 bins.\n",
    "\n",
    "sub_airline <- sub_airline %>%\n",
    "                   mutate(ArrDelay_Bin = cut(ArrDelay,\n",
    "                                            breaks = 4,\n",
    "                                            labels = c(\"Low\", \"Moderate\", \"High\", \"Very High\"),\n",
    "                                            include.lowest = TRUE))\n",
    "\n",
    "head(sub_airline)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 16,
   "id": "9774ccb1",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2024-10-18T07:25:48.121079Z",
     "iopub.status.busy": "2024-10-18T07:25:48.119368Z",
     "iopub.status.idle": "2024-10-18T07:25:48.367076Z",
     "shell.execute_reply": "2024-10-18T07:25:48.365072Z"
    },
    "papermill": {
     "duration": 0.266932,
     "end_time": "2024-10-18T07:25:48.369779",
     "exception": false,
     "start_time": "2024-10-18T07:25:48.102847",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "image/png": "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\n+SYDAKBRcg27GTNm/Pivwi791+4SQgihcsaMH59y16lTpyafDACARsk17MrKyhpYm81mm2IY\nAACWXK5hN3z48Pm+ztZOGvfBqIefnJb0Gn7LJU0+FgAAjZVr2J133nkLL7zuytd2XGP7664f\ne9ahBzfpVAAANFqur4qtV7sVt7jjgo2mvHPtizOqmmogAACWzFKFXQihpHdJkqTWLClokmkA\nAFhiSxV2mZrvrz3n7YLSjVcqWNpABABgKeX6HLutttpqoWWZbz5996uplT87+8amnQkAgCXQ\niDcoXkhen/V32HPH315x1hZNNg4AAEsq17B79dVXm3UOAACWkufGAQBEItdH7J588slcNkvy\nigf8ZpelmAcAgCWUa9jtueeeuWzWfsUh5d8KOwCAFpBr2E0a99Q26+41qWSd3598xPYbr1FY\n/cMnH7z+p2tu/CR/83vuG979p7c7KShZu9lGBQCgIbmG3esnHz8hf5M3vnx5/dIf34t414H7\nHX3c4O17bXbeo5n3b/tls00IAEBOcn3xxDnPTew3+Pq5VVenoHT96w7r/9mDpzXDYAAANE6u\nYTehujbJSxZenqSS2srPm3QkAACWRK5hd8iK7T+7d9gXlel5F6arxp9516ftuub0ugoAAJpV\nrmF32ogjamaO3mj93a6774kxb3344duvPfnADbuvv8Hz0yt/ffU5zToiAAC5yPXFEz13vHrM\nnQX7HHfNSYOfm7swL7/jIRc8ce/BfZtnNgAAGqERnxW72f+77IuDT/rn08++8/H4inRqpVXW\n+uXuu6/Ztaj5hgMAIHeN+0ixz15+4ZUxb3748SerHnHC0D06fPvNjGYaCwCAxsr9EbvszYdu\nc8yIV+q+KDnnhj3Kb/jlxn/d7vA/Pn/bMfn1vF4WAIBlKtdH7D5/YO9jRryy4zHXvfPpxLol\nnftfccmRW714x7EDbv2o2cYDACBXuYbdRac812Xt05+/8YQN+vWsW5Jfstbpt/7f+et3fXH4\nhc02HgAAuco17B6bMqfv0IMWXr7X4NUrpz7VpCMBALAkcg27lYtSsz6dufDy6e/PSBX1bNKR\nAABYErmG3ZlbrPDZ/YPHTKmcd+HsSf869OFx3TYe1gyDAQDQOLmG3d4P375yMn771TY66tQL\nQgjvj7z7wj8MXaf/LuMzPf746H7NOSEAADnJNezadd/9rXf+ss9meXdeM7duyMYAACAASURB\nVDyE8MLZp5x39f0dthz0xFvv7tOjfTMOCABAbnJ8H7tMVVVNu367Pfiv3e76/ov3P59Um2rX\nu/+6vct87AQAQGuRU9hl07PKSjpv8eCnL+zft1331X7WfbXmHgsAgMbK6U+xSarTKWt3GXf3\n6809DQAASyzX59id89IzG3x93DE3PDm1Kt2sAwEAsGRy/azYX+93VmbFlW85ca9bTipesUf3\n4oL5ivCLL75ohtkAAGiEXMOuuLg4hJ577OG9iAEAWqlcw+6pp3xuGABAq9bQc+z69Omzwxlj\nl9koAAAsjYbCbsKECd/+UD3vkoKCgg2OGdPMIwEAsCRyfVVsndra2tpMtplGAQBgaTQu7AAA\naLWEHQBAJIQdAEAkhB0AQCQW8z5209595Prr/9PwkhDCCSec0MRzAQDQSIsJu+9eue7EVxaz\nJAg7AIBWoKGwGzVq1DKbAwCApdRQ2A0cOHCZzQEAwFLy4gkAgEgIOwCASAg7AIBICDsAgEgI\nOwCASAg7AIBICDsAgEgIOwCASAg7AIBICDsAgEgIOwCASAg7AIBICDsAgEgIOwCASAg7AIBI\nCDsAgEgIOwCASAg7AIBICDsAgEgIOwCASAg7AIBICDsAgEgIOwCASAg7AIBICDsAgEgIOwCA\nSAg7AIBICDsAgEgIOwCASAg7AIBICDsAgEgIOwCASAg7AIBICDsAgEgIOwCASAg7AIBICDsA\ngEgIOwCASAg7AIBICDsAgEgIOwCASAg7AIBICDsAgEgIOwCASAg7AIBICDsAgEgIOwCASOQv\n48sbcfSQ4gtuPaB7u58WZF4YefNTo9/8elZqrfU2H3rcoauX5C9uVQO7AAC0XcvyEbvspy/d\n+cSkH2qz2bmLxj1+9rUPv7rl3kecd+Lg0s//edZJt2UWt6qBXQAA2rJl9FjX5FevG/bHl6eW\nV8+3NFt9zcMf9j3wqkE79Q0h9LsiGTT4igcmDj2kV/tFrupZsMhdAADatmX0iF3ZuoPOuuCy\nqy4fNu/Cqhmjx1emd965V92XRWXbbFxaOPaFbxtY1cAuAABt3DJ6xK6wY69+HUO6unjehdUV\n74YQ1ikpmLtk7ZL8v787Ixy8yFXVv1jkLvWqqqrKZJrsT7XpdLqpDkUrl06n58yZ09JTtGp1\ndwc3FAurra0NIWQyGecGC6g7N0IIzo2lkSRJcXHxota25MsOMlUVIYSu+f971LBbQaq2vLKB\n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\n0OkUnFHzE3YsaPZ3Dz07ofzEP531y67FIYT+66z7/kG/vePPX122x87V997yTkXNBu1qn/h+\nzgH7rfL4sy+Go9cq//rRbF7pwb1LF3tkWtCag7eddsKdczKbt8tLyic9OCGz0lUrl474ae2i\nvulnrvHAx5XFV11xar/iVAhhzbXb7f/bi0MIlVOffPyTGRc/ePJ67QtCCH3XWC/92sEjb3n/\nVxduVnfAGSseccBOPz6Cu8Iug47b8dc/61QYQui90n53/OWCcVW1K3YoKkySvPzCoqKCxR6N\n1qN80ohhwxZcWNJ9wSWzv3/0ma8rznvguE1KC0JYc5XhXx5y0qi5aztvePKQnTcMIfQeeFKv\n+0d/OK0qtOFfw61RUnDEtiue9/x92cMuTEIY//jfCjts9uuuxY254++2aeldD7347cZ79MnU\nTr3zox+2unyLei8qlzOq4dMpOKPmJ+xY0IwP30sV9d6ha3Hdl0leuz17lNz0yvji3+7at/iO\nUR/+sMaq/55TsOrAXXZ+cORdk2uO+P7Jj0p7H9Qh1ZJPw2exSnsetEreqBFfzjx69U6f3Pty\n142OKprnlROL+qZ//+3E4s6/qqu6EEJhh803LS2YGkL5hDez2eyZB+4z70W0r50Ywo8/33vs\n2Gfu8gF77vbea6/8efzE77779osPF3wFXMjhaLQenVY/577r5vu+vH7iIVcv9JLE6e+9mSru\nu0lpQd2XHfrsEcL/fhP32nWVuf/umPJU79ao78EDqp+75Ynv5+zdvd2D//629+4nhUbe8Q/c\nqcfZjz8b9jh82ru3V+T3PKxfx3ovKJczquHTKTij5ifsWFA2G0KYr9Ly8pKQzYSQHLRO55se\n/2zyZq+Vrrx3ceetVyy487FJFZVvTVvtyE1baFhyluQfukX36+9+7+gLN7/rzSlbX7PmvCsX\n+U3PW7DXO+XnTQ0hv31hkmr/8EN/mu8S8grm/rukw48/WzI1Uy76/bGftF9nl603WneztXYe\nsP3Jx1+wwDEXezSWO9nqzHxnVDLf3+DalTTuiVYse8Vddtu6093PPfDZ7kMmvFlePWxAn9CY\nO34Ioc+eAypH3fjf2UM+ueu/K251WvFCP0xy1/DpFJxR82vrYcvCytZZN1319QvTK+u+zGYq\nn5xY0XWLVUII/Q9cd+a4R99+7pveA9YISWq/3qXvPP7K6JlV+23atUVHJif9D95h2od3fTP+\n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\nSCinAAAAAElFTkSuQmCC"
     },
     "metadata": {
      "image/png": {
       "height": 420,
       "width": 420
      }
     },
     "output_type": "display_data"
    }
   ],
   "source": [
    "# Visualize the results of your binning using an appropriate plot.\n",
    "sub_airline %>% ggplot(aes(x=ArrDelay_Bin)) +\n",
    "                geom_bar(fill=\"blue\", color=\"black\") +\n",
    "                labs(title='Binned ArrDeley',\n",
    "                    x = \"ArrDelay Categories\",\n",
    "                    y = \"Frequency\") +\n",
    "              theme_minimal()"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "d7c974c5",
   "metadata": {
    "papermill": {
     "duration": 0.016007,
     "end_time": "2024-10-18T07:25:48.400643",
     "exception": false,
     "start_time": "2024-10-18T07:25:48.384636",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "#### What insights does the histogram provide about the distribution of arrival delays?\n",
    "Low Arrival Delay are occurred frequenly but there still have high or very high Delay still happened\n",
    "#### How did you choose the number of bins, and what are the implications of this choice?\n",
    "\n",
    "Detail vs. Overview: More bins offer more granularity, fewer bins simplify the view.\n",
    "\n",
    "Interpretability: Fewer bins with meaningful labels make the data easier to explain.\n",
    "\n",
    "Analysis Results: Too many bins can overwhelm models, while too few may hide important trends.\n",
    "\n",
    "The 4-bin strategy provides a good balance for further analysis and visualization.\n",
    "#### How might binning be useful in further analysis of this dataset?\n",
    "Detects patterns: Binned data can help reveal hidden patterns or relationships that might not be clear in raw continuous data. For example, it’s easier to see how certain delay categories relate to cancellations or customer satisfaction.\n",
    "\n",
    "Improves model performance: For classification models like decision trees, using binned categories instead of raw values can improve accuracy by making the data more structured and manageable.\n",
    "\n",
    "Reduces noise: Binning can smooth out extreme values or outliers, which might otherwise skew analysis or modeling results."
   ]
  },
  {
   "cell_type": "markdown",
   "id": "0fea3d7e",
   "metadata": {
    "papermill": {
     "duration": 0.014482,
     "end_time": "2024-10-18T07:25:48.429886",
     "exception": false,
     "start_time": "2024-10-18T07:25:48.415404",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "## Task 4: Creating Indicator Variables (20 points)\n"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 17,
   "id": "85c8bd0d",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2024-10-18T07:25:48.463726Z",
     "iopub.status.busy": "2024-10-18T07:25:48.461900Z",
     "iopub.status.idle": "2024-10-18T07:25:48.564128Z",
     "shell.execute_reply": "2024-10-18T07:25:48.562203Z"
    },
    "papermill": {
     "duration": 0.122222,
     "end_time": "2024-10-18T07:25:48.566806",
     "exception": false,
     "start_time": "2024-10-18T07:25:48.444584",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A tibble: 6 × 34</caption>\n",
       "<thead>\n",
       "\t<tr><th scope=col>Month</th><th scope=col>DayOfWeek</th><th scope=col>FlightDate</th><th scope=col>Origin</th><th scope=col>Dest</th><th scope=col>CRSDepTime</th><th scope=col>CRSArrTime</th><th scope=col>DepTime</th><th scope=col>ArrTime</th><th scope=col>ArrDelay</th><th scope=col>⋯</th><th scope=col>ArrDelay_Bin</th><th scope=col>Airline_UA</th><th scope=col>Airline_AS</th><th scope=col>Airline_DL</th><th scope=col>Airline_VX</th><th scope=col>Airline_HP</th><th scope=col>Airline_AA</th><th scope=col>Airline_B6</th><th scope=col>Airline_PA (1)</th><th scope=col>Airline_TW</th></tr>\n",
       "\t<tr><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;date&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>⋯</th><th scope=col>&lt;fct&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><td> 3</td><td>5</td><td>2003-03-28</td><td>LAX</td><td>JFK</td><td>2210</td><td>0615</td><td>2209</td><td>0617</td><td>  2</td><td>⋯</td><td>Low</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td></tr>\n",
       "\t<tr><td>11</td><td>4</td><td>2018-11-29</td><td>LAX</td><td>JFK</td><td>1045</td><td>1912</td><td>1049</td><td>1851</td><td>-21</td><td>⋯</td><td>Low</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td></tr>\n",
       "\t<tr><td> 8</td><td>5</td><td>2015-08-28</td><td>LAX</td><td>JFK</td><td>0805</td><td>1634</td><td>0757</td><td>1620</td><td>-14</td><td>⋯</td><td>Low</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td></tr>\n",
       "\t<tr><td> 4</td><td>7</td><td>2003-04-20</td><td>LAX</td><td>JFK</td><td>2205</td><td>0619</td><td>2212</td><td>0616</td><td> -3</td><td>⋯</td><td>Low</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td></tr>\n",
       "\t<tr><td>11</td><td>3</td><td>2005-11-30</td><td>LAX</td><td>JFK</td><td>0840</td><td>1653</td><td>0836</td><td>1640</td><td>-13</td><td>⋯</td><td>Low</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td></tr>\n",
       "\t<tr><td> 4</td><td>1</td><td>1992-04-06</td><td>LAX</td><td>JFK</td><td>1450</td><td>2308</td><td>1452</td><td>2248</td><td>-20</td><td>⋯</td><td>Low</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A tibble: 6 × 34\n",
       "\\begin{tabular}{lllllllllllllllllllll}\n",
       " Month & DayOfWeek & FlightDate & Origin & Dest & CRSDepTime & CRSArrTime & DepTime & ArrTime & ArrDelay & ⋯ & ArrDelay\\_Bin & Airline\\_UA & Airline\\_AS & Airline\\_DL & Airline\\_VX & Airline\\_HP & Airline\\_AA & Airline\\_B6 & Airline\\_PA (1) & Airline\\_TW\\\\\n",
       " <dbl> & <dbl> & <date> & <chr> & <chr> & <chr> & <chr> & <chr> & <chr> & <dbl> & ⋯ & <fct> & <int> & <int> & <int> & <int> & <int> & <int> & <int> & <int> & <int>\\\\\n",
       "\\hline\n",
       "\t  3 & 5 & 2003-03-28 & LAX & JFK & 2210 & 0615 & 2209 & 0617 &   2 & ⋯ & Low & 1 & 0 & 0 & 0 & 0 & 0 & 0 & 0 & 0\\\\\n",
       "\t 11 & 4 & 2018-11-29 & LAX & JFK & 1045 & 1912 & 1049 & 1851 & -21 & ⋯ & Low & 0 & 1 & 0 & 0 & 0 & 0 & 0 & 0 & 0\\\\\n",
       "\t  8 & 5 & 2015-08-28 & LAX & JFK & 0805 & 1634 & 0757 & 1620 & -14 & ⋯ & Low & 1 & 0 & 0 & 0 & 0 & 0 & 0 & 0 & 0\\\\\n",
       "\t  4 & 7 & 2003-04-20 & LAX & JFK & 2205 & 0619 & 2212 & 0616 &  -3 & ⋯ & Low & 0 & 0 & 1 & 0 & 0 & 0 & 0 & 0 & 0\\\\\n",
       "\t 11 & 3 & 2005-11-30 & LAX & JFK & 0840 & 1653 & 0836 & 1640 & -13 & ⋯ & Low & 1 & 0 & 0 & 0 & 0 & 0 & 0 & 0 & 0\\\\\n",
       "\t  4 & 1 & 1992-04-06 & LAX & JFK & 1450 & 2308 & 1452 & 2248 & -20 & ⋯ & Low & 1 & 0 & 0 & 0 & 0 & 0 & 0 & 0 & 0\\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A tibble: 6 × 34\n",
       "\n",
       "| Month &lt;dbl&gt; | DayOfWeek &lt;dbl&gt; | FlightDate &lt;date&gt; | Origin &lt;chr&gt; | Dest &lt;chr&gt; | CRSDepTime &lt;chr&gt; | CRSArrTime &lt;chr&gt; | DepTime &lt;chr&gt; | ArrTime &lt;chr&gt; | ArrDelay &lt;dbl&gt; | ⋯ ⋯ | ArrDelay_Bin &lt;fct&gt; | Airline_UA &lt;int&gt; | Airline_AS &lt;int&gt; | Airline_DL &lt;int&gt; | Airline_VX &lt;int&gt; | Airline_HP &lt;int&gt; | Airline_AA &lt;int&gt; | Airline_B6 &lt;int&gt; | Airline_PA (1) &lt;int&gt; | Airline_TW &lt;int&gt; |\n",
       "|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|\n",
       "|  3 | 5 | 2003-03-28 | LAX | JFK | 2210 | 0615 | 2209 | 0617 |   2 | ⋯ | Low | 1 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |\n",
       "| 11 | 4 | 2018-11-29 | LAX | JFK | 1045 | 1912 | 1049 | 1851 | -21 | ⋯ | Low | 0 | 1 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |\n",
       "|  8 | 5 | 2015-08-28 | LAX | JFK | 0805 | 1634 | 0757 | 1620 | -14 | ⋯ | Low | 1 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |\n",
       "|  4 | 7 | 2003-04-20 | LAX | JFK | 2205 | 0619 | 2212 | 0616 |  -3 | ⋯ | Low | 0 | 0 | 1 | 0 | 0 | 0 | 0 | 0 | 0 |\n",
       "| 11 | 3 | 2005-11-30 | LAX | JFK | 0840 | 1653 | 0836 | 1640 | -13 | ⋯ | Low | 1 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |\n",
       "|  4 | 1 | 1992-04-06 | LAX | JFK | 1450 | 2308 | 1452 | 2248 | -20 | ⋯ | Low | 1 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |\n",
       "\n"
      ],
      "text/plain": [
       "  Month DayOfWeek FlightDate Origin Dest CRSDepTime CRSArrTime DepTime ArrTime\n",
       "1  3    5         2003-03-28 LAX    JFK  2210       0615       2209    0617   \n",
       "2 11    4         2018-11-29 LAX    JFK  1045       1912       1049    1851   \n",
       "3  8    5         2015-08-28 LAX    JFK  0805       1634       0757    1620   \n",
       "4  4    7         2003-04-20 LAX    JFK  2205       0619       2212    0616   \n",
       "5 11    3         2005-11-30 LAX    JFK  0840       1653       0836    1640   \n",
       "6  4    1         1992-04-06 LAX    JFK  1450       2308       1452    2248   \n",
       "  ArrDelay ⋯ ArrDelay_Bin Airline_UA Airline_AS Airline_DL Airline_VX\n",
       "1   2      ⋯ Low          1          0          0          0         \n",
       "2 -21      ⋯ Low          0          1          0          0         \n",
       "3 -14      ⋯ Low          1          0          0          0         \n",
       "4  -3      ⋯ Low          0          0          1          0         \n",
       "5 -13      ⋯ Low          1          0          0          0         \n",
       "6 -20      ⋯ Low          1          0          0          0         \n",
       "  Airline_HP Airline_AA Airline_B6 Airline_PA (1) Airline_TW\n",
       "1 0          0          0          0              0         \n",
       "2 0          0          0          0              0         \n",
       "3 0          0          0          0              0         \n",
       "4 0          0          0          0              0         \n",
       "5 0          0          0          0              0         \n",
       "6 0          0          0          0              0         "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "# Create indicator variables (dummy variables) for the \"Reporting_Airline\" column.\n",
    "sub_airline_dummy <- sub_airline %>%\n",
    "  mutate(Reporting_Airline = as.factor(Reporting_Airline)) %>%  # Convert to factor\n",
    "  pivot_wider(names_from = Reporting_Airline,                   # Create columns for each airline\n",
    "              values_from = Reporting_Airline,                   # Use Reporting_Airline as values\n",
    "              values_fn = length,                                # Count occurrences\n",
    "              values_fill = 0,                                   # Fill NAs with 0\n",
    "              names_prefix = \"Airline_\")                        # Prefix the new columns\n",
    "\n",
    "# Display the first few rows of the modified dataframe\n",
    "head(sub_airline_dummy)\n"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 18,
   "id": "1cd638ce",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2024-10-18T07:25:48.601042Z",
     "iopub.status.busy": "2024-10-18T07:25:48.599353Z",
     "iopub.status.idle": "2024-10-18T07:25:48.617843Z",
     "shell.execute_reply": "2024-10-18T07:25:48.615895Z"
    },
    "papermill": {
     "duration": 0.038325,
     "end_time": "2024-10-18T07:25:48.620396",
     "exception": false,
     "start_time": "2024-10-18T07:25:48.582071",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "<style>\n",
       ".list-inline {list-style: none; margin:0; padding: 0}\n",
       ".list-inline>li {display: inline-block}\n",
       ".list-inline>li:not(:last-child)::after {content: \"\\00b7\"; padding: 0 .5ex}\n",
       "</style>\n",
       "<ol class=list-inline><li>'Month'</li><li>'DayOfWeek'</li><li>'FlightDate'</li><li>'Reporting_Airline'</li><li>'Origin'</li><li>'Dest'</li><li>'CRSDepTime'</li><li>'CRSArrTime'</li><li>'DepTime'</li><li>'ArrTime'</li><li>'ArrDelay'</li><li>'ArrDelayMinutes'</li><li>'CarrierDelay'</li><li>'WeatherDelay'</li><li>'NASDelay'</li><li>'SecurityDelay'</li><li>'LateAircraftDelay'</li><li>'DepDelay'</li><li>'DepDelayMinutes'</li><li>'DivDistance'</li><li>'DivArrDelay'</li><li>'ArrScaled'</li><li>'DepScaled'</li><li>'zs_ArrDelay'</li><li>'zs_DepDelay'</li><li>'ArrDelay_Bin'</li></ol>\n"
      ],
      "text/latex": [
       "\\begin{enumerate*}\n",
       "\\item 'Month'\n",
       "\\item 'DayOfWeek'\n",
       "\\item 'FlightDate'\n",
       "\\item 'Reporting\\_Airline'\n",
       "\\item 'Origin'\n",
       "\\item 'Dest'\n",
       "\\item 'CRSDepTime'\n",
       "\\item 'CRSArrTime'\n",
       "\\item 'DepTime'\n",
       "\\item 'ArrTime'\n",
       "\\item 'ArrDelay'\n",
       "\\item 'ArrDelayMinutes'\n",
       "\\item 'CarrierDelay'\n",
       "\\item 'WeatherDelay'\n",
       "\\item 'NASDelay'\n",
       "\\item 'SecurityDelay'\n",
       "\\item 'LateAircraftDelay'\n",
       "\\item 'DepDelay'\n",
       "\\item 'DepDelayMinutes'\n",
       "\\item 'DivDistance'\n",
       "\\item 'DivArrDelay'\n",
       "\\item 'ArrScaled'\n",
       "\\item 'DepScaled'\n",
       "\\item 'zs\\_ArrDelay'\n",
       "\\item 'zs\\_DepDelay'\n",
       "\\item 'ArrDelay\\_Bin'\n",
       "\\end{enumerate*}\n"
      ],
      "text/markdown": [
       "1. 'Month'\n",
       "2. 'DayOfWeek'\n",
       "3. 'FlightDate'\n",
       "4. 'Reporting_Airline'\n",
       "5. 'Origin'\n",
       "6. 'Dest'\n",
       "7. 'CRSDepTime'\n",
       "8. 'CRSArrTime'\n",
       "9. 'DepTime'\n",
       "10. 'ArrTime'\n",
       "11. 'ArrDelay'\n",
       "12. 'ArrDelayMinutes'\n",
       "13. 'CarrierDelay'\n",
       "14. 'WeatherDelay'\n",
       "15. 'NASDelay'\n",
       "16. 'SecurityDelay'\n",
       "17. 'LateAircraftDelay'\n",
       "18. 'DepDelay'\n",
       "19. 'DepDelayMinutes'\n",
       "20. 'DivDistance'\n",
       "21. 'DivArrDelay'\n",
       "22. 'ArrScaled'\n",
       "23. 'DepScaled'\n",
       "24. 'zs_ArrDelay'\n",
       "25. 'zs_DepDelay'\n",
       "26. 'ArrDelay_Bin'\n",
       "\n",
       "\n"
      ],
      "text/plain": [
       " [1] \"Month\"             \"DayOfWeek\"         \"FlightDate\"       \n",
       " [4] \"Reporting_Airline\" \"Origin\"            \"Dest\"             \n",
       " [7] \"CRSDepTime\"        \"CRSArrTime\"        \"DepTime\"          \n",
       "[10] \"ArrTime\"           \"ArrDelay\"          \"ArrDelayMinutes\"  \n",
       "[13] \"CarrierDelay\"      \"WeatherDelay\"      \"NASDelay\"         \n",
       "[16] \"SecurityDelay\"     \"LateAircraftDelay\" \"DepDelay\"         \n",
       "[19] \"DepDelayMinutes\"   \"DivDistance\"       \"DivArrDelay\"      \n",
       "[22] \"ArrScaled\"         \"DepScaled\"         \"zs_ArrDelay\"      \n",
       "[25] \"zs_DepDelay\"       \"ArrDelay_Bin\"     "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "colnames(sub_airline)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 19,
   "id": "b356eda9",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2024-10-18T07:25:48.655054Z",
     "iopub.status.busy": "2024-10-18T07:25:48.653299Z",
     "iopub.status.idle": "2024-10-18T07:25:48.737999Z",
     "shell.execute_reply": "2024-10-18T07:25:48.736047Z"
    },
    "papermill": {
     "duration": 0.104945,
     "end_time": "2024-10-18T07:25:48.740653",
     "exception": false,
     "start_time": "2024-10-18T07:25:48.635708",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A tibble: 6 × 36</caption>\n",
       "<thead>\n",
       "\t<tr><th scope=col>DayOfWeek</th><th scope=col>FlightDate</th><th scope=col>Reporting_Airline</th><th scope=col>Origin</th><th scope=col>Dest</th><th scope=col>CRSDepTime</th><th scope=col>CRSArrTime</th><th scope=col>DepTime</th><th scope=col>ArrTime</th><th scope=col>ArrDelay</th><th scope=col>⋯</th><th scope=col>Month_8</th><th scope=col>Month_4</th><th scope=col>Month_12</th><th scope=col>Month_2</th><th scope=col>Month_10</th><th scope=col>Month_6</th><th scope=col>Month_7</th><th scope=col>Month_1</th><th scope=col>Month_9</th><th scope=col>Month_5</th></tr>\n",
       "\t<tr><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;date&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>⋯</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><td>5</td><td>2003-03-28</td><td>UA</td><td>LAX</td><td>JFK</td><td>2210</td><td>0615</td><td>2209</td><td>0617</td><td>  2</td><td>⋯</td><td> 0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td></tr>\n",
       "\t<tr><td>4</td><td>2018-11-29</td><td>AS</td><td>LAX</td><td>JFK</td><td>1045</td><td>1912</td><td>1049</td><td>1851</td><td>-21</td><td>⋯</td><td> 0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td></tr>\n",
       "\t<tr><td>5</td><td>2015-08-28</td><td>UA</td><td>LAX</td><td>JFK</td><td>0805</td><td>1634</td><td>0757</td><td>1620</td><td>-14</td><td>⋯</td><td>-8</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td></tr>\n",
       "\t<tr><td>7</td><td>2003-04-20</td><td>DL</td><td>LAX</td><td>JFK</td><td>2205</td><td>0619</td><td>2212</td><td>0616</td><td> -3</td><td>⋯</td><td> 0</td><td>7</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td></tr>\n",
       "\t<tr><td>3</td><td>2005-11-30</td><td>UA</td><td>LAX</td><td>JFK</td><td>0840</td><td>1653</td><td>0836</td><td>1640</td><td>-13</td><td>⋯</td><td> 0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td></tr>\n",
       "\t<tr><td>1</td><td>1992-04-06</td><td>UA</td><td>LAX</td><td>JFK</td><td>1450</td><td>2308</td><td>1452</td><td>2248</td><td>-20</td><td>⋯</td><td> 0</td><td>2</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A tibble: 6 × 36\n",
       "\\begin{tabular}{lllllllllllllllllllll}\n",
       " DayOfWeek & FlightDate & Reporting\\_Airline & Origin & Dest & CRSDepTime & CRSArrTime & DepTime & ArrTime & ArrDelay & ⋯ & Month\\_8 & Month\\_4 & Month\\_12 & Month\\_2 & Month\\_10 & Month\\_6 & Month\\_7 & Month\\_1 & Month\\_9 & Month\\_5\\\\\n",
       " <dbl> & <date> & <chr> & <chr> & <chr> & <chr> & <chr> & <chr> & <chr> & <dbl> & ⋯ & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl>\\\\\n",
       "\\hline\n",
       "\t 5 & 2003-03-28 & UA & LAX & JFK & 2210 & 0615 & 2209 & 0617 &   2 & ⋯ &  0 & 0 & 0 & 0 & 0 & 0 & 0 & 0 & 0 & 0\\\\\n",
       "\t 4 & 2018-11-29 & AS & LAX & JFK & 1045 & 1912 & 1049 & 1851 & -21 & ⋯ &  0 & 0 & 0 & 0 & 0 & 0 & 0 & 0 & 0 & 0\\\\\n",
       "\t 5 & 2015-08-28 & UA & LAX & JFK & 0805 & 1634 & 0757 & 1620 & -14 & ⋯ & -8 & 0 & 0 & 0 & 0 & 0 & 0 & 0 & 0 & 0\\\\\n",
       "\t 7 & 2003-04-20 & DL & LAX & JFK & 2205 & 0619 & 2212 & 0616 &  -3 & ⋯ &  0 & 7 & 0 & 0 & 0 & 0 & 0 & 0 & 0 & 0\\\\\n",
       "\t 3 & 2005-11-30 & UA & LAX & JFK & 0840 & 1653 & 0836 & 1640 & -13 & ⋯ &  0 & 0 & 0 & 0 & 0 & 0 & 0 & 0 & 0 & 0\\\\\n",
       "\t 1 & 1992-04-06 & UA & LAX & JFK & 1450 & 2308 & 1452 & 2248 & -20 & ⋯ &  0 & 2 & 0 & 0 & 0 & 0 & 0 & 0 & 0 & 0\\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A tibble: 6 × 36\n",
       "\n",
       "| DayOfWeek &lt;dbl&gt; | FlightDate &lt;date&gt; | Reporting_Airline &lt;chr&gt; | Origin &lt;chr&gt; | Dest &lt;chr&gt; | CRSDepTime &lt;chr&gt; | CRSArrTime &lt;chr&gt; | DepTime &lt;chr&gt; | ArrTime &lt;chr&gt; | ArrDelay &lt;dbl&gt; | ⋯ ⋯ | Month_8 &lt;dbl&gt; | Month_4 &lt;dbl&gt; | Month_12 &lt;dbl&gt; | Month_2 &lt;dbl&gt; | Month_10 &lt;dbl&gt; | Month_6 &lt;dbl&gt; | Month_7 &lt;dbl&gt; | Month_1 &lt;dbl&gt; | Month_9 &lt;dbl&gt; | Month_5 &lt;dbl&gt; |\n",
       "|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|\n",
       "| 5 | 2003-03-28 | UA | LAX | JFK | 2210 | 0615 | 2209 | 0617 |   2 | ⋯ |  0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |\n",
       "| 4 | 2018-11-29 | AS | LAX | JFK | 1045 | 1912 | 1049 | 1851 | -21 | ⋯ |  0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |\n",
       "| 5 | 2015-08-28 | UA | LAX | JFK | 0805 | 1634 | 0757 | 1620 | -14 | ⋯ | -8 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |\n",
       "| 7 | 2003-04-20 | DL | LAX | JFK | 2205 | 0619 | 2212 | 0616 |  -3 | ⋯ |  0 | 7 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |\n",
       "| 3 | 2005-11-30 | UA | LAX | JFK | 0840 | 1653 | 0836 | 1640 | -13 | ⋯ |  0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |\n",
       "| 1 | 1992-04-06 | UA | LAX | JFK | 1450 | 2308 | 1452 | 2248 | -20 | ⋯ |  0 | 2 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |\n",
       "\n"
      ],
      "text/plain": [
       "  DayOfWeek FlightDate Reporting_Airline Origin Dest CRSDepTime CRSArrTime\n",
       "1 5         2003-03-28 UA                LAX    JFK  2210       0615      \n",
       "2 4         2018-11-29 AS                LAX    JFK  1045       1912      \n",
       "3 5         2015-08-28 UA                LAX    JFK  0805       1634      \n",
       "4 7         2003-04-20 DL                LAX    JFK  2205       0619      \n",
       "5 3         2005-11-30 UA                LAX    JFK  0840       1653      \n",
       "6 1         1992-04-06 UA                LAX    JFK  1450       2308      \n",
       "  DepTime ArrTime ArrDelay ⋯ Month_8 Month_4 Month_12 Month_2 Month_10 Month_6\n",
       "1 2209    0617      2      ⋯  0      0       0        0       0        0      \n",
       "2 1049    1851    -21      ⋯  0      0       0        0       0        0      \n",
       "3 0757    1620    -14      ⋯ -8      0       0        0       0        0      \n",
       "4 2212    0616     -3      ⋯  0      7       0        0       0        0      \n",
       "5 0836    1640    -13      ⋯  0      0       0        0       0        0      \n",
       "6 1452    2248    -20      ⋯  0      2       0        0       0        0      \n",
       "  Month_7 Month_1 Month_9 Month_5\n",
       "1 0       0       0       0      \n",
       "2 0       0       0       0      \n",
       "3 0       0       0       0      \n",
       "4 0       0       0       0      \n",
       "5 0       0       0       0      \n",
       "6 0       0       0       0      "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "# Create indicator variables for the \"Month\" column, using the \"DepDelay\" values instead of a constant.\n",
    "\n",
    "sub_airline <- sub_airline %>%\n",
    "    mutate(Month = as.factor(Month)) %>%\n",
    "    pivot_wider(names_from = Month,\n",
    "                values_from = DepDelay,\n",
    "                values_fill = list(DepDelay=0),\n",
    "                names_prefix = \"Month_\")\n",
    "\n",
    "# Display the first few rows of your transformed data to verify the results.\n",
    "head(sub_airline)"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "f8f2b5be",
   "metadata": {
    "papermill": {
     "duration": 0.015826,
     "end_time": "2024-10-18T07:25:48.772314",
     "exception": false,
     "start_time": "2024-10-18T07:25:48.756488",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "#### How has the structure of the dataset changed after creating these indicator variables?\n",
    "From Wide to Long: The dataset has transitioned from a single Reporting_Airline column to multiple indicator columns (dummy variables) representing each unique airline.\n",
    "\n",
    "Increased Columns: The number of columns in the dataset has increased, reflecting the number of unique reporting airlines.\n",
    "#### What are the potential benefits and drawbacks of using indicator variables in this context?\n",
    "\n",
    "Enhanced Interpretability: Indicator variables simplify the representation of categorical data, making it easier to analyze and visualize relationships.\n",
    "\n",
    "Facilitates Statistical Modeling: Many statistical models require numerical inputs, and dummy variables enable the inclusion of categorical features in regression and machine learning models.\n",
    "\n",
    "Isolation of Effects: They allow for the examination of the individual impact of each airline on delays or other outcomes.\n",
    "\n",
    "#### How might these indicator variables be useful in further analysis or modeling?\n",
    "Increased Dimensionality: Adding many dummy variables can lead to a high-dimensional dataset, which may complicate analyses and models.\n",
    "\n",
    "Overfitting Risk: In models with many indicators, there is a risk of overfitting, especially if the dataset is small relative to the number of variables.\n",
    "\n",
    "Loss of Information: The original information about the categorical variable can be diluted since the dummy variables may not capture interactions between different categories."
   ]
  },
  {
   "cell_type": "markdown",
   "id": "74af34f5",
   "metadata": {
    "papermill": {
     "duration": 0.017472,
     "end_time": "2024-10-18T07:25:48.805742",
     "exception": false,
     "start_time": "2024-10-18T07:25:48.788270",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "## Task 5: Data Visualization (10 points)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 20,
   "id": "266d9bc1",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2024-10-18T07:25:48.841391Z",
     "iopub.status.busy": "2024-10-18T07:25:48.839573Z",
     "iopub.status.idle": "2024-10-18T07:25:49.250156Z",
     "shell.execute_reply": "2024-10-18T07:25:49.248080Z"
    },
    "papermill": {
     "duration": 0.431208,
     "end_time": "2024-10-18T07:25:49.252763",
     "exception": false,
     "start_time": "2024-10-18T07:25:48.821555",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/plain": [
       "List of 136\n",
       " $ line                            :List of 6\n",
       "  ..$ colour       : chr \"black\"\n",
       "  ..$ linewidth    : num 0.5\n",
       "  ..$ linetype     : num 1\n",
       "  ..$ lineend      : chr \"butt\"\n",
       "  ..$ arrow        : logi FALSE\n",
       "  ..$ inherit.blank: logi TRUE\n",
       "  ..- attr(*, \"class\")= chr [1:2] \"element_line\" \"element\"\n",
       " $ rect                            :List of 5\n",
       "  ..$ fill         : chr \"white\"\n",
       "  ..$ colour       : chr \"black\"\n",
       "  ..$ linewidth    : num 0.5\n",
       "  ..$ linetype     : num 1\n",
       "  ..$ inherit.blank: logi TRUE\n",
       "  ..- attr(*, \"class\")= chr [1:2] \"element_rect\" \"element\"\n",
       " $ text                            :List of 11\n",
       "  ..$ family       : chr \"\"\n",
       "  ..$ face         : chr \"plain\"\n",
       "  ..$ colour       : chr \"black\"\n",
       "  ..$ size         : num 11\n",
       "  ..$ hjust        : num 0.5\n",
       "  ..$ vjust        : num 0.5\n",
       "  ..$ angle        : num 0\n",
       "  ..$ lineheight   : num 0.9\n",
       "  ..$ margin       : 'margin' num [1:4] 0points 0points 0points 0points\n",
       "  .. ..- attr(*, \"unit\")= int 8\n",
       "  ..$ debug        : logi FALSE\n",
       "  ..$ inherit.blank: logi TRUE\n",
       "  ..- attr(*, \"class\")= chr [1:2] \"element_text\" \"element\"\n",
       " $ title                           : NULL\n",
       " $ aspect.ratio                    : NULL\n",
       " $ axis.title                      : NULL\n",
       " $ axis.title.x                    :List of 11\n",
       "  ..$ family       : NULL\n",
       "  ..$ face         : NULL\n",
       "  ..$ colour       : NULL\n",
       "  ..$ size         : NULL\n",
       "  ..$ hjust        : NULL\n",
       "  ..$ vjust        : num 1\n",
       "  ..$ angle        : NULL\n",
       "  ..$ lineheight   : NULL\n",
       "  ..$ margin       : 'margin' num [1:4] 2.75points 0points 0points 0points\n",
       "  .. ..- attr(*, \"unit\")= int 8\n",
       "  ..$ debug        : NULL\n",
       "  ..$ inherit.blank: logi TRUE\n",
       "  ..- attr(*, \"class\")= chr [1:2] \"element_text\" \"element\"\n",
       " $ axis.title.x.top                :List of 11\n",
       "  ..$ family       : NULL\n",
       "  ..$ face         : NULL\n",
       "  ..$ colour       : NULL\n",
       "  ..$ size         : NULL\n",
       "  ..$ hjust        : NULL\n",
       "  ..$ vjust        : num 0\n",
       "  ..$ angle        : NULL\n",
       "  ..$ lineheight   : NULL\n",
       "  ..$ margin       : 'margin' num [1:4] 0points 0points 2.75points 0points\n",
       "  .. ..- attr(*, \"unit\")= int 8\n",
       "  ..$ debug        : NULL\n",
       "  ..$ inherit.blank: logi TRUE\n",
       "  ..- attr(*, \"class\")= chr [1:2] \"element_text\" \"element\"\n",
       " $ axis.title.x.bottom             : NULL\n",
       " $ axis.title.y                    :List of 11\n",
       "  ..$ family       : NULL\n",
       "  ..$ face         : NULL\n",
       "  ..$ colour       : NULL\n",
       "  ..$ size         : NULL\n",
       "  ..$ hjust        : NULL\n",
       "  ..$ vjust        : num 1\n",
       "  ..$ angle        : num 90\n",
       "  ..$ lineheight   : NULL\n",
       "  ..$ margin       : 'margin' num [1:4] 0points 2.75points 0points 0points\n",
       "  .. ..- attr(*, \"unit\")= int 8\n",
       "  ..$ debug        : NULL\n",
       "  ..$ inherit.blank: logi TRUE\n",
       "  ..- attr(*, \"class\")= chr [1:2] \"element_text\" \"element\"\n",
       " $ axis.title.y.left               : NULL\n",
       " $ axis.title.y.right              :List of 11\n",
       "  ..$ family       : NULL\n",
       "  ..$ face         : NULL\n",
       "  ..$ colour       : NULL\n",
       "  ..$ size         : NULL\n",
       "  ..$ hjust        : NULL\n",
       "  ..$ vjust        : num 1\n",
       "  ..$ angle        : num -90\n",
       "  ..$ lineheight   : NULL\n",
       "  ..$ margin       : 'margin' num [1:4] 0points 0points 0points 2.75points\n",
       "  .. ..- attr(*, \"unit\")= int 8\n",
       "  ..$ debug        : NULL\n",
       "  ..$ inherit.blank: logi TRUE\n",
       "  ..- attr(*, \"class\")= chr [1:2] \"element_text\" \"element\"\n",
       " $ axis.text                       :List of 11\n",
       "  ..$ family       : NULL\n",
       "  ..$ face         : NULL\n",
       "  ..$ colour       : chr \"grey30\"\n",
       "  ..$ size         : 'rel' num 0.8\n",
       "  ..$ hjust        : NULL\n",
       "  ..$ vjust        : NULL\n",
       "  ..$ angle        : NULL\n",
       "  ..$ lineheight   : NULL\n",
       "  ..$ margin       : NULL\n",
       "  ..$ debug        : NULL\n",
       "  ..$ inherit.blank: logi TRUE\n",
       "  ..- attr(*, \"class\")= chr [1:2] \"element_text\" \"element\"\n",
       " $ axis.text.x                     :List of 11\n",
       "  ..$ family       : NULL\n",
       "  ..$ face         : NULL\n",
       "  ..$ colour       : NULL\n",
       "  ..$ size         : NULL\n",
       "  ..$ hjust        : NULL\n",
       "  ..$ vjust        : num 1\n",
       "  ..$ angle        : NULL\n",
       "  ..$ lineheight   : NULL\n",
       "  ..$ margin       : 'margin' num [1:4] 2.2points 0points 0points 0points\n",
       "  .. ..- attr(*, \"unit\")= int 8\n",
       "  ..$ debug        : NULL\n",
       "  ..$ inherit.blank: logi TRUE\n",
       "  ..- attr(*, \"class\")= chr [1:2] \"element_text\" \"element\"\n",
       " $ axis.text.x.top                 :List of 11\n",
       "  ..$ family       : NULL\n",
       "  ..$ face         : NULL\n",
       "  ..$ colour       : NULL\n",
       "  ..$ size         : NULL\n",
       "  ..$ hjust        : NULL\n",
       "  ..$ vjust        : num 0\n",
       "  ..$ angle        : NULL\n",
       "  ..$ lineheight   : NULL\n",
       "  ..$ margin       : 'margin' num [1:4] 0points 0points 2.2points 0points\n",
       "  .. ..- attr(*, \"unit\")= int 8\n",
       "  ..$ debug        : NULL\n",
       "  ..$ inherit.blank: logi TRUE\n",
       "  ..- attr(*, \"class\")= chr [1:2] \"element_text\" \"element\"\n",
       " $ axis.text.x.bottom              : NULL\n",
       " $ axis.text.y                     :List of 11\n",
       "  ..$ family       : NULL\n",
       "  ..$ face         : NULL\n",
       "  ..$ colour       : NULL\n",
       "  ..$ size         : NULL\n",
       "  ..$ hjust        : num 1\n",
       "  ..$ vjust        : NULL\n",
       "  ..$ angle        : NULL\n",
       "  ..$ lineheight   : NULL\n",
       "  ..$ margin       : 'margin' num [1:4] 0points 2.2points 0points 0points\n",
       "  .. ..- attr(*, \"unit\")= int 8\n",
       "  ..$ debug        : NULL\n",
       "  ..$ inherit.blank: logi TRUE\n",
       "  ..- attr(*, \"class\")= chr [1:2] \"element_text\" \"element\"\n",
       " $ axis.text.y.left                : NULL\n",
       " $ axis.text.y.right               :List of 11\n",
       "  ..$ family       : NULL\n",
       "  ..$ face         : NULL\n",
       "  ..$ colour       : NULL\n",
       "  ..$ size         : NULL\n",
       "  ..$ hjust        : num 0\n",
       "  ..$ vjust        : NULL\n",
       "  ..$ angle        : NULL\n",
       "  ..$ lineheight   : NULL\n",
       "  ..$ margin       : 'margin' num [1:4] 0points 0points 0points 2.2points\n",
       "  .. ..- attr(*, \"unit\")= int 8\n",
       "  ..$ debug        : NULL\n",
       "  ..$ inherit.blank: logi TRUE\n",
       "  ..- attr(*, \"class\")= chr [1:2] \"element_text\" \"element\"\n",
       " $ axis.text.theta                 : NULL\n",
       " $ axis.text.r                     :List of 11\n",
       "  ..$ family       : NULL\n",
       "  ..$ face         : NULL\n",
       "  ..$ colour       : NULL\n",
       "  ..$ size         : NULL\n",
       "  ..$ hjust        : num 0.5\n",
       "  ..$ vjust        : NULL\n",
       "  ..$ angle        : NULL\n",
       "  ..$ lineheight   : NULL\n",
       "  ..$ margin       : 'margin' num [1:4] 0points 2.2points 0points 2.2points\n",
       "  .. ..- attr(*, \"unit\")= int 8\n",
       "  ..$ debug        : NULL\n",
       "  ..$ inherit.blank: logi TRUE\n",
       "  ..- attr(*, \"class\")= chr [1:2] \"element_text\" \"element\"\n",
       " $ axis.ticks                      : list()\n",
       "  ..- attr(*, \"class\")= chr [1:2] \"element_blank\" \"element\"\n",
       " $ axis.ticks.x                    : NULL\n",
       " $ axis.ticks.x.top                : NULL\n",
       " $ axis.ticks.x.bottom             : NULL\n",
       " $ axis.ticks.y                    : NULL\n",
       " $ axis.ticks.y.left               : NULL\n",
       " $ axis.ticks.y.right              : NULL\n",
       " $ axis.ticks.theta                : NULL\n",
       " $ axis.ticks.r                    : NULL\n",
       " $ axis.minor.ticks.x.top          : NULL\n",
       " $ axis.minor.ticks.x.bottom       : NULL\n",
       " $ axis.minor.ticks.y.left         : NULL\n",
       " $ axis.minor.ticks.y.right        : NULL\n",
       " $ axis.minor.ticks.theta          : NULL\n",
       " $ axis.minor.ticks.r              : NULL\n",
       " $ axis.ticks.length               : 'simpleUnit' num 2.75points\n",
       "  ..- attr(*, \"unit\")= int 8\n",
       " $ axis.ticks.length.x             : NULL\n",
       " $ axis.ticks.length.x.top         : NULL\n",
       " $ axis.ticks.length.x.bottom      : NULL\n",
       " $ axis.ticks.length.y             : NULL\n",
       " $ axis.ticks.length.y.left        : NULL\n",
       " $ axis.ticks.length.y.right       : NULL\n",
       " $ axis.ticks.length.theta         : NULL\n",
       " $ axis.ticks.length.r             : NULL\n",
       " $ axis.minor.ticks.length         : 'rel' num 0.75\n",
       " $ axis.minor.ticks.length.x       : NULL\n",
       " $ axis.minor.ticks.length.x.top   : NULL\n",
       " $ axis.minor.ticks.length.x.bottom: NULL\n",
       " $ axis.minor.ticks.length.y       : NULL\n",
       " $ axis.minor.ticks.length.y.left  : NULL\n",
       " $ axis.minor.ticks.length.y.right : NULL\n",
       " $ axis.minor.ticks.length.theta   : NULL\n",
       " $ axis.minor.ticks.length.r       : NULL\n",
       " $ axis.line                       : list()\n",
       "  ..- attr(*, \"class\")= chr [1:2] \"element_blank\" \"element\"\n",
       " $ axis.line.x                     : NULL\n",
       " $ axis.line.x.top                 : NULL\n",
       " $ axis.line.x.bottom              : NULL\n",
       " $ axis.line.y                     : NULL\n",
       " $ axis.line.y.left                : NULL\n",
       " $ axis.line.y.right               : NULL\n",
       " $ axis.line.theta                 : NULL\n",
       " $ axis.line.r                     : NULL\n",
       " $ legend.background               : list()\n",
       "  ..- attr(*, \"class\")= chr [1:2] \"element_blank\" \"element\"\n",
       " $ legend.margin                   : 'margin' num [1:4] 5.5points 5.5points 5.5points 5.5points\n",
       "  ..- attr(*, \"unit\")= int 8\n",
       " $ legend.spacing                  : 'simpleUnit' num 11points\n",
       "  ..- attr(*, \"unit\")= int 8\n",
       " $ legend.spacing.x                : NULL\n",
       " $ legend.spacing.y                : NULL\n",
       " $ legend.key                      : list()\n",
       "  ..- attr(*, \"class\")= chr [1:2] \"element_blank\" \"element\"\n",
       " $ legend.key.size                 : 'simpleUnit' num 1.2lines\n",
       "  ..- attr(*, \"unit\")= int 3\n",
       " $ legend.key.height               : NULL\n",
       " $ legend.key.width                : NULL\n",
       " $ legend.key.spacing              : 'simpleUnit' num 5.5points\n",
       "  ..- attr(*, \"unit\")= int 8\n",
       " $ legend.key.spacing.x            : NULL\n",
       " $ legend.key.spacing.y            : NULL\n",
       " $ legend.frame                    : NULL\n",
       " $ legend.ticks                    : NULL\n",
       " $ legend.ticks.length             : 'rel' num 0.2\n",
       " $ legend.axis.line                : NULL\n",
       " $ legend.text                     :List of 11\n",
       "  ..$ family       : NULL\n",
       "  ..$ face         : NULL\n",
       "  ..$ colour       : NULL\n",
       "  ..$ size         : 'rel' num 0.8\n",
       "  ..$ hjust        : NULL\n",
       "  ..$ vjust        : NULL\n",
       "  ..$ angle        : NULL\n",
       "  ..$ lineheight   : NULL\n",
       "  ..$ margin       : NULL\n",
       "  ..$ debug        : NULL\n",
       "  ..$ inherit.blank: logi TRUE\n",
       "  ..- attr(*, \"class\")= chr [1:2] \"element_text\" \"element\"\n",
       " $ legend.text.position            : NULL\n",
       " $ legend.title                    :List of 11\n",
       "  ..$ family       : NULL\n",
       "  ..$ face         : NULL\n",
       "  ..$ colour       : NULL\n",
       "  ..$ size         : NULL\n",
       "  ..$ hjust        : num 0\n",
       "  ..$ vjust        : NULL\n",
       "  ..$ angle        : NULL\n",
       "  ..$ lineheight   : NULL\n",
       "  ..$ margin       : NULL\n",
       "  ..$ debug        : NULL\n",
       "  ..$ inherit.blank: logi TRUE\n",
       "  ..- attr(*, \"class\")= chr [1:2] \"element_text\" \"element\"\n",
       " $ legend.title.position           : NULL\n",
       " $ legend.position                 : chr \"right\"\n",
       " $ legend.position.inside          : NULL\n",
       " $ legend.direction                : NULL\n",
       " $ legend.byrow                    : NULL\n",
       " $ legend.justification            : chr \"center\"\n",
       " $ legend.justification.top        : NULL\n",
       " $ legend.justification.bottom     : NULL\n",
       " $ legend.justification.left       : NULL\n",
       " $ legend.justification.right      : NULL\n",
       " $ legend.justification.inside     : NULL\n",
       " $ legend.location                 : NULL\n",
       " $ legend.box                      : NULL\n",
       " $ legend.box.just                 : NULL\n",
       " $ legend.box.margin               : 'margin' num [1:4] 0cm 0cm 0cm 0cm\n",
       "  ..- attr(*, \"unit\")= int 1\n",
       " $ legend.box.background           : list()\n",
       "  ..- attr(*, \"class\")= chr [1:2] \"element_blank\" \"element\"\n",
       " $ legend.box.spacing              : 'simpleUnit' num 11points\n",
       "  ..- attr(*, \"unit\")= int 8\n",
       "  [list output truncated]\n",
       " - attr(*, \"class\")= chr [1:2] \"theme\" \"gg\"\n",
       " - attr(*, \"complete\")= logi TRUE\n",
       " - attr(*, \"validate\")= logi TRUE"
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    },
    {
     "data": {
      "image/png": "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\nZAQ3hQAAAABJRU5ErkJggg=="
     },
     "metadata": {
      "image/png": {
       "height": 420,
       "width": 420
      }
     },
     "output_type": "display_data"
    }
   ],
   "source": [
    "# Create a bar plot showing the number of data points for each airline in the dataset.\n",
    "airline_counts <- sub_airline %>% \n",
    "    group_by(Reporting_Airline) %>%\n",
    "    summarize(Count = n()) # counts the number of data\n",
    "\n",
    "airline_counts %>% ggplot(aes(x =Reporting_Airline, y=Count)) +\n",
    "    geom_bar(stat = \"identity\", fill = \"steelblue\") +\n",
    "    labs(title = \"Number of Data points for each Airline Reportings\",\n",
    "        x = \"Airline\",\n",
    "        y = \"Number of Data Points\")\n",
    "   theme_minimal()"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "e9112d08",
   "metadata": {
    "papermill": {
     "duration": 0.017216,
     "end_time": "2024-10-18T07:25:49.287533",
     "exception": false,
     "start_time": "2024-10-18T07:25:49.270317",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "#### Which airlines have the most and least data points in the dataset?\n",
    "Airline_AA have the most data points and Airline_HP have the least data points in the dataset.\n",
    "\n",
    "#### How might the differences in the number of data points affect any analysis or conclusions drawn from this dataset?\n",
    "\n",
    "Airlines with more data points can yield more robust statistical analyses. A larger sample size increases the reliability of estimates and the ability to detect significant effects.\n",
    "#### Suggest one additional visualization that could provide further insights into the dataset.\n",
    "\n",
    "Box Plot of Arrival Delays by Airline: A box plot can be useful for visualizing the distribution of arrival delays (ArrDelay) for each airline. This will help identify variations in delays, outliers, and the overall performance of each airline.\n"
   ]
  }
 ],
 "metadata": {
  "kaggle": {
   "accelerator": "none",
   "dataSources": [],
   "dockerImageVersionId": 30749,
   "isGpuEnabled": false,
   "isInternetEnabled": true,
   "language": "r",
   "sourceType": "notebook"
  },
  "kernelspec": {
   "display_name": "R",
   "language": "R",
   "name": "ir"
  },
  "language_info": {
   "codemirror_mode": "r",
   "file_extension": ".r",
   "mimetype": "text/x-r-source",
   "name": "R",
   "pygments_lexer": "r",
   "version": "4.4.0"
  },
  "papermill": {
   "default_parameters": {},
   "duration": 9.405791,
   "end_time": "2024-10-18T07:25:49.427502",
   "environment_variables": {},
   "exception": null,
   "input_path": "__notebook__.ipynb",
   "output_path": "__notebook__.ipynb",
   "parameters": {},
   "start_time": "2024-10-18T07:25:40.021711",
   "version": "2.6.0"
  }
 },
 "nbformat": 4,
 "nbformat_minor": 5
}
