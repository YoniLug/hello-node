#!groovy

def buildVersion = -1
def gitCommit = ''
def clLib = null
def npmMgr = null

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

    
    stages {

        stage("Install npm modules") {
            steps {
                script {
                    sh "npm install"
                }
            }
        }

        stage("Run npm build") {
            steps {
                script {
                    sh "npm run build"   
                }
            }
        }
        
        stage("Run npm test") {
            steps {
                script {
                    sh "npm run test-web-app"   
                }
            }
        }

        /*stage("Run npm Test") {
            steps {
                script {
                    npmMgr.npmTest()
                }
            }
        }*/

        
    }
}
