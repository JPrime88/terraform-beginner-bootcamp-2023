terraform {
  required_providers {
   terratowns = {
     source = "local.providers/local/terratowns"
     version = "1.0.0"
    }
  }
  
}

provider "terratowns" {
  endpoint = var.terratowns_endpoint
  user_uuid = var.teacherseat_user_uuid 
  token = var.terratowns_access_token
}

module "terrahouse_aws" {
  source = "./modules/terrahouse_aws"
  user_uuid = var.teacherseat_user_uuid
  index_html_filepath = var.index_html_filepath
  error_html_filepath = var.error_html_filepath
  content_version = var.content_version
  assets_path = var.assets_path
}

resource "terratowns_home" "home" {
  name = "Streets of Rage 4!!!"
  description = <<DESCRIPTION
Streets of rage 4 is a game that came out in 2020!
It has led to the resurgance of the "beat-em-up games" genre.
This is my guide that will show you how to play Streets of Rage 4 and 
how to be a better player.
DESCRIPTION
  domain_name = module.terrahouse_aws.cloudfront_url
  town = "missingo"
  content_version = 1
}