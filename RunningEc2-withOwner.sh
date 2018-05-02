#!/bin/bash
echo "Hi Team,"
echo "Please find the list of running EC2-instances,kindly revert back if you need your instances running"
echo ""
echo "****************************************************************************************************"

for region in $(aws ec2 describe-regions --query 'Regions[].{Name:RegionName}' --output text )
do
 echo "Currently in $region Running EC2 instances is/are:"
 for instance in $(aws ec2 describe-instances --region $region --filters Name=instance-state-name,Values=running --query 'Reservations[*].Instances[*].{InstanceId:InstanceId}' --output text)
 do
    echo "InstanceId is $instance ,owned by $(aws cloudtrail lookup-events --lookup-attributes AttributeKey=EventName,AttributeValue=RunInstances  --region $region --query "Events[*].[Username,Resources[?ResourceName=='$instance']]" --output text|grep -B 1 $instance|head -1)"
 done
 echo "--------------------------------------------------------------"
done

echo "****************************************************************************************************"
echo ""
echo "Thanks and Regards,"
echo "CloudOps-Tier1"
