import glob
import pandas as pd

# Define the data directory and output file
data_dir = './data'
output_file = 'all_years.csv'

# Find all CSV files in the data directory
csv_files = glob.glob(f'{data_dir}/*.csv')

# Initialize an empty list to hold dataframes
dataframes = []

# Read each CSV file and append to the list
for file in csv_files:
    df = pd.read_csv(file)
    dataframes.append(df)

# Concatenate all dataframes
all_data = pd.concat(dataframes, ignore_index=True)

# Save the concatenated dataframe to a CSV file
all_data.to_csv(output_file, index=False)

print("Data concatenation completed successfully.")
