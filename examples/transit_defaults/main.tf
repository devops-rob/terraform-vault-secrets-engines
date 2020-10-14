provider "vault" {
  address = "http://localhost:8200"
  token   = "root"
}

module "transit_defaults" {
  source          = "../../"
  secrets_engines = ["transit"]

  transit_keys = [
    {
      name                   = "test-key-1"
      allow_plaintext_backup = false
      convergent_encryption  = false
      exportable             = false
      deletion_allowed       = true
      derived                = false
      type                   = "rsa-2048"
      min_decryption_version = 1
      min_encryption_version = 1
    },
    {
      name                   = "test-key-22"
      allow_plaintext_backup = false
      convergent_encryption  = false
      exportable             = false
      deletion_allowed       = true
      derived                = false
      type                   = "rsa-2048"
      min_decryption_version = 1
      min_encryption_version = 1
    }

  ]
}