
# Install Packages
from urllib.request import urlopen
import requests
import json
import csv
import numpy as np

# Create Empty URL to pass to Indeed API
# items in brackets are replaced by User Inputs via R Code
base = 'http://api.indeed.com/ads/apisearch?'
static = 'v=2&format=json&limit=25'
publisher='publisher=<acct>'
loc = 'l=<zip_code>'
q = 'q=<query>'
age_str = 'fromage='

counts = []
ages = []

for i in range(0, <max_age_param>, <by_age_param>):
    age_param = i
    age = age_str + str(age_param)
    url = "&".join([base, publisher, static, loc, q, age])
    response = requests.get(url)
    parsed_json = json.loads(response.text)
    counts.append(parsed_json['totalResults'])
    ages.append(i)

matrix = np.array((counts,ages)).T
