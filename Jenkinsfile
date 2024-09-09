pipeline {
    agent any

    environment {
        FRONTEND_IMAGE = "andervafla/frontend-image"
        BACKEND_IMAGE = "andervafla/backend-image"
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

        stage('Push to DockerHub') {
            steps {
                script {
                    // Push images to DockerHub using default Docker credentials
                    dockerImageBackend.push("${env.BUILD_NUMBER}")
                    dockerImageBackend.push("latest")

                    dockerImageFrontend.push("${env.BUILD_NUMBER}")
                    dockerImageFrontend.push("latest")
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
