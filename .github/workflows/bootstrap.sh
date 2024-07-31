set -x
sudo ansible-playbook codenb/ansible-deployment/site.yaml > ansible-output.txt 2>&1
# get the ruby running pid
ruby_pid=$(pgrep ruby)

echo $ruby_pid
# if there is such one kill it
if [ -z "$ruby_pid" ]; then 
    echo "No ruby server detected"
else 
    echo "There is a ruby server, killing it first"
    kill $ruby_pid
fi
# start server with nohup
echo "Deploying one..."
nohup ./codenb/bin/rails s &
sleep 5 
echo "Done."
exit 0
