#!/bin/bash
externalid="env0"$(date +%d%m)
aws iam create-role --role-name Cloudnexa-Env0 --assume-role-policy-document file://trust.json
aws iam update-role --role-name Cloudnexa-Env0 --description 'allows Env0 access Cloudnexa' --max-session-duration 28800
aws iam attach-role-policy --policy-arn arn:aws:iam::aws:policy/CloudWatchFullAccess --role-name Cloudnexa-Env0
aws iam attach-role-policy --policy-arn arn:aws:iam::aws:policy/ReadOnlyAccess --role-name Cloudnexa-Env0
aws iam attach-role-policy --policy-arn arn:aws:iam::aws:policy/AmazonEventBridgeFullAccess --role-name Cloudnexa-Env0
aws iam get-role --role-name Cloudnexa-Env0
