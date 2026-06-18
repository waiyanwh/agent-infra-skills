# AWS Checklists

## Networking

Check:
- VPC
- subnet route tables
- NACLs
- security groups
- DNS resolution
- Route53 records
- VPC endpoints
- NAT Gateway
- Internet Gateway
- Transit Gateway
- VPC peering
- PrivateLink
- load balancer target health
- cross-zone load balancing
- health check paths and ports

## IAM

Check:
- caller identity
- role trust policy
- identity policy
- resource policy
- permission boundaries
- SCPs
- session policy
- OIDC provider
- external ID
- condition keys
- region/account mismatch
- KMS permissions
- service-linked roles

## EKS

Check:
- cluster status
- Kubernetes version
- node groups
- node readiness
- CNI/IP exhaustion
- security groups for pods
- IAM roles for service accounts
- AWS Load Balancer Controller
- EBS CSI driver
- CoreDNS
- kube-proxy
- cluster autoscaler or Karpenter
- target group health
- subnet tags
- route tables
- NACLs
- pod events and logs

Use `kubernetes-engineer` as reviewer for Kubernetes workload and kubectl runtime details when needed.

## ECS

Check:
- service events
- task stopped reason
- task definition
- container logs
- target group health
- task IAM role
- execution role
- subnet/security group config
- capacity provider
- service desired/running count
- image pull errors
- secrets access
- CloudWatch logs

## RDS/Aurora

Check:
- instance status
- events
- CPU/memory/storage
- connections
- slow queries if available
- parameter group changes
- security groups
- subnet group
- backups
- failovers
- maintenance windows
- storage autoscaling
- replication lag

## Lambda

Check:
- error rate
- duration
- throttles
- concurrency
- cold starts
- CloudWatch logs
- IAM role
- VPC config
- subnet/NAT access
- environment variables
- event source mapping
- DLQ/destination config

## S3

Check:
- bucket policy
- IAM identity policy
- ACLs only if legacy
- Block Public Access
- KMS key policy
- encryption
- lifecycle rules
- replication
- event notifications
- object ownership
- VPC endpoint policy

## Cost/Quota

Check:
- recent usage increase
- service quotas
- NAT Gateway data processing
- CloudWatch log ingestion
- load balancer LCUs
- EBS unattached volumes
- snapshots
- data transfer
- idle RDS
- oversized instances
- high cardinality metrics
- failed/retried workloads
