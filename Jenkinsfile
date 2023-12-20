pipeline {
    agent any
    parameters {
        choice(name: 'ACTION', choices: ['apply', 'destroy'], description: 'Select action: apply or destroy')
    }
    environment {
        TERRAFORM_WORKSPACE = "/var/lib/jenkins/workspace/mysql/Mysql_Terraform/"
        INSTALL_WORKSPACE = "/var/lib/jenkins/workspace/mysql/"
    }
    stages {
        stage('Clone Repository') {
            steps {
               git branch: 'main', credentialsId: '0861634b-bd41-4c60-bece-2a8a0d8e1548', url: 'https://github.com/7828143960/Mysql_repo.git'
            }
        }
        stage('Terraform Init') {
            steps {
                // Initialize Terraform
                sh "cd ${env.TERRAFORM_WORKSPACE} && terraform init"
            }
        }

        stage('Terraform Plan') {
            steps {
                // Run Terraform plan
                sh "cd ${env.TERRAFORM_WORKSPACE} && terraform plan"
            }
        }
        stage('Approval For Apply') {
            when {
                expression { params.ACTION == 'apply' }
            }
            steps {
                // Prompt for approval before applying changes
                input "Do you want to apply Terraform changes?"
            }
        }

        stage('Terraform Apply') {
            when {
                expression { params.ACTION == 'apply' }
            }
            steps {
                // Run Terraform apply
                sh """
                    cd ${env.TERRAFORM_WORKSPACE}
                    terraform apply -auto-approve
                    sudo cp ${env.TERRAFORM_WORKSPACE}/mysql_key.pem ${env.INSTALL_WORKSPACE}
                    sudo chown jenkins:jenkins ${env.INSTALL_WORKSPACE}/mysql_key.pem
                    sudo chmod 400 ${env.INSTALL_WORKSPACE}/mysql_key.pem
                """
            }
        }

        stage('Approval for Destroy') {
            when {
                expression { params.ACTION == 'destroy' }
            }
            steps {
                // Prompt for approval before destroying resources
                input "Do you want to Terraform Destroy?"
            }
        }

        stage('Terraform Destroy') {
            when {
                expression { params.ACTION == 'destroy' }
            }
            steps {
                // Destroy Infra
                sh "cd ${env.TERRAFORM_WORKSPACE} && terraform destroy -auto-approve"
            }
        }
        stage('Mysql Deploy') {
            when {
                expression { params.ACTION == 'apply' }
            }
            steps {
                // Deploy mysql
                sh "cd ${env.INSTALL_WORKSPACE} && ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook sites.yml"
                    
            }
        }

    }

    post {
        success {
            script {
                if (params.ACTION == 'apply') {
                    emailext body: 'The build ${BUILD_NUMBER} is completed with status successful and Created Infra and Deploy Mysql on Target Host', subject: 'Build status: successful (apply)', to: 'jaiswalshreya37@gmail.com'
                } else if (params.ACTION == 'destroy') {
                    emailext body: 'The build ${BUILD_NUMBER} is completed with status successful and Destroy all infra ', subject: 'Build status: successful (destroy)', to: 'jaiswalshreya37@gmail.com'
                }
            }
        }
        failure {
            script {
                emailext body: 'The build ${BUILD_NUMBER} is completed with status Failure', subject: 'Build status: Failed', to: 'jaiswalshreya37@gmail.com'
            }
        }
    }
}
