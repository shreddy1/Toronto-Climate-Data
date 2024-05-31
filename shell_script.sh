#!/bin/bash

# Define directories
DATA_DIR="./data"
LOG_DIR="./logs"
LOG_FILE="$LOG_DIR/download.log"

# Create directories if they do not exist
mkdir -p $DATA_DIR
mkdir -p $LOG_DIR

# Define Station ID and year range
STATION_ID=48549
YEARS=(2020 2021 2022)
MONTH=2

# Log function
log() {
    echo "$(date +'%Y-%m-%d %H:%M:%S') - $1" | tee -a $LOG_FILE
}

# Download data
log "Starting data download..."

for YEAR in "${YEARS[@]}"; do
    URL="https://climate.weather.gc.ca/climate_data/bulk_data_e.html?format=csv&stationID=${STATION_ID}&Year=${YEAR}&Month=${MONTH}&Day=14&timeframe=1&submit=Download+Data"
    wget --content-disposition "$URL" -P $DATA_DIR
    if [ $? -ne 0 ]; then
        log "Error downloading data for year $YEAR"
        exit 1
    else
        log "Successfully downloaded data for year $YEAR"
    fi
done

log "Data download completed."

# Run the Python script
log "Running Python script to concatenate data..."
python3 python_script.py

if [ $? -eq 0 ]; then
    log "Python script executed successfully."
    log "SUCCESS"
else
    log "Python script execution failed."
    exit 1
fi

# End of script
exit 0
