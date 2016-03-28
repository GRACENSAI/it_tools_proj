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


## Hive - Create tables

hive -f /Hive_Scripts/First_Time_Run/create_tables.hql


## Hive - Load the staging tables

hive -f /Hive_Scripts/First_Time_Run/load_data_stg_first_time.hql

## Hive - Update intermediate tables

hive -f /Hive_Scripts/First_Time_Run/update_intermediate_first_time.hql

## Hive - Update aggrigate tables

hive -f /Hive_Scripts/First_Time_Run/update_aggrigate_first_time.hql


## Attach time-stamp to weather_forecast file

now=$(date +"%Y-%m-%d-%S")
mv /Daily_Weather_Stage/{weather_forecast_*.csv,weather_forecast_$now.csv}


## Data Archiving ##

## Cut/Paste the tar file from Daily-Data_Stage & Data_Weather_Stage folder to Data_Archive folder

mv /Daily_Data_Stage/*.tar.gz /Data_Archive/

mv /Daily_Weather_Stage/*.csv /Data_Archive/

