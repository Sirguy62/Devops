#!/bin/bash

echo "Checking EC2 health status..."

instances=$(aws ec2 describe-instances --query 'Reservations[].Instances[].InstanceId' --output text)

for instance in $instances
do
    state=$(aws ec2 describe-instances --instance-id $instance --query 'Reservations[].Instances[].State.Name' --output text)
    status=$(aws ec2 describe-instance-status --instance-id $instance --query 'InstanceStatuses[].InstanceStatus.Status' --output text)

    echo "Instance: $instance | State: $state | Status: $status"

    if [[ "$state" == "stopped" ]]; then
        echo "⚠️ Instance is stopped → Starting $instance..."
        aws ec2 start-instances --instance-ids $instance > /dev/null
        echo "✅ Instance started."
        continue
    fi

    if [[ "$status" != "ok" ]]; then
        echo "⚠️ Instance is unhealthy → Restarting $instance..."
        aws ec2 reboot-instances --instance-ids $instance > /dev/null
        echo "✅ Instance rebooted."
    else
        echo "✅ Instance is healthy."
    fi

    echo ""
done
