## Attach time-stamp to weather_forecast file

now=$(date +"%Y-%m-%d-%S")
mv /Daily_Weather_Stage/{weather_forecast_*.csv,weather_forecast_$now.csv}


## Data Archiving ##

## Cut/Paste the tar file from Daily-Data_Stage & Data_Weather_Stage folder to Data_Archive folder

mv /Daily_Data_Stage/*.tar.gz /Data_Archive/

mv /Daily_Weather_Stage/*.csv /Data_Archive/

