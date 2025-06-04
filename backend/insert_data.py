import json
import boto3

def lambda_handler(event, context):
    # print("Received event:", event)
    instance = event['fname']
    region = event['lname']
    action = event['action']

    dynamodb = boto3.resource('dynamodb')
    table = dynamodb.Table('connect-ec2')

    insert_item_resp = table.put_item(
        Item={
            'instanceid': instance,
            'region': region,
            'action': action
        }
    )

    return ("data saved to dynamo db")
