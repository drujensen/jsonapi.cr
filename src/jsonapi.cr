require "json"
require "./jsonapi/*"

module JSONAPI
  macro jsonapi_mapping(properties)
    {% for key, value in properties %}
      {% properties[key] = {type: value} unless value.is_a?(HashLiteral) %}
    {% end %}
    

    def to_jsonapi
      String.build do |io|
        to_jsonapi io
      end
    end

    def to_jsonapi(io)
      { "data": [{ 
              "type": "{{ @type.name.downcase.id }}", 
              "id": @{{"id".id}},
              "attributes": {
              {% for key, value in properties %}
                "{{key.id}}": @{{key.id}} as {{value[:type]}},
              {% end %}
              }
        }]
      }.to_json(io)
    end
  end
end
