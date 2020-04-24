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

      stage("Build docker and Run App") {
          steps {
              sh '''cp target/panda*.jar dockerfiles/pandaapp
              cd dockerfiles/pandaapp
              docker build -t pandaapp_${BUILD_NUMBER} .
              docker run -d -p 0.0.0.0:8080:8080 --name app${BUILD_NUMBER} -t pandaapp_${BUILD_NUMBER}'''
          }
      }

      stage("Test Selenium") {
          steps {
              sh "mvn test -Pselenium"
          }
      }

      stage("Deploy to artifactory") {
          steps {
              configFileProvider([configFile(fileId: '9d1ed313-ea70-4fa9-9934-7108c53eca75', variable: 'MAVEN_GLOBAL_SETTINGS')]) {
              sh 'mvn -gs $MAVEN_GLOBAL_SETTINGS deploy -Dmaven.test.skip=true -e'
                }
      } 
         post {
            // If Maven was able to run the tests, even if some of the test
            // failed, record the test results and archive the jar file.
            always { 
               sh 'docker stop app${BUILD_NUMBER}'
               deleteDir()
                    }
         }
      }
    }
}

