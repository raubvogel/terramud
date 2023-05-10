# terramud
Terramud is a docker-based environment to develop and deploy infrastructure
as code using Terraform.
The idea is to provide a consistent environment without needing to muck
about with downloading the proper version of Terraform and supporting 
programs in the host: just spool the container up, feeding the directory
where the configuration files and custom modules are, and the unleash it.
Once you are done, get close/kill the container and off you go.

As of now it focuses on AWS, but it should be easily configured to work with
other clouds. Or I will add that later on.


