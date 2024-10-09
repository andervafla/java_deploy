pipeline {
    agent { label 'jenks-node' }

    environment {
        GITHUB_REPO = 'https://github.com/andervafla/java_deploy.git' 
        FRONTEND_DIR = 'frontend'
        GRADLE_VERSION = '7.2'  // Вказати версію Gradle
        GRADLE_HOME = "${env.WORKSPACE}/gradle"  // Директорія для Gradle
        GRADLE_BIN = "${GRADLE_HOME}/gradle-${GRADLE_VERSION}/bin" // Директорія з бінарними файлами Gradle
    }

    stages {
        stage('Show files') {
            steps {
                sh 'ls'
            }
        }

        stage('List Files in Root Directory') {
            steps {
                sh 'ls -la'
            }
        }

        stage('Download Gradle') {
            steps {
                script {
                    // Перевірка, чи Gradle вже завантажений
                    if (!fileExists("${GRADLE_BIN}/gradle")) {
                        echo "Downloading Gradle ${GRADLE_VERSION}..."
                        sh """
                        mkdir -p ${GRADLE_HOME}
                        wget https://services.gradle.org/distributions/gradle-${GRADLE_VERSION}-bin.zip -P ${GRADLE_HOME}
                        unzip ${GRADLE_HOME}/gradle-${GRADLE_VERSION}-bin.zip -d ${GRADLE_HOME}
                        rm ${GRADLE_HOME}/gradle-${GRADLE_VERSION}-bin.zip
                        """
                    } else {
                        echo "Gradle ${GRADLE_VERSION} is already downloaded."
                    }
                }
            }
        }

        stage('Navigate to Frontend Directory') {
            steps {
                dir("${FRONTEND_DIR}") {
                    sh 'ls -la'  // Переглянути файли у папці frontend
                }
            }
        }   

        stage('Build Frontend') {
            steps {
                dir("${FRONTEND_DIR}") {
                    sh 'npm install'  // Встановлення залежностей
                    sh 'npm run build' // Команда для білду
                }
            }
        }

        stage('Build Backend') {
            steps {
                script {
                    // Додавання Gradle до PATH
                    env.PATH = "${GRADLE_BIN}:${env.PATH}"
                    
                    sh 'gradle build -x test --no-daemon' // Команда для білду бекенду
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
