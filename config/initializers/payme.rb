require 'payme'

class Payme::Config
  def self.default
    {
      :library => 'wordline',
      :bin_path => 'bin/atos',
      :pathfile => 'config/atos/pathfile'
    }
  end
end

class Payme::Response
  # Fix Payme response parsing, should ignore first "field"
  def parse_result(result)
    parsed = Hash.new
    result.shift # here we get rid of it
    fields.each_with_index do |field, i|
      parsed[field.to_sym] = result[i]
    end
    parsed
  end
end
