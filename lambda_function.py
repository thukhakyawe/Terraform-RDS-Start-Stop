import boto3
import json
import logging

# Initialize the RDS client
rds_client = boto3.client('rds')

# Set up logging
logger = logging.getLogger()
logger.setLevel(logging.INFO)

def handler(event, context):
    action = event.get('action')
    tag_key = 'AutoStartStop'
    tag_value = 'true'

    try:
        # Retrieve the list of RDS instances
        instances = rds_client.describe_db_instances()
    except Exception as e:
        logger.error(f"Error describing DB instances: {e}")
        return {
            'statusCode': 500,
            'body': json.dumps(f"Error describing DB instances: {e}")
        }
    
    instance_ids = []
    
    for instance in instances['DBInstances']:
        db_instance_arn = instance['DBInstanceArn']
        try:
            # Retrieve tags for each RDS instance
            tags = rds_client.list_tags_for_resource(ResourceName=db_instance_arn)
        except Exception as e:
            logger.error(f"Error listing tags for resource {db_instance_arn}: {e}")
            continue
        
        # Check if the instance has the specified tag
        if any(tag['Key'] == tag_key and tag['Value'] == tag_value for tag in tags['TagList']):
            instance_ids.append(instance['DBInstanceIdentifier'])

    if not instance_ids:
        return {
            'statusCode': 200,
            'body': json.dumps('No instances found with the specified tag.')
        }

    for instance_id in instance_ids:
        try:
            if action == 'start':
                rds_client.start_db_instance(DBInstanceIdentifier=instance_id)
                logger.info(f"Started RDS instance: {instance_id}")
            elif action == 'stop':
                rds_client.stop_db_instance(DBInstanceIdentifier=instance_id)
                logger.info(f"Stopped RDS instance: {instance_id}")
            else:
                return {
                    'statusCode': 400,
                    'body': json.dumps('Invalid action')
                }
        except Exception as e:
            logger.error(f"Error performing action {action} on RDS instance {instance_id}: {e}")
            return {
                'statusCode': 500,
                'body': json.dumps(f"Error performing action {action} on RDS instance {instance_id}: {e}")
            }

    return {
        'statusCode': 200,
        'body': json.dumps(f'RDS instances {action}d: {", ".join(instance_ids)}')
    }
