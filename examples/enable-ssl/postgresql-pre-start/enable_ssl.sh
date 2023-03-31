#!/bin/bash

# Postgresql server will reject key files with liberal permissions
# This might fail in OpenShift when not using a user with a SCC anyuid
# chmod og-rwx server.key
