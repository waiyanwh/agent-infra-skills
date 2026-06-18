# AWS CLI Command Reference

## Read-Only Commands (safe to run)

```bash
aws sts get-caller-identity
aws configure list
aws ec2 describe-regions
aws ec2 describe-vpcs
aws ec2 describe-subnets
aws ec2 describe-route-tables
aws ec2 describe-security-groups
aws ec2 describe-network-acls
aws elbv2 describe-load-balancers
aws elbv2 describe-target-groups
aws elbv2 describe-target-health --target-group-arn <target-group-arn>
aws route53 list-hosted-zones
aws acm list-certificates
aws cloudwatch describe-alarms
aws logs describe-log-groups
aws logs filter-log-events --log-group-name <log-group-name>
aws cloudtrail lookup-events
aws eks describe-cluster --name <cluster-name>
aws eks list-nodegroups --cluster-name <cluster-name>
aws ecs describe-services --cluster <cluster> --services <service>
aws rds describe-db-instances
aws lambda get-function --function-name <function-name>
aws s3api get-bucket-policy --bucket <bucket>
aws s3api get-bucket-encryption --bucket <bucket>
aws service-quotas list-service-quotas --service-code <service-code>
```

## Dangerous Commands (require explicit approval)

```text
aws iam create/update/delete/attach/detach
aws ec2 authorize-security-group-ingress
aws ec2 revoke-security-group-ingress
aws ec2 replace-route
aws route53 change-resource-record-sets
aws elbv2 modify-listener
aws elbv2 modify-target-group
aws eks update-cluster-config
aws ecs update-service
aws rds modify-db-instance
aws lambda update-function-configuration
aws s3api put-bucket-policy
aws cloudformation deploy/update/delete-stack
any command that creates, updates, deletes, restarts, scales, rotates, or changes production resources
```
