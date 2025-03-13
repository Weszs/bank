from django.http import JsonResponse
from django.views.decorators.csrf import csrf_exempt
import json
from .models import UserInfo  

@csrf_exempt  # Disable CSRF protection for simplicity (not recommended for production)
def save_user_info(request):
    if request.method == 'POST':
        try:
            # Parse the JSON data from the request body
            data = json.loads(request.body)
            name = data.get('name')
            email = data.get('email')

            # Validate the data
            if not name or not email:
                return JsonResponse({"error": "Name and email are required"}, status=400)

            # Save the data to the database
            try:
                UserInfo.objects.create(name=name, email=email)
                return JsonResponse({"success": "Data saved successfully"})
            except Exception as e:
                return JsonResponse({"error": str(e)}, status=500)
        except json.JSONDecodeError:
            return JsonResponse({"error": "Invalid JSON data"}, status=400)
    else:
        return JsonResponse({"error": "Invalid request method"}, status=405)