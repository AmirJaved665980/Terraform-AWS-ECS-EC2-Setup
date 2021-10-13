# Terraform IaaC for AWS ECS, EC2 setup for deploying Dockerized web Application

## Prerequisites:
- AWS Account  (Root + IAM users)
- AWS CLI* 
- VSCode(Terraform extension by Anton Kulikov)  or any IDE
- GitHub/GitLab
- Terraform
- Docker/Docker Compose plus VSCode extension enabled (1.6.0)
- AWS Vault



## Getting started

- Setup AWS Account info for your project in ```main.tf``` and ```variables.tf```

- Create a session using AWS Vault as secure credential management as below:
```
aws-vault exec <ci-terraform-iam-user>  --duration=12h
```

- Initialize you backend with following command:
```
docker-compose run --rm terraform init
```


- Run following Terraform commands accordingly;
```
To Format:            docker-compose run --rm terraform fmt
To Validate:          docker-compose run --rm terraform validate
To see Plan:          docker-compose run --rm terraform plan
To Apply:             docker-compose run --rm terraform apply
To Destroy:           docker-compose run --rm terraform destroy  
Unlock State:         docker-compose run --rm terraform force-unlock 6374a6cb-120

```

## Follow up after AWS Setup
- CircleCI or Any CI CD technology
- CI CD pipeline should push images to ECR and deploy this to ECS cluster


### Repository structure:
- Mainly files and folders are as follows;

```
├── main.tf            <--> file for main project setup like s3 for state management of current Infrastructure on AWS
├── templates          <--> Folder containing AWS Policies and ECS task definition placeholder
├── autoscaling.tf     <--> file for autoscaling ec2 instances
├── ecr.tf             <--> file for creating ecr repos for holding docker images
├── ecs_*              <--> ecs cluster, service and task creation files
├── docker-compose.yml <--> file for executing terraform code using harshicorp terraform docker image
├── iam.tf             <--> file for creating roles ans IAM policy for EC2 ECS etc.
├── launch_config.tf   <--> file for creating EC2 configuration for our ECS cluster 
├── load_balancer.tf   <--> file for creating application load balancer for incoming traffic to web app
├── output.tf          <--> file for outputing the created resources like app url ecr repos names, and ecs cluster info
├── variables.tf       <--> file for creating variables to be reference in code like project name, region, port for nginx etc.
└── README.md
```

### Technologies used are:
- Docker Compose
- Terraform
- AWS ECS
- AWS ALB
- AWS AG
- AWS EC2
