pipeline {
   agent {
      label 'Slave'
    }

   tools {
      // Install the Maven version configured as "M3" and add it to the path.
      maven "M3"
   }

   stages {
      stage('Get Code') {
         steps {
            // Get some code from a GitHub repository
            checkout scm
         }
      }

      stage('Build and Junit') {
         steps {
            // Run Maven on a Unix agent.
            sh "mvn clean install"

         }
      }

      stage('Build Docker image'){
         steps {
            sh "mvn package -Pdocker"
         }
      }

      stage('Run Docker app') {
          steps {
              sh "docker run -d -p 0.0.0.0:8080:8080 --name app${BUILD_NUMBER} -t panda-application:1.0.2-SNAPSHOT"
          }
      }

      stage('Test Selenium') {
          steps {
              sh "mvn test -Pselenium"
          }
      }

      stage('Deploy jar to artifactory') {
          steps {
              configFileProvider([configFile(fileId: '9d1ed313-ea70-4fa9-9934-7108c53eca75', variable: 'MAVEN_GLOBAL_SETTINGS')]) {
              sh "mvn -gs $MAVEN_GLOBAL_SETTINGS deploy -Dmaven.test.skip=true -e"
                }
      } 
         post {
            always { 
               sh 'docker stop app${BUILD_NUMBER}'
               deleteDir()
                    }
         }
      }
    }
}

