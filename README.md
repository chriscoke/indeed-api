# Indeed API

# Overview of code:
# Takes as input zip codes and job titles
# Goes and gets total number of job postings within the specified time frame (i.e. job postings that are no greater than a certain age)
# Plots the cumulative distribution of job posting ages, by category
# This is an initial exploratory script to try and determine if certain [geographies/industries/jobs/etc.] have a different distribution than others, implying that jobs are posted and filled at different rates

# File Explanation:
# indeed_api.R -- this allows the user to input certain parameters and file paths in order to query Indeed for search results
# indeed_api_query.py -- underlying python code to pass search parameters to Indeed 
# indeed_api.html -- sample output (if opened in browser)
