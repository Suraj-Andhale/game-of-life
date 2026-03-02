pipeline {
    agent any

    environment {
        DOCKER_USER = "your-dockerhub"
        IMAGE_NAME  = "game-of-life"
        IMAGE_TAG   = "${BUILD_NUMBER}"
    }

    tools {
        maven 'Maven3'
    }

    stages {

        stage('Checkout') {
            steps {
                git 'https://github.com/Suraj-Andhale/game-of-life.git'
            }
        }

        stage('Build & Unit Test') {
            steps {
                sh 'mvn clean verify'
            }
        }

        stage('SAST - SonarQube') {
            steps {
                withSonarQubeEnv('sonar') {
                    sh 'mvn sonar:sonar'
                }
            }
        }

        stage('Package WAR') {
            steps {
                sh 'mvn package -DskipTests'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh """
                docker build -t $DOCKER_USER/$IMAGE_NAME:$IMAGE_TAG .
                """
            }
        }

        stage('Push Image') {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: 'dockerhub-creds',
                    usernameVariable: 'USER',
                    passwordVariable: 'PASS'
                )]) {
                    sh """
                    echo $PASS | docker login -u $USER --password-stdin
                    docker push $DOCKER_USER/$IMAGE_NAME:$IMAGE_TAG
                    """
                }
            }
        }

        stage('Helm Deploy') {
            steps {
                sh """
                helm upgrade --install game-release helm/game-chart \
                  --set image.repository=$DOCKER_USER/$IMAGE_NAME \
                  --set image.tag=$IMAGE_TAG
                """
            }
        }

        stage('Verify Rollout') {
            steps {
                sh 'kubectl rollout status deployment/game-of-life'
            }
        }
    }

    post {
        success {
            echo "🎮 Game Live on Kubernetes!"
        }
        failure {
            echo "❌ Pipeline Failed"
        }
    }
}
