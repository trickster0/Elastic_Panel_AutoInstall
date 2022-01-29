# ElasticEDR_Autoinstall
Spawn Up quickly Elastic EDR Panel


# Instructions

Just run autoinstall.sh to install Elastic panel quickly and use the EDR.  
This will setup the fleet server in the elasticsearch/kibana server.   
During the setup input will be asked, just replace (A)ll.  
This is setup for IP 192.168.2.70, if you want a different IP execute:  
`sed -i 's/192.168.2.70/xxx.xxx.xxx.xxx/g' *.yml`.   
Where xxx.xxx.xxx.xxx will be the Elastic Server IP.  
This was tested in Ubuntu 20.04, make sure to create a user called elastic for proper installation.  
In /home/elastic, there will be a passwords.txt file with all the passwords, you will mostly need the last one to login in the panel.  
certs.zip contains the ca.crt which you will need to install to install in all the hosts you will install the elastic agent.  
Every time you start the server make sure that port 5601 and 9200 are listening and also run elastic-agent.  
When you install the agent by using the command from the server add also the flags --insecure after you have installed ca.crt.  

Basically this is an automation of this [link](https://pawelbruski.com/posts/2021-08-04---Three-node-cluster-ElasticSearch-SIEM-and-EDR-7-14-installation-and-configuration/), if you need extract information about what the script does.
