import json

from boto3 import Session

STATE_FILE = 'statefile'
BUCKET_NAME = 'prod-coaching-classroom-user-statefile'
REGION = 'us-east-1'


def get_s3_source_file(region, bucket_name):
    aws_session = Session(region_name=region)
    s3 = aws_session.resource('s3')
    s3_file_object = s3.Object(bucket_name, STATE_FILE).get()
    return json.load(s3_file_object['Body'])


def get_classroom_user_credentials(resources):
    user_credentials = []
    instances = [resource['instances'] for resource in resources if resource.get('type') == 'aws_iam_access_key']
    for instance in instances[0]:
        attributes = instance.get('attributes')
        user_credentials.append({'user': attributes.get('id'), 'secret': attributes.get('secret')})
    return user_credentials


resources = get_s3_source_file(REGION, BUCKET_NAME).get('resources')
credentials = get_classroom_user_credentials(resources)
for credential in credentials:
    print('User: ' + credential['user'])
    print('Secret: ' + credential['secret'])
