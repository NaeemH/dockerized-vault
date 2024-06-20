# Use the official Vault image from HashiCorp
FROM vault:latest

Dockerfile# Expose the Vault HTTP port
EXPOSE 8200

# Define environment variables
ENV VAULT_ADDR=http://0.0.0.0:8200
ENV VAULT_API_ADDR=http://127.0.0.1:8200

# Start Vault server
ENTRYPOINT ["vault", "server", "-config=/vault/config/vault-config.hcl"]