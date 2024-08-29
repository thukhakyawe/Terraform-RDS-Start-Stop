# Terraform-RDS-Start-Stop

I will write detail in here soon.
All you need to do is 

1.Tag EC2 as
tag_key = 'AutoStartStop'
tag_value = 'true'

2.Change UTC Time according to Myanmar Time at terraform.tfvars

3. Command to run steps by steps

1.terraform init

2.terraform fmt

3.terraform validate

4.terraform plan

5.terraform apply -auto-approve

6.terraform destroy -auto-approve

That it is.
-------

Please note:

The Terraform configuration for automatically starting and stopping RDS instances may not work as expected for Amazon Aurora MySQL clusters due to differences in how standard RDS instances and Aurora clusters are managed by AWS.

Key Differences:
Aurora Clusters vs. Instances:

Amazon Aurora is composed of a cluster, which consists of one or more DB instances (reader and writer nodes).
The rds:start-db-instance and rds:stop-db-instance actions that work with standard RDS instances are not directly applicable to Aurora clusters. Instead, you have to manage the entire cluster rather than individual instances within the cluster.
Aurora-Specific Actions:

Aurora clusters use different API actions: rds:start-db-cluster and rds:stop-db-cluster. These actions start or stop all instances in the Aurora cluster simultaneously.
Modifying Your Terraform Configuration:
To manage Aurora MySQL clusters, you'll need to update the Lambda function to handle clusters instead of individual instances.
