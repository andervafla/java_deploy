pipeline {
    agent any

    environment {
        DOCKERHUB_CREDENTIALS = credentials('dockerhubid')
        FRONTEND_IMAGE = "andervafla/frontend-image"
        BACKEND_IMAGE = "andervafla/backend-image"
    }

    triggers {
        pollSCM('H/10 * * * *') 
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/andervafla/java_deploy.git'
            }
        }

        stage('Print Directory Contents') {
    steps {
        script {
            sh 'ls -la'
            sh 'ls -la frontend'
        }
    }
}    

        stage('Build Backend Image') {
            steps {
                script {
                    dockerImageBackend = docker.build("${BACKEND_IMAGE}:${env.BUILD_NUMBER}", ".")
                }
            }
        }

        stage('Build Frontend Image') {
            steps {
                script {
                    dockerImageFrontend = docker.build("${FRONTEND_IMAGE}:${env.BUILD_NUMBER}", "./frontend")
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
