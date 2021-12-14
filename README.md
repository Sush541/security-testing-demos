# Security testing: Demos for Trivy, Syft and gitleaks

Demo for using a set of tools to increase security posture of an application.

- Security and configuration scanning with [Trivy](https://github.com/aquasecurity/trivy)
- SBOM (Software Bill of Materials) generation with [Syft](https://github.com/anchore/syft)
- Secret scanning: [gitleaks](https://github.com/zricethezav/gitleaks)

You can find a trivial containerized application in the `app` folder that can be tested with `trivy`.

## Prerequisites

All the below assume Mac or a system with [Homebrew](https://brew.sh) available:

- Install `trivy` with `brew install aquasecurity/trivy/trivy`.
- Install `syft` with `brew tap anchore/syft && brew install syft`.
- Install `gitleaks` with `brew install gitleaks`.

Docker or something else that can build from a `Dockerfile` must be available if you want to build and run the container.

## Instructions

Run the scan with `bash scan.sh` or `sh scan.sh`. These scans should pass. Reports will be generated into the `reports` folder.

Output should look similar to:

```
Running trivy...
Running syft...
 ✔ Loaded image
 ✔ Parsed image
 ✔ Cataloged packages      [238 packages]
 ✔ Loaded image
 ✔ Parsed image
 ✔ Cataloged packages      [238 packages]
 ✔ Indexed app/src
 ✔ Cataloged packages      [102 packages]
Running gitleaks (no-git mode)...

    ○
    │╲
    │ ○
    ○ ░
    ░    gitleaks

10:49AM INF no leaks found
10:49AM INF scan completed in 4.190319571s
```

### Make it break!

Go ahead and add secrets (like passwords, AWS keys etc) or install unsafe libraries like jQuery 1 and the scans should no longer pass.

### Optional container scan

You can optionally add the `trivy` container scan by uncommenting line 17 in `scan.sh`.

#### Build and run the container

Build the container, if needed, with `app/build.sh` and run it with `app/run.sh`.

## CI installation

### Trivy

See the [Supported OS page](https://aquasecurity.github.io/trivy/v0.21.2/vulnerability/detection/os/) to get an idea of which package managers can be used (as this depends on the CI machine's OS).

### Syft

As instructed on their GitHub page:

```
curl -sSfL https://raw.githubusercontent.com/anchore/syft/main/install.sh | sh -s -- -b /usr/local/bin
```

### gitleaks

As per [Computing for Geeks](https://computingforgeeks.com/gitleaks-audit-git-repos-for-secrets/):

```
curl -s https://api.github.com/repos/zricethezav/gitleaks/releases/latest |grep browser_download_url | cut -d '"' -f 4 | grep '\linux-amd64$'| wget -i -
```
