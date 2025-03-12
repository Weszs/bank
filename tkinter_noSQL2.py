import requests

def insert(name, address):
    url = "http://127.0.0.1:8000/add_record/"
    data = {"name": name, "address": address}
    response = requests.post(url, json=data)
    print(response.text)

    
