# Cyber-Security-Bootcamp-Project-1---VN-with-ELK-STACK
Repository for the building and configuring a virtual network with an ELK stack
## Automated ELK Stack Deployment

The files in this repository were used to configure the network depicted below.

![This is an image](https://github.com/hartm0120/Cyber-Security-Bootcamp-Project-1---VN-with-ELK-STACK/blob/main/Diagrams/Project%201%20Network%20Diagram.png)

These files have been tested and used to generate a live ELK deployment on Azure. They can be used to either recreate the entire deployment pictured above. Alternatively, select portions of the playbook file may be used to install only certain pieces of it, such as Filebeat. The files used to configure this deployment includes:
Ansible.cfg
Playbook_file.yml
Hosts
Filebeat-config.yml
Filebeat-playbook.yml
Install-elk.yml
Metricbeat-config.yml
metricbeat-playbook.yml

This document contains the following details:
- Description of the Topology
- Access Policies
- ELK Configuration
  - Beats in Use
  - Machines Being Monitored
- How to Use the Ansible Build


### Description of the Topology

The main purpose of this network is to expose a load-balanced and monitored instance of DVWA, the D*mn Vulnerable Web Application.

Load balancing ensures that the application will be highly available, in addition to restricting direct access to the web servers from the internet. 

Load balancers provide a website with an external IP address that is accessed by the internet. The load balancer receives all traffic coming to the website and distributes it accordingly across the multiple and relevant web servers. As a website receives more traffic, more servers can be added to the pool the load balancer has access to, which can help distribute traffic evenly amongst the servers and mitigate against DDoS attacks.

The advantage of a jump box to your network essentially is that it facilitates a single gateway or node for traffic and access to your network. This makes it easier to design networks and implement routing logic, as well as more importantly it is more efficient from a security and monitoring perspective to focus on the interactions or single node between the jump box and other machines as opposed to the connections and interactions between all machines on the network. This process is called “fanning in”.

Integrating an ELK server allows users to easily monitor the vulnerable VMs for changes to the metrics and system logs.
- Filebeat is responsible for forwarding and centralising log data. When installed on your server, Filebeat monitors the log files or locations specified, collects log events, and forwards them either to Elasticsearch or Logstash for indexing.
- Metricbeat takes the metrics and statistics that it collects and ships them to the output specified, such as Elasticsearch or Logstash. Metricbeat helps you monitor your servers by collecting metrics from the system and services running on the server (ie. CPU, Memory, etc.).

The configuration details of each machine may be found below.

| Name         | Function   | IP Address               |   Operating System   |
|--------------|------------|--------------------------|:--------------------:|
| Jump Box     | Gateway    | 20.92.105.75 & 10.0.0.4  | Linux (ubuntu 20.04) |
| ELK server   | ELK server | 52.243.75.234 & 10.1.0.4 | Linux (ubuntu 20.04) |
| Web 1 server | Web server | 10.0.0.5                 | Linux (ubuntu 20.04) |
| Web 2 server | Web server | 10.0.0.6                 | Linux (ubuntu 20.04) |



### Access Policies

The machines on the internal network are not exposed to the public Internet.

Only the jump-box VM and ELK Server (accepts connections via HTTP:5601) can accept connections from the Internet. Access to these machines are only allowed from the following IP addresses:
- (Home/workstation IP - 125.168.206.240)

Machines within the network can only be accessed by SSH service.
The ELK VM can be accessed via HTTP connection via port 5601 from my home/workstation IP address only in order to interact with all log and metric data on the Kibana application. All admin and configuration related tasks can only be accessed via the Jump-Box VM IP and SSH service from the ansible keen_keppler container installed on this Jump-Box VM.

A summary of the access policies in place can be found in the table below.

| Name         | Publicly Accessible | Allowed IP Addresses |
|--------------|---------------------|----------------------|
| Jump Box     | No                  | Home IP              |
| Web 1 server | No                  | 10.0.0.4             |
| Web 2 server | No                  | 10.0.0.4             |
| ELK server   | No                  | Home IP & 10.0.0.4   |



### Elk Configuration

Ansible was used to automate configuration of the ELK machine. No configuration was performed manually, which is advantageous because this ensures that all of the provisioning scripts run identically across all machines. It also ensures that the automated configurations will do exactly the same thing every time they run, eliminating as much variability between configurations as possible and removes the risk of human error.

The playbook implements the following tasks:
- Force apt-get update and cache
- install python3-pip
- install Docker
- increase virtual memory to vm.max_map_count=262144
- download ELK image from sebp/elk:761 and install
- restart docker service when VM restarts

The following screenshot displays the result of running `docker ps` after successfully configuring the ELK instance.



### Target Machines & Beats
This ELK server is configured to monitor the following machines:
- 10.0.0.5
- 10.0.0.6

We have installed the following Beats on these machines:
- Filebeat
- Metricbeat

These Beats allow us to collect the following information from each machine:
- Filebeat captures and forwards all log files and events, including system.auth logs, which are essentially used to track user logon events on Linux systems.
-Metricbeat captures all metrics and statistics of the machines (ie. CPU, memory) and the services running on them. System.syslogs are a standardised way of producing and sending log and event information from Linux systems and devices to a centralised log and event message collector which is known as a syslog server.

### Using the Playbook
In order to use the playbook, you will need to have an Ansible control node already configured. Assuming you have such a control node provisioned:

SSH into the control node and follow the steps below:
- Copy the relevant playbook file (ie. filebeat-playbook.yml, metricbeat-playbook.yml, install-elk.yml, etc.) to /etc/ansible filepath.
- Update the hosts file to include the [webservers] and [elk] VMs. This filepath is /etc/ansible/hosts and should include the host name, internal IP address, as well as the script being used:

- [webservers]
- 10.0.0.5 ansible_python_interpreter=/usr/bin/python3
- 10.0.0.6 anisble_python_interpreter=/usr/bin/python3

- [elk]
- 10.1.0.4 ansible_python_interpreter=/usr/bin/python3

In order to specify which machine to install either ELK, filebeat or metricbeat, you simply specify which host at the beginning of your playbook file that you want to run and install the relevant applications or software included in your script. An example of the begining of the playbook to highlight this has been included below:

  
Run the playbook by running the command ansible-playbook [playbook-file-name].yml. To confirm the ELK playbook installed as expected run the command sudo docker ps, and navigate to http://52.243.75.234:5601/app/kibanna to check that the installation is working as expected. Please refer to the ansible folder for all playbook and config files for more detail.

### Testing the system and using the Kibana App

To ensure the system is working and the ELK server is receiving both the logs and metrics data from the web servers, we conducted three separate tests while using the Kibana application to visualise the data ELK server was receiving, including the following:
- SSH barrage script - a for/while nested loop script was created to run from the Jump-Box VM which attempted multiple SSH connections. These were not successful due to the access policies implemented; however, we were able to see the system.auth logs in the log feed on Kibana indicating unauthorised SSH connections were attempted.
- Wget-DOS script - a for/while nested loop script was created to run from the Jump-Box VM which pinged the web severs to increase the traffic and simulate a Denial of Service (DoS) attack. Using the the metrics dashboard on the Kibana app to we could visualise the network traffic entering and exiting the web servers, which illustrated incoming traffic significantly increased.
- Stress Test - finally we SSH into both web servers and installed stress via the command "sudo apt install stress". Once the stress application was installed we ran the command "sudo stress --cpu 1 --timeout 180" to increase the CPU usage for 3 minutes. Similar to above with the Wget-DoS script we were able to use the metrics dashboard on Kibana to visualise the stress on the webserver and increase in CPU usage. 
