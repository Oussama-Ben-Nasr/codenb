## parse user args
#function parse_args() {
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
#}
