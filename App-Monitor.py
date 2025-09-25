
import requests
import sys
url = sys.argv[1] if len(sys.argv) > 1 else 'http://localhost:4499'
try:
    response = requests.get(url)
    if response.status_code == 200:
        print(f'UP: {url} is responding with status {response.status_code}')
    else:
        print(f'DOWN: {url} responded with status {response.status_code}')
except Exception as e:
    print(f'DOWN: {url} Exception: {e}')
