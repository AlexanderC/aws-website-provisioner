output "cname" {
  value = "${ module.site-main.website_cdn_hostname }"
}

output "www_cname" {
  value = "${ module.site-redirect.website_cdn_hostname }"
}
