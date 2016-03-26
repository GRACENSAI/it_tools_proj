import csv
import json
from json import loads
from requests import get
import datetime
import time


APItoken = '3690260bd9d8977d5b9ead7e3fd4cac6'
ts = time.time()
#date = '2015-11-03T00:00:00'
date = datetime.datetime.fromtimestamp(ts).strftime('%Y-%m-%dT%H:%M:%S')
outfile = open('../Daily_Weather_Stage/weather_forecast_data_%s.csv'% (date) , 'w') 
with open('Daily_Weather_Stage/postalcode_lat_log.csv', "r") as ifile:
	reader = csv.reader(ifile, delimiter=';')
	for row in reader:
		pcode = row[0]
		lati = row[1]
		logi = row[2]
		request_url = 'https://api.forecast.io/forecast/' + APItoken + '/' + lati + ',' + logi + ',' + date
		r = get(request_url)
		data = loads(r.text)
		do = data['daily']['data'][0]
		a = csv.writer(outfile, delimiter=',')
		outdata = [(date,pcode,lati,logi,do['summary'],do['temperatureMin'],do['temperatureMax'],do['icon'])]
		a.writerows(outdata)
			
