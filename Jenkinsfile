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
    stages {
        
        //Checkout scm was used since I setup GitHub Webhook for this job
        
        /***stage('git repository'){
            steps{
                script{
                    checkout scm 
                    //git branch: 'main', url: 'https://github.com/okevictor/helloworld_jan_22.git'
                }
            }
        }***/
        
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
                } 
            }
        }
        
        stage('Deploy image') {
            steps{
                script{ 
                    docker.withRegistry("https://"+registry,"ecr:us-east-1:jenkins-ecr-user") {
                        dockerImage.push()
                    }
                }
            }
        }
    }
}
