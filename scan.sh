#!/bin/bash

NAME="trivydemo"
REPORT_FOLDER="reports"

mkdir -p $REPORT_FOLDER

#########
# Trivy #
#########

echo "Running trivy..."

# Scan directory for misconfigurations
trivy config . > $REPORT_FOLDER/trivy_directory_config.txt
trivy fs . > $REPORT_FOLDER/trivy_directory_fs.txt

# Scan image for vulnerabilities
trivy image $NAME > $REPORT_FOLDER/trivy_container.txt

########
# Syft #
########

echo "Running syft..."

# Use syft to generates SBOM (software bill of materials) from container
syft $NAME > $REPORT_FOLDER/syft_sbom.txt #-o json > $REPORT_FOLDER/syft_sbom.json

# Use syft to generates SBOM (software bill of materials) from container, listing ONLY software visible to the container
syft packages $NAME > $REPORT_FOLDER/syft_sbom_packages.txt

# Use syft to scan source code directory
syft packages dir:app/src > $REPORT_FOLDER/syft_src_dir.txt

############
# gitleaks #
############

echo "Running gitleaks (no-git mode)..."

gitleaks detect --source . --no-git