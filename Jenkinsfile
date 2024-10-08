pipeline {
    agent any

    environment {
        GITHUB_REPO = 'https://github.com/andervafla/java_deploy.git' 
        TERRAFORM_DIR = 'terraformAWS'
        PATH = "/usr/bin/terraform"

    }

    stages {
        stage('Print Hello World') {
            steps {
                echo 'Hello, World!'
            }
        }


        stage('List Files in Root Directory') {
            steps {
                sh 'terraform -version'
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
