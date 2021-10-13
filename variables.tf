########################### Project Config ################################

variable "prefix" {
  default = "<staging/production>"
}
variable "project" {
  default = "<projectName>"
}

variable "region" {
  default = "<AWSregion>"
}


variable "contact" {
  default = "amirjaved665980@gmail.com"
}


########################### S3 Bucket for env vars ################################
variable "s3_bucket_env" {
  description = "S3 bucket containing environment variables file"
  default     = "arn:aws:s3:::<projectName>-configs"
}


########################### VPC/Network Config ################################
variable "vpc_id" {
  description = "VPC Id for AWS Account"
  default     = "vpc-029XXXXXXX"
}

variable "subnet_a" {
  description = "public Subnet Id for AWS Account VPC"
  default     = "subnet-039XXXXXXX"
}

variable "subnet_b" {
  description = "public Subnet Id for AWS Account VPC"
  default     = "subnet-0758XXXXXXX"
}

########################### Autoscale Config ################################

variable "max_instance_size" {
  description = "Maximum number of instances in the cluster"
  default     = 1
}

variable "min_instance_size" {
  description = "Minimum number of instances in the cluster"
  default     = 1
}

variable "desired_capacity" {
  description = "Desired number of instances in the cluster"
  default     = 1
}

########### Key Pair for ssh access to ec2 instances ########
variable "key_name" {
  default = "<projectName>-key"
}

########### Default port for nginx and load balancer ########
variable "port" {
  default     = 80
  description = "Application port (default: 80)"
}

##################### Env vars  ##########################
variable "env_variables" {
  default = [
    {
      "name" : "MONGO_USER",
      "value" : "mongo"
    },
    {
      "name" : "MONGO_PASSWORD",
      "value" : "mongopass"
    },
    {
      "name" : "MONGO_HOST",
      "value" : "localhost:27017"
    },
  ]
}

