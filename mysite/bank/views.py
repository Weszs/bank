from django.shortcuts import render

# Create your views here.


from django.http import JsonResponse
from django.views.decorators.csrf import csrf_exempt
import json

@csrf_exempt
def add_record(request):
    if request.method == "POST":
        data = json.loads(request.body)
        name = data.get("name")
        address = data.get("address")
        print(f"Received: {name}, {address}")
        return JsonResponse({"message": "Data received successfully!"})
    return JsonResponse({"error": "Invalid request"}, status=400)
