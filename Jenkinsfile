pipeline {
    agent any

    environment {
        GITHUB_REPO = 'https://github.com/andervafla/java_deploy.git' 
        TERRAFORM_DIR = 'terraformAWS'
        SSH_CREDENTIALS_ID = 'my-ssh-key'
    }

    stages {
        stage('Print Hello World') {
            steps {
                echo 'Hello, World!'
            }
        }

        stage('Checkout from Git') {
            steps {
                git branch: 'main', url: "${GITHUB_REPO}"
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
                    sh 'ls -la' 
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
                // Отримання SSH ключа
                withCredentials([sshUserPrivateKey(credentialsId: SSH_CREDENTIALS_ID, keyVariable: 'my_ssh_key', usernameVariable: 'SSH_USER')]) {
                    dir("${TERRAFORM_DIR}") {
                        // Запис публічного ключа у файл
                        sh 'echo "$my_ssh_key" > /tmp/my_public_key.pub'
                        
                        // Виконання команди Terraform
                        sh '''
                            terraform apply -var="key_path=/tmp/my_public_key.pub" -auto-approve
                        '''
                    }
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
