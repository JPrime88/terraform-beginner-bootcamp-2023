terraform {
  required_providers {
   terratowns = {
     source = "local.providers/local/terratowns"
     version = "1.0.0"
    }
  }
  cloud {
    organization = "JPrime88-Terraform"
    workspaces {
      name = "terra-house-1"
    }
  }

}

provider "terratowns" {
  endpoint = var.terratowns_endpoint
  user_uuid = var.teacherseat_user_uuid 
  token = var.terratowns_access_token
}

module "home_SOR4_hosting" {
  source = "./modules/terrahome_aws"
  user_uuid = var.teacherseat_user_uuid
  public_path = var.SOR4.public_path
  content_version = var.SOR4.content_version
}

resource "terratowns_home" "home" {
  name = "Streets of Rage 4!!!"
  description = <<DESCRIPTION
Streets of rage 4 is a game that came out in 2020!
It has led to the resurgance of the "beat-em-up games" genre.
This is my tribute to this game and reasons why you should play!
DESCRIPTION
  domain_name = module.home_SOR4_hosting.domain_name
  town = "gamers-grotto"
  content_version = var.SOR4.content_version
}

module "home_Smoothies_hosting" {
  source = "./modules/terrahome_aws"
  user_uuid = var.teacherseat_user_uuid
  public_path = var.Smoothies.public_path
  content_version = var.Smoothies.content_version
}

resource "terratowns_home" "home_Smoothies" {
  name = "The Healthiest Snack you need!!"
  description = <<DESCRIPTION
I just absolutely LOVE Smoothies!!!! Not only can you mix your favorite
fruits and veggies together, but you also get so many health benefits
from drinking them on a consistent basis. I mean...look at the pictures.
Doesn't look colorful, vibrant, and AMAZING!?!?!?
DESCRIPTION
  domain_name = module.home_Smoothies_hosting.domain_name
  town = "cooker-cove"
  content_version = var.Smoothies.content_version
}