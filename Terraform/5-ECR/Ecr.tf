resource "aws_ecr_repository" "repository-bia" {
  name                 = var.environment
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}

/*
https://www.youtube.com/watch?v=KvlHLJkJ0bY
https://github.com/CumulusCycles/IaC_on_AWS_with_Terraform/blob/main/src/5_Terraform_ECR_ECS/main.tf
https://github.com/Juanmichael00/terraform/blob/main/modulo-efs/efs.tf
https://www.youtube.com/watch?v=bIPF_hzmQGE&list=PLWQmZVQayUUIgSmOj3GPH2BJcn0hOzIaP
https://www.youtube.com/watch?v=bIPF_hzmQGE&list=PLWQmZVQayUUIgSmOj3GPH2BJcn0hOzIaP
https://www.youtube.com/watch?v=bIPF_hzmQGE&list=PLWQmZVQayUUIgSmOj3GPH2BJcn0hOzIaP
https://github.com/itirohidaka


aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 654654346517.dkr.ecr.us-east-1.amazonaws.com
docker build -t repository_glpi .
docker tag repository_glpi:latest 654654346517.dkr.ecr.us-east-1.amazonaws.com/repository_glpi:latest
docker push 654654346517.dkr.ecr.us-east-1.amazonaws.com/repository_glpi:latest


    Retrieve an authentication token and authenticate your Docker client to your registry. Use the AWS CLI:

aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 654654346517.dkr.ecr.us-east-1.amazonaws.com
Note: If you receive an error using the AWS CLI, make sure that you have the latest version of the AWS CLI and Docker installed.
Build your Docker image using the following command. For information on building a Docker file from scratch see the instructions here
. You can skip this step if your image is already built:
docker build -t repository_glpi .
After the build completes, tag your image so you can push the image to this repository:
docker tag repository_glpi:latest 654654346517.dkr.ecr.us-east-1.amazonaws.com/repository_glpi:latest
Run the following command to push this image to your newly created AWS repository:
docker push 654654346517.dkr.ecr.us-east-1.amazonaws.com/repository_glpi:latest

docker  build -t  glpi-g6 . --no-cache

23/09/2024
aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 654654346517.dkr.ecr.us-east-1.amazonaws.com
aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 654654346517.dkr.ecr.us-east-1.amazonaws.com

docker build -t repository_glpi .
docker build -t repository_glpi .

docker tag repository_glpi:latest 654654346517.dkr.ecr.us-east-1.amazonaws.com/repository_glpi:latest
docker tag repository_glpi:latest 654654346517.dkr.ecr.us-east-1.amazonaws.com/repository_glpi:latest

docker push 654654346517.dkr.ecr.us-east-1.amazonaws.com/repository_glpi:latest
docker push 654654346517.dkr.ecr.us-east-1.amazonaws.com/repository_glpi:latest

*/
