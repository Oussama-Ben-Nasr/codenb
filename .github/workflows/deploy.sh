#!/bin/bash

## ssh into the target vm.
while getopts u:p:a:k: flag
do
    case "${flag}" in
        u) username=${OPTARG};;
        p) password=${OPTARG};;
        a) address=${OPTARG};;
        k) privatekey=${OPTARG};;
    esac
done
echo "Username: $username";
echo "Password: $password";
echo "Address: $address";
echo "Private key: $privatekey";

#  ssh linux1@148.100.78.101 -i .vm/codenb.pem
mkdir .tmpvm
echo $privatekey | base64 --decode > .tmpvm/key.pem
ssh "$username@$address" -i .tmpvm/key.pem

# test coonectivity
mkdir itworked
touch itworked/1.txt
