import json
import boto3

# Initialize the DynamoDB client
dynamodb = boto3.resource('dynamodb')
table = dynamodb.Table('connect-ec2')

def lambda_handler(event, context):
    try:
        # Fetch items from DynamoDB
        response = table.scan()

        # Get the first three items
        items = response.get('Items', [])[:3]

        return {
            "statusCode": 200,
            "headers": {
                "Content-Type": "application/json",
                "Access-Control-Allow-Origin": "*"  # Allow frontend to access the API
            },
            "body": json.dumps(items)
        }

    except Exception as e:
        return {
            "statusCode": 500,
            "body": json.dumps({"error": str(e)})
        }
