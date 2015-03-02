Paperclip::Attachment.default_options[:path] = "/:class/:attachment/:id_partition/:style/:filename"
Paperclip::Attachment.default_options[:s3_host_name] = "s3-#{ENV['S3_REGION']}.amazonaws.com"
Paperclip::Attachment.default_options[:url] = ":s3_domain_url"
