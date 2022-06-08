#!/bin/bash
externalid="env0"$(date +%d%m)
snstopic=$(aws sns list-topics | grep cloudwatch)
sed -i "s/externalid/$externalid/" trust.json
aws iam create-role --role-name Cloudnexa-Env0 --assume-role-policy-document file://trust.json
aws iam update-role --role-name Cloudnexa-Env0 --description 'allows Env0 access Cloudnexa' --max-session-duration 28800
aws iam attach-role-policy --policy-arn arn:aws:iam::aws:policy/CloudWatchFullAccess --role-name Cloudnexa-Env0
aws iam attach-role-policy --policy-arn arn:aws:iam::aws:policy/ReadOnlyAccess --role-name Cloudnexa-Env0
aws iam attach-role-policy --policy-arn arn:aws:iam::aws:policy/AmazonEventBridgeFullAccess --role-name Cloudnexa-Env0
aws iam get-role --role-name Cloudnexa-Env0
rolearn=$(aws iam get-role --role-name Cloudnexa-Env0 | grep Arn)
echo "ExternalID is $externalid
echo "Sns topic is $snstopic"
echo "RoleARN is $rolearn "
