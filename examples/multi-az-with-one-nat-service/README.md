## Multi AZ with one nat service

If you don't need to have a high availability (for dev environments for example), you can deploy your vpc with one nat service.

Warning, if the nat service is deployed in a region and this region has an outage, the other availability zone will no longer be able to communicate on the internet.