module Raws
  class List
    def start(override_tags = nil, override_attributes = nil)
      ec2 = AWS::EC2.new
      ec2list = ec2.instances

      attributes = ["id", "instance_type", "launch_time"]
      attributes = override_attributes.split(',') if override_attributes

      tags = ["Owner"]
      tags = override_tags.split(',') if override_tags

      Logger.info("#{attributes.join(',').upcase},#{tags.join(',').upcase}")

      ec2list.each do |instance|
        instance_tags = []
        instance_attributes = []

        attributes.each do |attribute|
          instance_attributes << instance.send(attribute.to_sym)
        end

        tags.each do |tag|
          instance_tags << instance.tags.send(tag.to_sym) if instance.tags.send(tag.to_sym)
          instance_tags << "Unknown" unless instance.tags.send(tag.to_sym)
        end

        Logger.info("#{instance_attributes.join(',')},#{instance_tags.join(',')}")
      end
    end
  end
end
