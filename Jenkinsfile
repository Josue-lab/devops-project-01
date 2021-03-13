pipeline {
    agent any

    environment {
        imagename = "josue19/devops-certificate-practice-1"
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
        stage('Clean docker containers'){
            steps{
                script{
                
                    def doc_containers = sh(returnStdout: true, script: 'docker container ps -aq').replaceAll("\n", " ") 
                    if (doc_containers) {
                        sh "docker stop ${doc_containers}"
                        sh "docker rm ${doc_containers}"
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
