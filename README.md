# TGW
Terraform scripts for transit gateway demonstration of CloudGuard in AWS 
Builds the complete envionment with web and application servers

One time preparation of the AWS account 
1.	Create a ssh key-pair in the account for the DC you are using
2.	Subscribe to the ELUAs for R80.20 BYOL gateway and management (see attached)
    R80.20 management 
    https://aws.amazon.com/marketplace/pp/B07KSBV1MM?qid=1558349960795&sr=0-4&ref_=srh_res_product_title

    R80.20 Gateway
    https://aws.amazon.com/marketplace/pp/B07LB3YN9P?qid=1558349960795&sr=0-5&ref_=srh_res_product_title

3.	Create security credentials for the API login (for terraform)
4.  Ensure you have enough resources in the account, this script creates 6 VPC, 1 transit gateway and 12 instances, the cost for this will be a few dollars per hour, so it is recomended to destroy the resources when not using them

Modify the variables.tf to suite your needs 

The terraform script deploys these 3 CloudFormation templates with all the glue to configure them 
  template_url        = "https://s3.amazonaws.com/CloudFormationTemplate/management.json"
  template_url        = "https://s3.amazonaws.com/CloudFormationTemplate/checkpoint-tgw-asg-master.yaml"
  template_url        = "https://s3.amazonaws.com/CloudFormationTemplate/autoscale.json"

You can Logon after 30 mins to the manager via the Check Point SmartDashboard
To use an existing manager then some modifications will be needed to terraform scripts.

TGW documentation (Outbound cluster)
https://sc1.checkpoint.com/documents/IaaS/WebAdminGuides/EN/CP_CloudGuard_AWS_Transit_Gateway/html_frameset.htm

Autoscale Documentation (Inbound cluster)
https://supportcenter.checkpoint.com/supportcenter/portal?eventSubmit_doGoviewsolutiondetails=&solutionid=sk112575 

To run the script 
    terraform init
    terraform apply 

To remove the envionment 
set the autoscale group to 0 instances for the outbound group, wait a few minutes to allow the VPNs to be deleted then; 
    terraform destroy 