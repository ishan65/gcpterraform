## GCP - Terraform

![alt text](./gcp.png)

Feature | Branch | Detail
--- | --- | --- 
First HCL| [first_hcl](https://github.com/ishan65/gcpterraform/tree/first_hcl) | Simple HCL code to spin up compute
Compute with the external IP| [2_externalip_compute](https://github.com/ishan65/gcpterraform/tree/2_externalip_compute) | Attach Static IP to a compute
Compute with image in data key| [3_data_image](https://github.com/ishan65/gcpterraform/tree/3_data_image) | Use data keyword 
Compute in the default VPC| [4_firewall_compute](https://github.com/ishan65/gcpterraform/tree/4_firewall_compute) | Default VPC with output keyword
Compute with custom VPC| [5_compute_vpc](https://github.com/ishan65/gcpterraform/tree/5_compute_vpc) | Custom VPC with output keyword
Provide inputs from the variable to spin Compute in custom VPC| [6_varables_compute](https://github.com/ishan65/gcpterraform/tree/6_varables_compute) | Introducing variables
Compute in each zone with custom VPC| [7_list_count_compute](https://github.com/ishan65/gcpterraform/tree/7_list_count_compute) | Spin a compute resource in each zone in the Custom VPC
