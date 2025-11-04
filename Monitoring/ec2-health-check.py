import boto3

# Connect to EC2 service
ec2 = boto3.client("ec2")

def check_ec2_health():
    print("Checking EC2 instance system health...\n")

    # Get all instances
    response = ec2.describe_instance_status(IncludeAllInstances=True)

    for instance in response["InstanceStatuses"]:
        instance_id = instance["InstanceId"]
        system_status = instance["SystemStatus"]["Status"]
        instance_status = instance["InstanceStatus"]["Status"]

        print(f"Instance: {instance_id} | System Status: {system_status} | Instance Status: {instance_status}")

        # Restart if unhealthy
        if system_status != "ok" or instance_status != "ok":
            print(f"⚠️ Instance {instance_id} is unhealthy → Restarting...")
            ec2.reboot_instances(InstanceIds=[instance_id])
            print(f"✅ Instance {instance_id} restarted successfully.\n")
        else:
            print("✅ Instance is healthy.\n")

check_ec2_health()
