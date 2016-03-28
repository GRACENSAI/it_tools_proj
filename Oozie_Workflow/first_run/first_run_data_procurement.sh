## Run daily weather data procurement script

python /Weather_Forecast_Script/forecast_io_get_daily_weather_data.py

## Untar the Daily_Data_Stage

for a in /Daily_Data_Stage/*.gz
do
    tar -xzvf "$a" -C /Daily_Data_Stage/
done

## To change the "," to "." for comparison purposes
sed -ir 's/[,]/./g' /Daily_Data_Stage/Order_*.csv

## To delete the file wit .csvr extension
#rm Order_*.csvr


## Rename the files

mv /Daily_Data_Stage/{Order_*.csv,Order.csv}

mv /Daily_Data_Stage/{Catalogue_*.csv,Catalogue.csv}

mv /Daily_Data_Stage/{Customer_*.csv,Customer.csv}

mv /Daily_Data_Stage/{Product_Reference_*.csv,Product_Reference.csv}

mv /Daily_Weather_Stage/{weather_forecast_*.csv,weather_forecast.csv}


