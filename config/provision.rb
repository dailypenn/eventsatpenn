# This will only work when run on a GCP Compute Engine instance

require 'net/http'
require 'json'

#### COMBAK

# ignored_fields = ['ssh-keys']
# uri = URI.parse('http://metadata.google.internal/computeMetadata/v1/instance/attributes/?recursive=true')
#
# req = Net::HTTP::Get.new(uri.to_s)
# req.add_field('Metadata-Flavor', 'Google')
#
# res = Net::HTTP.new(uri.host, uri.port).start do |http|
#   http.request(req)
# end
#
# vars = JSON.parse(res.body)
# ignored_fields.each {|k| vars.delete(k) }
#
# vars.each { |k, v| ENV[k] = v }
#
