-----
# POC Plan Outline TGW and Autoscale demo  
-----
Note: the ip and urls are for example only, you will discover your own  

SSH to management 52.64.xx.218   
   cloudguard on  (one time) due script not working correctly   

Login to Manager gui 52.64.xx.218  
Create DC object AWS  
Create rule 3.1 add destination Spoke2SG to any    
Install rules   
SSH to outbound gateway TGW admin@13.239.47.109  
[Expert@TGW-gw]# pep show user all should see the SG above  

Load balancers application test

ALB http://CP-TGW-External-ALB-1053723218.ap-southeast-2.elb.amazonaws.com  
ALB http://CP-TGW-External-ALB-1053723218.ap-southeast-2.elb.amazonaws.com/app1/  
ALB http://CP-TGW-External-ALB-1053723218.ap-southeast-2.elb.amazonaws.com/app2/  

NLB1 http://CP-TGW-External-NLB-06cd39b7de71ae2f.elb.ap-southeast-2.amazonaws.com  
NLB2 http://CP-TGW-External-NLB2-f4133e3dc2973229.elb.ap-southeast-2.amazonaws.com  
  
SSH to application server   
First create a private key on the jumpbox (one time only)  
[Expert@gw-5e27da:0]# cat > .ssh/myidentity  
-----BEGIN RSA PRIVATE KEY-----  
7YG4yHjNupzAoZ0YSTzGhsgPhPtpmnUIvbSGNf1C……  
…….-----END RSA PRIVATE KEY-----  
^d  
[Expert@gw-5e27da:0]# chmod +600 .ssh/myidentity  
now ssh to application server (you can also ssh to web servers )
[Expert@gw-5e27da:0]# ssh -i ~/.ssh/myidentity  ubuntu@ip-10-120-176-115.ap-southeast-2.compute.internal  
  
watch logs in GUI while accessing the load balancers     
Show rule 3.1 logging the packets  
Note: NLB cannot have a security group 

This test shows E-W traffic inspection   
ubuntu@ip-10-120-176-115:~$ curl CP-TGW-Internal-NLB-4e1960bacd7f7606.elb.ap-southeast-2.amazonaws.com
Greetings! -----App1----- This is a web server in ap-southeast-2c!

ubuntu@ip-10-120-176-115:~$ curl CP-TGW-Internal-NLB-app2-e07fc6e2a95516c1.elb.ap-southeast-2.amazonaws.com
Greetings! -----app2----- This is a web server in ap-southeast-2c!

ubuntu@ip-10-120-176-115:~$ curl google.com  
<HTML><HEAD><meta http-equiv="content-type" content="text/html;charset=utf-8">  

Testing threat
curl http://www.eicar.org/download/eicar_com.zip
curl http://sc1.checkpoint.com/za/images/threatwiki/pages/TestAntiBotBlade.html

Scale up both the gateway groups + see the lb groups get created in the policy    
 
Application Control – setup policy + test so that you can see the urls in the logs   
https://supportcenter.checkpoint.com/supportcenter/portal?eventSubmit_doGoviewsolutiondetails=&solutionid=sk112575  

