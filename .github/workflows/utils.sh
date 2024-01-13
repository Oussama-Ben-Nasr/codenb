# default values
max_retries=3
initial_wait=1
retry_count=0
wait_time=$initial_wait
red='\033[0;31m'
green='\033[;32m'
grey='\033[;37m'
no_color='\033[0m'


## function to ssh into codenb_vm
function codenb_ssh() {
    ssh -tt "$username@$address" -i .codenbvm/key.pem -o StrictHostKeyChecking=no << EOT
    sudo ansible-playbook codenb/ansible-deployment/site.yaml
    chmod +x codenb/.github/workflows/bootstrap.sh
    ./codenb/.github/workflows/bootstrap.sh&
    exit 0
EOT
}


## exponential backoff with retries
function multiple_attempts() {
    while true; do
        codenb_ssh
        exit_code=$?
        if [ $exit_code -eq 0 ]; then
            echo -e "${green}Job succeeded :) ${no_color}"
            break
        fi
        if [ $retry_count -ge $max_retries ]; then
            echo -e "${red}Command failed after $max_retries attempts. Exiting with exit code $exit_code.${no_color}"
            exit $exit_code
        fi
        echo -e "${grey}Command failed with exit code $exit_code. Retrying in $wait_time seconds...${no_color}"
        sleep $wait_time
        retry_count=$((retry_count+1))
        wait_time=$((wait_time*2))
    done
}


## clean up secret file
function clean_up_secrets() {
    rm -rf .codenbvm/
}


## extract private key from secret env
function extract_private_key() {
    mkdir -p .codenbvm
    touch .codenbvm/key.pem
    chmod 777 .codenbvm/key.pem
    echo $privatekey | sed -z 's/\\n/\n/g' | base64 --decode | sed -z 's/\\n/\n/g' > .codenbvm/key.pem
    chmod 400 .codenbvm/key.pem
}

## How to pass a file as an env variable
## file -> env: export variable=$(cat file_to_encode | sed -z 's/\n/\\n/g' | base64 | sed -z 's/\n/\\n/g')
## env -> file: echo $variable | sed -z 's/\\n/\n/g' | base64 --decode | sed -z 's/\\n/\n/g' > decoded_file
