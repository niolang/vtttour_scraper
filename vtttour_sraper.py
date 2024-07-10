
import requests
import os

def download_gpx_files(base_url, start, end, output_directory):
    if not os.path.exists(output_directory):
        os.makedirs(output_directory)

    for i in range(start, end + 1):
        file_number = str(i)  # Format the number to 4 digits
        url = base_url+file_number
        response = requests.get(url)
        
        if response.status_code == 200:  # Check if the file exists
            file_path = os.path.join(output_directory, f"{file_number}.gpx")
            with open(file_path, 'wb') as file:
                file.write(response.content)
            print(f"Downloaded: {file_path}")
        else:
            print(f"File not found: {url}")

if __name__ == "__main__":
    base_url = "https://vttour.fr/downloadGPX/sentiers/"
    output_directory = "/home/nikdebpc/Documents/Coding/vtttour_scraper/gpx_files"
    start = 0
    end = 9999

    download_gpx_files(base_url, start, end, output_directory)
