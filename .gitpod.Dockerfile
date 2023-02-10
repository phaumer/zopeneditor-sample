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
    zowe plugins install @ibm/rse-api-for-zowe-cli

RUN brew install ansible ansible-lint && \
    ansible-galaxy collection install ibm.ibm_zos_core
