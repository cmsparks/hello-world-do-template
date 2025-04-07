# Fetch the workers.dev subdomain from Cloudflare API
response=$(curl -s "https://api.cloudflare.com/client/v4/accounts/805b839e5ee74f0dbb336d59fcef3f8b/workers/subdomain" \
  -H "Authorization: Bearer $CLOUDFLARE_API_TOKEN")

# Extract the subdomain from the JSON response
subdomain=$(echo $response | grep -o '"subdomain":"[^"]*"' | cut -d'"' -f4)

# Check if subdomain was successfully extracted
if [ -z "$subdomain" ]; then
  echo "Error: Failed to extract subdomain from API response"
  echo "API Response: $response"
  exit 1
fi

# Construct the full URL
workers_url="https://$WRANGLER_CI_OVERRIDE_NAME.$subdomain.workers.dev"

# Output the result
echo "Workers URL: $workers_url"

# Export as an environment variable
export WORKERS_URL="$workers_url"

# Display confirmation
echo "Environment variable WORKERS_URL has been set"
