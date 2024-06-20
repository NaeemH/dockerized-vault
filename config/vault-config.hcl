# Full configuration options can be found at https://www.vaultproject.io/docs/configuration

listener "tcp" {
  address = "0.0.0.0:8200"
  tls_disable = 1
}

storage "file" {
  path = "/vault/data"
}

ui = true