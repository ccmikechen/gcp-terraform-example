# GCP Terraform Example

## Initial settings

```shell
export GOOGLE_CREDENTIALS=crendential.json
terraform init
```

## Need to do manually

### Create service account

* Cloud SQL Admin
* Compute Admin
* Service Account User
* Cloud Memorystore Redis Admin
* Viewer

**Create JSON key and save it as ./credential.json**

### Enable APIs

* Compute Engine API
* Cloud SQL Admin API

## Google beta services (not yet supported by version 1.9 of Terraform's google provider)

### Cloud NAT

### Google Managed SSL

#### Create SSL Certificates

```shell
$ gcloud beta compute ssl-certificates create myapp --domains myapp.example
$ gcloud beta compute ssl-certificates create myapp-app --domains myapp-app.example
```

#### Check SSL Certificates

```shell
$ gcloud beta compute ssl-certificates describe myapp
$ gcloud beta compute ssl-certificates describe myapp-app
```

## Connect to production server via bastion server from local

1. Add bastion to `~/.ssh/config`

```
Host myapp-bastion
  HostName 35.243.108.135
  Port 22
  IdentitiesOnly yes
  User admin
```

2. Add production server to `~/.ssh/config`

```
Host myapp-prd-1
  HostName myapp-prd-1
  User admin
  IdentitiesOnly yes
  ProxyCommand ssh -W %h:%p myapp-bastion
```

3. Connect to production server through ssh

```shell
ssh myapp-prd-1
```
