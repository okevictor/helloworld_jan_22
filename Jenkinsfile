pipeline {
    agent any
    tools{
        maven 'M2_HOME'
    }
    environment {
    registry = '317396387403.dkr.ecr.us-east-1.amazonaws.com/jenkins-job'
    registryCredential = 'jenkins-ecr-user'
    dockerimage = ''
  }
    /*stages {
        stage('Checkout'){
            steps{
                git branch: 'main', url: 'https://github.com/okevictor/helloworld_jan_22.git'
            }
        }*/
        
        stage('Code Build') {
            steps {
                sh 'mvn clean'
                sh 'mvn install'
                sh 'mvn package'
                
                //this is packing the artifacts
            }
        }
        stage('Test') {
            steps {
                sh 'mvn test'
            }
        }
        stage('Build Image') {
            steps {
                script{
                    dockerImage = docker.build registry + ":V"+ "$BUILD_NUMBER"
                    
                    /*This is pushing the image to my
                    ECR repository*/
                } 
            }
        }
        stage('Deploy image') {
            steps{
                script{ 
                    docker.withRegistry("https://"+registry,"ecr:us-east-1:"+registryCredential) {
                        dockerImage.push()
                    }
                }
            }
        }  
    }
}
