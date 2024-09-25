require "jekyll-haml/version"
require "haml"

require "jekyll-haml/tags/haml_partial"
require "jekyll-haml/ext/convertible"

module Jekyll
  module Converters
    class Haml < Converter
      safe true
      priority :low

      def matches(_ext)
        _ext =~ /haml/i
      end

      def output_ext(ext)
        ".html"
      end

      def convert(content)
        ::Haml::Engine.new(content).render
      end
    end
  end
end