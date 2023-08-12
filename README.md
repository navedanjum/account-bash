# Accounts & Aion Instance Setup

This project sets up accounts and Aion instances for testing purposes.
Steps are taken from the wiki

##  Overview

The bash scripts are developed from the curl command to create account, create aion instance and perform data clean-up

## Prerequisites

Before you can use this script to set up Aion instances, make sure that:

- You are part of an organization with RBAC access enabled.
- Your engineering manager has the correct permissions in Monkey to enable the RBAC Pilot flag for your organization.
- You have created an organization in the Stage Console.
- You have requested RBAC access by posting on #help-identity with the organization SID.
- All accounts are created under this organization.


## Usage
- Make sure, owl and owl tubes are updated to latest version
- Execute the scripts from local machine
- clone the repository
- Make sure that scripts are executable, use chmod + x

## Execution
- Creates data and aion instance on stage environment
- setup scripts
- prepare scripts
- tear_down or cleanup scripts
- Execute in the below order in case do not execute in order make sure to `start owl tubes render   system --stage-us1`
1. setup/create_account.sh
2. setup/skip_phone_verify.sh
3. prepare/update_flags.sh
4. prepare/create_aion_instance.sh
5. prepare/list_instances_status.sh
6. tear_down/instance_account_cleanup.sh
7. tear_down/transfer_delete_account_cleanup.sh
