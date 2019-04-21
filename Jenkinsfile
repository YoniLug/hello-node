#!groovy

def buildVersion = -1
def gitCommit = ''
def lib = null
def npmMgr = null
def imageName = null

pipeline {
    /*
    *Set the slave to be the docker image that build in node step . 
    */
    agent {
        dockerfile { 
            filename "Dockerfile.build"
            args "-v /var/run/docker.sock:/var/run/docker.sock"
            label "master"
        }
    }
    
    options { 
        buildDiscarder(logRotator(numToKeepStr: '30'))
        timestamps() 
    }

    environment {
        MajorMinorVersion = "1.0"
        REPO_NAME = "hello-node"
        SERVICE_NAME = "hello-node" 
    }
    
    parameters {
        string(name: 'BRANCH_NAME', defaultValue: '', description: '')
        string(name: 'LIB_BRANCH_NAME',defaultValue: '', description: '')
    }
    
    stages {
        stage("Set Build Version ") {
            steps {
                script {
                    lib = library("jenkins.pipeline@${params.LIB_BRANCH_NAME}").com.yona.pipeline
                    env.BUILD_VERSION = "${env.MajorMinorVersion}.${env.BUILD_NUMBER}"
                    npmMgr = lib.NpmMgr.new(this, this.steps,env.BUILD_VERSION)
                    npmMgr.setBuildVersion()
                }
            }
        }
        stage("Install npm modules") {
            steps { 
                script {
                    npmMgr.npmInstall()
                }
            }
        }

        stage("Run npm build") {
            steps {
                script {
                    npmMgr.npmBuild()   
                }
            }
        }
        
        stage("Run npm test") {
            steps {
                script {
                    npmMgr.npmTest()  
                }
            }
        }

        stage("build docker image") {
            steps {
                script {
                    imageName = "${env.SERVICE_NAME}:${env.BUILD_VERSION}"
                    def customImage = docker.build("my-image:${env.BUILD_VERSION}")
                    //customImage.push()
                }
            }
        }
        
        stage("Run Docker image") {
            steps {
                script {
                    docker.image(imageName).withRun('-d -p 8090:8080')
                    //customImage.push()
                }
            }
        }
    }
}
