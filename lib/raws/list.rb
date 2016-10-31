module Raws
  class List
    def start(override_tags = nil, override_attributes = nil)
      # Initialize AWS EC2 module and get all ec2 instances
      ec2 = AWS::EC2.new
      ec2list = ec2.instances

      # Set default attributes/tags to list from the ec2 instances and use to filter
      # Set override if set via CLI option attributes/tags
      attributes = ["id", "instance_type", "launch_time"]
      attributes = override_attributes.split(',') if override_attributes

      tags = ["Owner"]
      tags = override_tags.split(',') if override_tags

      # Print header
      Logger.info("#{attributes.join(',').upcase},#{tags.join(',').upcase}")

      # Iterate through servers list and collect attributes/tags for each
      # If a tag is not found, set to "Unknown"
      ec2list.each do |instance|
        instance_tags = []
        instance_attributes = []

        attributes.each do |attribute|
          # Call AWS SDK with a variable function name using the send method and symbol casting
          instance_attributes << instance.send(attribute.to_sym)
        end

        tags.each do |tag|
          # Call AWS SDK with a variable function name using the send method and symbol casting
          instance_tags << instance.tags.send(tag.to_sym) if instance.tags.send(tag.to_sym)
          instance_tags << "Unknown" unless instance.tags.send(tag.to_sym)
        end

        # Print each instance with its respective attributes and tags
        Logger.info("#{instance_attributes.join(',')},#{instance_tags.join(',')}")
      end
    end
  end
end
