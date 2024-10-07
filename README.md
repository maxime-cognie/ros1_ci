# ros1_cli

---

## Start Jenkins instance

First to install all the dependencies for this project launch this script : `course_install.sh`     
Then, to start Jenkins just run: `start_jenkins_ros1.sh`

And to access the Jenkins dashboard you can use those credentials:
- user: `test`      
- password: `test`  

Once connected to Jenkins send me the result of this command `echo "$(jenkins_address)github-webhook/"` like that I can update my github repo to inform your Jenkins server each time it receive an update.  
Finally, upate and push the git repository.