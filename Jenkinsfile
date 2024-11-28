pipeline {
    agent { label 'first_agent' }  // Set the default agent for the entire pipeline
    environment {
    imagename = "rputhenp/hello_app"
    registryCredential = "dockercred"
    dockerImage = ''
    }
    stages {
        stage('Clone repository') {
            steps {
                // Checkout the source code from the SCM (Source Control Management) repository.
                checkout scm
            }
        }
        
        stage('Build docker image') {
            steps {
                script {
                    //building the docker image with build number as tag
                    dockerImage = docker.build("$imagename:$BUILD_NUMBER")
                }
            }
        }
        
        stage('Push to Docker Hub') {
            steps {
                script {
                    //Pushing the image to dockerhub
                    docker.withRegistry('', registryCredential) {
                        dockerImage.push()
                        dockerImage.push('latest')
                    }
                }
            }
        }

        stage('Start Container') {
            steps {
                script {
                    //running the container using the image
                def containername = "hello_app_container"
                sh "docker stop $containername || true"
                sh "docker rm $containername || true"
                sh "docker run --name $containername $imagename:$BUILD_NUMBER"
                }
            }
        }
   
        stage('Run test script on the app') {
            steps {
                script {
                    // Run tests inside the Docker container.
                    inside {
                        sh 'python hello.py'
                    }
                }
            }
        }

        stage('Remove Unused docker image') {
            steps{
                //removing unused images
                sh "docker rmi $imagename:$BUILD_NUMBER || true"
                sh "docker rmi $imagename:latest || true"
            }
        } 
    }
}