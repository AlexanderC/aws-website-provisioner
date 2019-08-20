module "site-main" {
   source = "github.com/AlexanderC/terraform-website-s3-cloudfront-route53//site-main"

   region = "${ var.region }"
   domain = "${ var.domain }"
   bucket_name = "${ var.bucket }"
   duplicate-content-penalty-secret = "${ var.dcps }"
   deployer = "${ var.deployer }"
   acm-certificate-arn = "${ var.acm }"
   not-found-response-path = "/${ var.not_found_page }"
   project = "${ var.project }"
   environment = "${ var.environment }"
}

module "site-redirect" {
   source = "github.com/AlexanderC/terraform-website-s3-cloudfront-route53//site-redirect"

   region = "${ var.region }"
   domain = "www.${ var.domain }"
   target = "${ var.domain }"
   duplicate-content-penalty-secret = "${ var.dcps }"
   deployer = "${ var.deployer }"
   acm-certificate-arn = "${ var.acm }"
}
