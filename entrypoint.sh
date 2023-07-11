#!/bin/sh

set -e

# List of required variables
required_vars=("AWS_S3_BUCKET" "AWS_ACCESS_KEY_ID" "AWS_SECRET_ACCESS_KEY")

for var in "${required_vars[@]}"; do
  if [ -z "${!var}" ]; then
    echo "$var is not set. Quitting."
    exit 1
  fi
done

# Default to us-east-1 if AWS_REGION not set.
: ${AWS_REGION:="us-east-1"}

# Create a dedicated profile for this action to avoid conflicts
# with past/future actions.
# https://github.com/welingtonsampaio/action-awscli
aws configure --profile action-awscli <<-EOF > /dev/null 2>&1
${AWS_ACCESS_KEY_ID}
${AWS_SECRET_ACCESS_KEY}
${AWS_REGION}
text
EOF

# Sync using our dedicated profile and suppress verbose messages.
# All other flags are optional via the `args:` directive.
sh -c "aws --profile action-awscli $*"

# Clear out credentials after we're done.
# We need to re-run `aws configure` with bogus input instead of
# deleting ~/.aws in case there are other credentials living there.
# https://forums.aws.amazon.com/thread.jspa?threadID=148833
aws configure --profile action-awscli <<-EOF > /dev/null 2>&1
null
null
null
text
EOF