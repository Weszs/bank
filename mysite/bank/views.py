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

def save_user_info(request):
    if request.method == 'POST':
        # Process the request data
        return JsonResponse({"message": "User info saved successfully"})
    else:
        return JsonResponse({"error": "Only POST requests are allowed"}, status=405)
