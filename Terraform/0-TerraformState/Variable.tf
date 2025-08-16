variable "Environment" {
  description = "The environment for the Terraform deployment"
  type        = string
  default     = "DevOps-Projetos_AWS"

}
variable "AWS_REGION" {
  description = "The AWS region to deploy resources"
  type        = string
  default     = "us-east-2"
}   