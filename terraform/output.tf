output "cname" {
  value = "${ var.www_default ? module.site-redirect.website_cdn_hostname : module.site-main.website_cdn_hostname }"
}

output "www_cname" {
  value = "${ var.www_default ? module.site-main.website_cdn_hostname : module.site-redirect.website_cdn_hostname }"
}
