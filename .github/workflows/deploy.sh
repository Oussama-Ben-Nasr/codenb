#/bin/bash
source .github/workflows/utils.sh
source .github/workflows/parse_args.sh

extract_private_key
multiple_attempts
clean_up_secrets
