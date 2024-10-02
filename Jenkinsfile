pipeline {
    agent any

    environment {
        GITHUB_REPO = 'https://github.com/andervafla/java_deploy/archive/refs/heads/pipeline.zip' // URL для ZIP
        TERRAFORM_DIR = 'TerraformAWS'
        SSH_CREDENTIALS_ID = 'my-ssh-key'
    }

    stages {
        stage('Download ZIP') {
            steps {
                // Завантажити ZIP-архів з репозиторію
                sh "curl -L -o java_deploy.zip ${GITHUB_REPO}"
            }
        }

        stage('Unzip') {
            steps {
                // Розархівувати ZIP-архів
                sh 'unzip java_deploy.zip'
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
                withCredentials([string(credentialsId: SSH_CREDENTIALS_ID, variable: 'my-ssh-key')]) {
                    dir("${TERRAFORM_DIR}") {
                        sh 'echo "$my-ssh-key" > /tmp/my_public_key.pub'
                        
                        sh '''
                            terraform apply -var="key_path=/tmp/my_public_key" -auto-approve
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
