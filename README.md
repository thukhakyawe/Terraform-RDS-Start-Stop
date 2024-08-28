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