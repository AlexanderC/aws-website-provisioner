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

## Usage

Run the following commands in terminal:

1. Initialize terraform: `terraform init terraform/`
2. Load environment variables: `set -o allexport; source .env; set +o allexport`
3. Provision infrastructure: `terraform apply terraform/`

At the end of `terraform apply`'s output you'll see something like:

```
Apply complete! Resources: 4 added, 0 changed, 0 destroyed.

Outputs:

cname = dw12eyh8cr9l6.cloudfront.net
www_cname = d1edkxy4vi8byf.cloudfront.net
```

To complete setup, take the values of `cname` and `www_cname` and add these as DNS entries (e.g. for `vaxseen.co` website):

```
vaxseen.co CNAME ${cname} / cache=3600
www.vaxseen.co CNAME ${www_cname} / cache=3600
```

> You might want to [save your `terraform.tfstate`](https://www.terraform.io/docs/state/purpose.html) file somewhere safe.
