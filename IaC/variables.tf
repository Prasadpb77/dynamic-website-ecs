variable "aws_region" {
  description = "The AWS region things are created in"
}

variable "app_port" {
  description = "Port exposed by the docker image to redirect traffic to"
  default     = 80
}

variable "app_port_2" {
  description = "Port exposed by the docker image to redirect traffic to"
  default     = 5000
}

variable "app_count" {
  description = "Number of docker containers to run"
  default     = 1
}

variable "health_check_path" {
  default = "/"
}

variable "fargate_cpu" {
  description = "Fargate instance CPU units to provision (1 vCPU = 1024 CPU units)"
  default     = "1024"
}

variable "fargate_memory" {
  description = "Fargate instance memory to provision (in MiB)"
  default     = "2048"
}

variable "public_subnet" {
  description = "public subnet which would be used by loadbalancer"
  default     = "subnet-0aa88c728d36e67e5"
}

variable "private_subnet" {
  description = "private subnet which would be used by ecs"
  default     = "subnet-067b756a1fe79b1c4"
}

variable "vpc_id" {
  description = "vpc id used by the application"
  default     = "vpc-074ed8073bb88a2d0"
}