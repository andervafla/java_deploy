pipeline {
    agent any

    environment {
        GITHUB_REPO = 'https://github.com/andervafla/java_deploy.git'
        TERRAFORM_DIR = 'TerraformAWS'
        SSH_CREDENTIALS_ID = 'my-ssh-key'
    }

    stages {
        stage('Checkout') {
            steps {
                // Клонування репозиторію з вказаної гілки
                git branch: 'main', url: "${GITHUB_REPO}"
            }
        }
    
        stage('List Files in Root Directory') {
            steps {
                // Виведення списку файлів у кореневій директорії після клонування
                sh 'ls -la'
            }
        }

        stage('List Files in Terraform Directory') {
            steps {
                // Виведення списку файлів у папці TerraformAWS
                dir("${TERRAFORM_DIR}") {
                    sh 'ls -la' 
                }
            }
        }

        stage('Initialize Terraform') {
            steps {
                dir("${TERRAFORM_DIR}") {
                    script {
                        // Ініціалізація Terraform
                        sh 'terraform init'
                    }
                }
            }
        }

        stage('Apply Terraform') {
            steps {
                withCredentials([string(credentialsId: PUBLIC_KEY_CREDENTIALS_ID, variable: 'my-ssh-key')]) {
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
            // Очищення робочого простору
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
