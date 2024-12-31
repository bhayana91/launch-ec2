variable "access_key" {}
variable "secret_key" {}
variable "awsRegion" {
    description = "AWS region to deploy resources"
    type        = string
    default     = "ap-south-1"
}
variable "instanceType" {
    description = "Instance type"
  type        = string
  default     = "t2.micro"
}
variable "instanceName" {
    description = "Tag for EC2 instance"
  type        = string
  default     = "Terraform-EC2"
}
variable "subnet_id" {
    description = "subnet for EC2 instance"
  type        = string
  default     = "subnet-02bf5ed930efbb38d"
  }
variable "vpc_id" {
    description = "VPC ID for EC2 instance"
  type        = string
  default     = "vpc-0b624db0ee4ea6d7f"
  }
