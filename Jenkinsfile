#!groovy​

node {
   stage 'checkout'
        checkout scm

     stage 'test'
        parallel (
            phase1: { sh "echo p1; sleep 20s; echo phase1" },
            phase2: { sh "echo p2; sleep 40s; echo phase2" }
        )

   stage 'dependencies'
        sh "test -f bin/terraform || (mkdir -p bin && wget https://releases.hashicorp.com/terraform/0.8.1/terraform_0.8.1_linux_amd64.zip && unzip terraform_0.8.1_linux_amd64.zip -d bin/)"
   
   stage 'state'
        sh "rm -rf .terraform"
        sh "rm -f terraform.tfstate*"
   
   stage name: 'build', concurrency: 1
        echo "packer build project.json"

   stage name: 'plan', concurrency: 1
        sh "bin/terraform plan --out plan.tfplan terraform/"

   stage name: 'deploy', concurrency: 1
        def deploy_validation = input(
            id: 'Deploy',
            message: 'Lets continue to deploy the plan',
            type: "boolean")

        sh "bin/terraform apply plan.tfplan"
}
