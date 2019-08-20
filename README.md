# Static Website Provisioning Automation

Deploy a static website on AWS using Terraform. This tool is using [AlexanderC/terraform-website-s3-cloudfront-route53](https://github.com/AlexanderC/terraform-website-s3-cloudfront-route53#inputs).

## Prerequisites

- [ ] [Terraform](https://www.terraform.io) `>=v12.x.x`
- [ ] Generated and validated [AWS ACM certificate in `us-east-1` region](https://console.aws.amazon.com/acm/home?region=us-east-1) **// this region is mandatory!**
- [ ] Created [AWS IAM user](https://console.aws.amazon.com/iam/home) (e.g. `website_deployer`)

## Configuration

1. Copy `.env.sample`: `cp .env.sample .env`
2. Edit `.env` to contain production values

> @ref https://github.com/AlexanderC/terraform-website-s3-cloudfront-route53#inputs

### Variables reference:

```bash
AWS_SECRET_ACCESS_KEY=k2hug3riu42h4giu21gi4uy1h2 # AWS Secret Access Key
AWS_ACCESS_KEY_ID=kHJGUYTFGKIUUYKG # AWS Access Key ID
AWS_DEFAULT_REGION=eu-central-1 # AWS default region
# Terraform variables
TF_VAR_region=eu-central-1 # AWS region to deploy website to
TF_VAR_domain=vaxseen.co # Domain name to be used for website
TF_VAR_www_default=true # If true- it will make www.yourwebsite.com primarily used and yourwebsite.com redirected to www.yourwebsite.com
TF_VAR_bucket=vaxseen-website # Bucket created to store website files
TF_VAR_dcps=pVgdM9SKdgMBXzPrnsx3nDsFTkHzqKUX # Generate a random string and insert it here
TF_VAR_deployer=website_deployer # Pre-generated AWS IAM user name
TF_VAR_acm=arn:aws:acm:us-east-1:459097916068:certificate/88b2aa09-e8f9-47d1-9f40-aaef2595f493 # Pre-generated AWS ACM certificate ARN
TF_VAR_not_found_page=index.html # 404 error page. Always use index.html to make SPAs working properly
TF_VAR_project=vaxseen # Project name
TF_VAR_environment=production # Project environment
```

## Usage

Run the following commands in terminal:

1. Initialize terraform: `terraform init terraform/`
2. Load environment variables: `set -o allexport; source .env; set +o allexport`
3. Provision infrastructure: `terraform apply terraform/`

> You might want to [save your `terraform.tfstate`](https://www.terraform.io/docs/state/purpose.html) file somewhere safe.

At the end of `terraform apply`'s output you'll see something like:

```
Apply complete! Resources: 4 added, 0 changed, 0 destroyed.

Outputs:

cname = d1edkxy4vi8byf.cloudfront.net
www_cname = dw12eyh8cr9l6.cloudfront.net
```

To complete setup, take the values of `cname` and `www_cname` and add these as DNS entries (e.g. for `vaxseen.co` website):

```
vaxseen.co CNAME ${cname} / cache=3600
www.vaxseen.co CNAME ${www_cname} / cache=3600
```

To deploy your website use `website_deployer` IAM user and CLI tools provided by AWS, or simply do it through AWS Console.
