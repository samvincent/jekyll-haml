require "jekyll-haml/version"
require "haml"

require "jekyll-haml/tags/haml_partial"
require "jekyll-haml/ext/convertible"

module Jekyll
  class HamlConverter < Converter
    safe true
    priority :low

    def matches(ext)
      ext =~ /haml/i
    end

    def output_ext(ext)
      ".html"
    end

    def convert(content)
      ::Haml::Engine.new(content).render
    end
  end
end
