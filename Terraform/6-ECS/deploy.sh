#!/bin/bash

echo "=== Deploy ECS Infrastructure ==="

# Função para deploy
deploy_module() {
    local module_path=$1
    local module_name=$2
    
    echo "Deploying $module_name..."
    cd "$module_path" || exit 1
    
    terraform init
    terraform plan -out=plan.out
    
    read -p "Apply $module_name? (y/N): " confirm
    if [[ $confirm == [yY] ]]; then
        terraform apply plan.out
        echo "$module_name deployed successfully!"
    else
        echo "Skipping $module_name deployment"
    fi
    
    cd - > /dev/null
}

# Menu de opções
echo "Choose deployment option:"
echo "1) Deploy ECS EC2"
echo "2) Deploy ECS Fargate"
echo "3) Deploy Both"
echo "4) Exit"

read -p "Enter your choice (1-4): " choice

case $choice in
    1)
        deploy_module "EC2" "ECS EC2"
        ;;
    2)
        deploy_module "Fargate" "ECS Fargate"
        ;;
    3)
        deploy_module "EC2" "ECS EC2"
        deploy_module "Fargate" "ECS Fargate"
        ;;
    4)
        echo "Exiting..."
        exit 0
        ;;
    *)
        echo "Invalid option"
        exit 1
        ;;
esac

echo "=== Deployment Complete ==="