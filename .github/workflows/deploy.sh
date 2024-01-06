#!/bin/bash
# Default values
max_retries=3
initial_wait=1


## parse user args
while getopts u:a:k:w:r: flag
do
    case "${flag}" in
        u) username=${OPTARG};;
        a) address=${OPTARG};;
        k) privatekey=${OPTARG};;
        w) initial_wait=${OPTARG};;
        r) max_retries=${OPTARG};;
    esac
done


## extract private key from secret env
mkdir -p .codenbvm
touch .codenbvm/key.pem
chmod 777 .codenbvm/key.pem
echo $privatekey | sed 's/\\n/\n/g' | base64 --decode | sed 's/\\n/\n/g' > .codenbvm/key.pem
cat .codenbvm/key.pem
chmod 400 .codenbvm/key.pem


## function to ssh into codenb_vm
function codenb_ssh() {
    ssh -tt "$username@$address" -i .codenbvm/key.pem -o StrictHostKeyChecking=no<<EOT
    # test coonectivity
    mkdir -p itworked
    touch itworked/1.txt
    exit 0
EOT
}


## exponential backoff with retries
retry_count=0
wait_time=$initial_wait

while true; do
    codenb_ssh
    exit_code=$?
    if [ $exit_code -eq 0 ]; then
        exit $exit_code
    fi
    if [ $retry_count -ge $max_retries ]; then
        echo "Command failed after $max_retries attempts. Exiting with exit code $exit_code."
        exit $exit_code
    fi
    echo "Command failed with exit code $exit_code. Retrying in $wait_time seconds..."
    sleep $wait_time
    retry_count=$((retry_count+1))
    wait_time=$((wait_time*2))
done


## clean up secret file
rm -rf .codenbvm
