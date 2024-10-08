pipeline {
    agent any

    environment {
        GITHUB_REPO = 'https://github.com/andervafla/java_deploy.git' 
        TERRAFORM_DIR = 'terraformAWS'
    }

    stages {
        stage('Print Hello World') {
            steps {
                echo 'Hello, World!'
            }
        }

        stage('Install Terraform') {
            steps {
                sh '''
                        # Завантажте Terraform
                        wget https://releases.hashicorp.com/terraform/1.5.5/terraform_1.5.5_linux_amd64.zip
                        # Розпакуйте архів
                        unzip terraform_1.5.5_linux_amd64.zip
                        # Перемістіть бінарний файл в директорію, доступну для вашого користувача
                        mv terraform /usr/local/bin/
                        # Перевірте установку
                        terraform -version
                    '''
            }
        }

        stage('List Files in Root Directory') {
            steps {
                sh 'ls -la'
            }
        }

        stage('List Files in Terraform Directory') {
            steps {
                dir("${TERRAFORM_DIR}") {
                    sh 'terraform -version' 
                }
            }
        }

        stage('Initialize Terraform') {
            steps {
                dir("${TERRAFORM_DIR}") {
                    script {
                        sh 'terraform init'
                    }
                }
            }
        }

        stage('Apply Terraform') {
            steps {
                dir("${TERRAFORM_DIR}") {
                    sh '''
                        terraform apply -auto-approve
                    '''
                }
            }
        }
    }

    post {
        always {
            cleanWs()
        }
        success {
            echo 'Pipeline completed successfully.'
        }
        failure {
            echo 'Pipeline failed. Check the logs.'
        }
    }
}
