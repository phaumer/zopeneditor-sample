###############################################################################
# Licensed Materials - Property of IBM
# (c) Copyright IBM Corporation 2023. All Rights Reserved.
#
# Note to U.S. Government Users Restricted Rights:
# Use, duplication or disclosure restricted by GSA ADP Schedule
# Contract with IBM Corp.
###############################################################################

FROM gitpod/workspace-full:latest

RUN npm install -g @zowe/cli@latest --ignore-scripts && \
    npm install -g @ibm/zapp-core && \
    npm install -g @ibm/rse-api-for-zowe-cli --ignore-scripts
