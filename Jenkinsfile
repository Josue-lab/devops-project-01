pipeline {
    agent any

    environment {
        imagename = "josue19/devops-certificate"
        registryCredential = 'docker_hub'
        dockerImage = ''
     }
     
    stages {
        stage('Checking Repository') {
            steps {
                git branch:'main', credentialsId:'github-token', url:'https://github.com/Josue-lab/devops-project-01.git'
            }
        }
        stage('Docker Version'){
            steps{
                sh 'docker --version'
            }    
        }
        stage('Building image') {
            steps{
                script {
                    dockerImage = docker.build imagename
                }
            }
        }
        stage('Push Image') {
            steps{
                script {
                    docker.withRegistry( '', registryCredential ) {
                    dockerImage.push("$BUILD_NUMBER")
                    dockerImage.push('latest')
                }
                }
            }
        }
        stage('Deploy image and Remove Unused  image') {
            steps{
                sh "docker run -d -p 80:80 --name devops $imagename:$BUILD_NUMBER"
            }
        }
    }
}
