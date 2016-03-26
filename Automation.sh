## Run daily weather data procurement script

python forecast_io_get_daily_weather_data.py

## Untar the Daily_Data_Stage

for a in /home/cloudera/Desktop/it_tools_project/Daily_Data_Stage/*.gz
do
    tar -xzvf "$a" -C /home/cloudera/Desktop/it_tools_project/Daily_Data_Stage/
done

## To change the "," to "." for comparison purposes
sed -ir 's/[,]/./g' /home/cloudera/Desktop/it_tools_project/Daily_Data_Stage/Order_*.csv

## To delete the file wit .csvr extension
#rm Order_*.csvr


## Rename the files

mv /home/cloudera/Desktop/it_tools_project/Daily_Data_Stage/{Order_*.csv,Order.csv}

mv /home/cloudera/Desktop/it_tools_project/Daily_Data_Stage/{Catalogue_*.csv,Catalogue.csv}

mv /home/cloudera/Desktop/it_tools_project/Daily_Data_Stage/{Customer_*.csv,Customer.csv}

mv /home/cloudera/Desktop/it_tools_project/Daily_Data_Stage/{Product_Reference_*.csv,Product_Reference.csv}

mv /home/cloudera/Desktop/it_tools_project/Daily_Weather_Stage/{weather_forecast_*.csv,weather_forecast.csv}


## Hive - Load the data into tables

hive -f load_data_stg_daily.hql

## Hive - Update intermediate tables

hive -f update_intermediate.hql

## Hive - Update master tables

hive -f update_aggrigate.hql


## Attach time-stamp to weather_forecast file

now=$(date +"%Y-%m-%d-%S")
mv /home/cloudera/Desktop/it_tools_project/Daily_Weather_Stage/{weather_forecast_*.csv,weather_forecast_$now.csv}


## Data Archiving ##

## Cut/Paste the tar file from Daily-Data_Stage & Data_Weather_Stage folder to Data_Archive folder

mv /home/cloudera/Desktop/it_tools_project/Daily_Data_Stage/*.tar.gz /home/cloudera/Desktop/it_tools_project/Data_Archive/

mv /home/cloudera/Desktop/it_tools_project/Daily_Weather_Stage/*.csv /home/cloudera/Desktop/it_tools_project/Data_Archive/

