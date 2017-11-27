require 'chef/knife'
require 'json'
# other require attributes, as needed

module KnifeAtomic
  class EnvironmentShowAtomic < Chef::Knife
    deps do
      require 'chef/api_client'
      require 'chef/search/query'
    end

    banner "knife environment show atomic ENVIRONMENT"

    option :attribute,
      :short => "-F FORMAT",
      :long => "--format FORMAT",
      :description => "Which format to use for output",
      :default => "pp"

    def run
      # Ruby code goes here
      if @name_args.empty?
        puts "Invalid environment name"
      else
        puts full_conf(@name_args.first)
      end
    end

    def full_conf(envname)
      env_url = Chef::Environment.list[envname]
      env_data = rest.get_rest(env_url)
      all_cookbooks = cookbooks(env_url, env_data["cookbook_versions"])
      env_data["cookbook_versions"] = all_cookbooks
      ui.output(env_data)
    end

    def cookbooks(env_url, versions)
      nodes = rest.get_rest("#{env_url}/nodes")
      env_cookbooks = versions
      unless nodes.nil?
        nodes.each do |node_name, node_url|
          node_data = rest.get_rest("#{node_url}")
          if node_data["automatic"].has_key?("cookbooks")
            node_cookbooks = node_data["automatic"]["cookbooks"]
            unless node_cookbooks.nil?
              node_cookbooks.each do |cookbook_name, cookbook_data|
                cookbook_version = cookbook_data['version']
                if env_cookbooks.has_key?(cookbook_name)
                  version = env_cookbooks[cookbook_name].split(' ').last
                  if version > cookbook_version
                    env_cookbooks[cookbook_name] = "<= #{version}"
                  elsif cookbook_version > version
                    env_cookbooks[cookbook_name] = "<= #{cookbook_version}"
                  end
                else
                  env_cookbooks[cookbook_name] = "= #{cookbook_version}"
                end
              end
            end
          end
        end
      end
      env_cookbooks
    end
  end
end
