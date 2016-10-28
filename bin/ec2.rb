module Raws
  class Ec2 < Thor
    desc 'list', 'List Ec2 instances with optional filtering on Ec2 Tags. 
                  Default is tags: Owner, Attributes: id, instance_type, launch_time'

    method_option( :tags, 
                   :type => :string,
                   :required => false, 
                   :aliases => '-t', 
                   :desc => 'Override default tags with a comma delimited string (i.e. -t Owner,Name,etc )')

    method_option( :attributes, 
                   :type => :string,
                   :required => false, 
                   :aliases => '-a', 
                   :desc => 'Override default attributes with a comma delimited string (i.e. -a id,instance_type,etc )')

    method_option( :region, 
                   :type => :string,
                   :required => false, 
                   :aliases => '-r', 
                   :desc => 'Override default region in credentials config.')

    def list
      configuration = "#{ROOT}/.raws/credentials.json"

      if File.exists?(configuration)
        file = File.new(configuration, 'r')
      else
        abort(Logger.error("Could not find AWS configuration file at #{configuration}"))
      end

      begin
        json_data = JSON.parse(file.read())
      rescue JSON::ParserError
        abort(Logger.error("#{file} isn't valid json."))
      end
      file.close()

      amazon = {
          :access_key_id => nil,
          :secret_access_key => nil,
          :region => nil,
      }

      amazon[:secret_access_key] = json_data['demo']['aws_secret_access_key']
      amazon[:access_key_id] = json_data['demo']['aws_access_key']
      amazon[:region] = json_data['demo']['region']

      amazon[:region] = options[:region] if options[:region]

      AWS.config(amazon)

      Raws::List.new.start(options[:tags], options[:attributes])
    end
  end
end
