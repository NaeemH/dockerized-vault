# Setting up Vault with Docker Compose

## Build and start the Vault container using the provided Docker Compose file (You may see a warning regarding the version being obsolete, which can be ignored.)
```bash
$ docker compose -f docker-compose.dev.yml up -d --build
WARN[0000] /Users/nemo/vault/docker-compose.dev.yml: `version` is obsolete
[+] Running 2/2
 ✔ Network vault_default  Created                                                                                               0.1s
 ✔ Container vault-dev    Started
```
## Check docker status
```bash
$ docker ps -a
CONTAINER ID   IMAGE                    COMMAND                  CREATED             STATUS             PORTS                              NAMES
6fcbbdb57873   hashicorp/vault:latest   "docker-entrypoint.s…"   About an hour ago   Up About an hour   8200/tcp, 0.0.0.0:8201->8201/tcp   vault-dev
```

## Exec into docker container
```bash
$ docker exec -it vault-dev sh
/ #
```

## Run vault server from docker container
```bash
$ vault server -dev
...
2024-07-15T17:11:39.035Z [INFO]  proxy environment: http_proxy="" https_proxy="" no_proxy=""
2024-07-15T17:11:39.038Z [INFO]  incrementing seal generation: generation=1
2024-07-15T17:11:39.038Z [WARN]  no `api_addr` value specified in config or in VAULT_API_ADDR; falling back to detection if possible, but this value should be manually set
2024-07-15T17:11:39.040Z [INFO]  core: Initializing version history cache for core
2024-07-15T17:11:39.041Z [INFO]  events: Starting event system
```

## Check logs to grab the root token (if you've forgotten it before)
```bash
$ docker logs vault-dev
...
You may need to set the following environment variables:

    $ export VAULT_ADDR='http://0.0.0.0:8200'

The unseal key and root token are displayed below in case you want to
seal/unseal the Vault or re-authenticate.

Unseal Key: <REDACTED>
Root Token: <REDACTED>
```

## Login to vault on container
```bash
$ VAULT_ADDR='http://127.0.0.1:8201'
$ vault login
Token (will be hidden):
Success! You are now authenticated. The token information displayed below
is already stored in the token helper. You do NOT need to run "vault login"
again. Future Vault requests will automatically use this token.

Key                  Value
---                  -----
token                <REDACTED>
token_accessor       <REDACTED>
token_duration       ∞
token_renewable      false
token_policies       ["root"]
identity_policies    []
policies             ["root"]
```

## Test placing vault secrets
```bash
$ vault kv put secret/test-secret username=test
===== Secret Path =====
secret/data/test-secret

======= Metadata =======
Key                Value
---                -----
created_time       <REDACTED>
custom_metadata    <nil>
deletion_time      n/a
destroyed          false
version            1
```

## Test getting vault secrets
```bash
$ vault kv get -field=username secret/test-secret
test
```

## Teardown the vault container
```bash
$ docker compose  -f docker-compose.dev.yml down
WARN[0000] /Users/nemo/vault/docker-compose.dev.yml: `version` is obsolete
[+] Running 2/2
 ✔ Container vault-dev    Removed                                                                                               0.1s
 ✔ Network vault_default  Removed
```