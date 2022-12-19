pipeline {
    agent any
    tools{
        maven 'M2_HOME'
    }
    /***environment {
    registry = '317396387403.dkr.ecr.us-east-1.amazonaws.com/jenkins-job'
    registryCredential = 'jenkins-ecr-user'
    dockerimage = ''
}**/
        
     environment {
        NEXUS_VERSION = "nexus3"
        NEXUS_PROTOCOL = "http"
        NEXUS_URL = "45.56.92.91:8081"
        NEXUS_REPOSITORY = "devop-CI-nexus"
        NEXUS_CREDENTIAL_ID = "nexus-user-credentials"
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
       
       stage("Publish to Nexus Repository Manager") {
            steps {
                echo 'Publish to Nexus Repository Manager...'
                    script {
                    pom = readMavenPom file: "pom.xml";
                    filesByGlob = findFiles(glob: "target/*.${pom.packaging}");
                    echo "${filesByGlob[0].name} ${filesByGlob[0].path} ${filesByGlob[0].directory} ${filesByGlob[0].length} ${filesByGlob[0].lastModified}"
                    artifactPath = filesByGlob[0].path;
                    artifactExists = fileExists artifactPath;
                    if(artifactExists) {
                        echo "*** File: ${artifactPath}, group: ${pom.groupId}, packaging: ${pom.packaging}, version ${pom.version}";
                        nexusArtifactUploader(
                            nexusVersion: NEXUS_VERSION,
                            protocol: NEXUS_PROTOCOL,
                            nexusUrl: NEXUS_URL,
                            groupId: pom.groupId,
                            version: pom.version,
                            repository: NEXUS_REPOSITORY,
                            credentialsId: NEXUS_CREDENTIAL_ID,
                            artifacts: [
                                [artifactId: pom.artifactId,
                                classifier: '',
                                file: artifactPath,
                                type: pom.packaging],
                                [artifactId: pom.artifactId,
                                classifier: '',
                                file: "pom.xml",
                                type: "pom"]
                            ]
                        );
                        } else {
                        error "*** File: ${artifactPath}, could not be found";
                        }
                    }
                }
            }
        
        
       
        
       /*** stage('Build Image') {
            steps {
                script{
                    dockerImage = docker.build registry + ":V"+ "$BUILD_NUMBER"
                } 
            }
        }***/
        
        /***stage('Deploy image') {
            steps{
                script{ 
                    docker.withRegistry('https://'+registry,'ecr:us-east-1:'+registryCredential) {
                        dockerImage.push()
                    }
                }
            }
        }***/
    }
}
