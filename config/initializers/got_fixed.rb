config = {}
begin
  config = YAML.load(ERB.new(File.read(Rails.root.join('config', 'got_fixed.yml'))).result)
rescue Errno::ENOENT
  # Could not find the config/got_fixed.yml file
end

# https://gist.github.com/ssaunier/3866812
def symbolize(object)
  if object.kind_of? Hash
    object.keys.each do |k|
      object[k.to_sym] = symbolize(object.delete k)
    end
    object
  elsif object.kind_of? Array
    object.map { |e| symbolize e }
  else
    object
  end
end

GotFixed.config = symbolize(config)
GotFixed.config[:github] ||= []
GotFixed.config[:resque] ||= {}
