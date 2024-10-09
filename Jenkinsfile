pipeline {
    agent { label 'jenks-node' }

    environment {
        GITHUB_REPO = 'https://github.com/andervafla/java_deploy.git' 
        TERRAFORM_DIR = 'TerraformAWS'
    }

    stages {
        stage('show files') {
            steps {
                sh 'ls'
            }
        }

        stage('List Files in Root Directory') {
            steps {
                sh 'terraform -version'
            }
        }

        stage('Check Terraform Files') {
            steps {
                dir("${TERRAFORM_DIR}") {
                    sh 'ls -la'
                }
            }
        }   

         stage('List Files in Terraform Directory') {
            steps {
                dir("${TERRAFORM_DIR}") {
                    sh 'terraform init' 
                }
            }
        }

        stage('List Files in Terraform Directory') {
            steps {
                dir("${TERRAFORM_DIR}") {
                    sh 'terraform destroy -auto-approve' 
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
