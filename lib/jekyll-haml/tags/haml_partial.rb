require 'haml'

module Jekyll
  module Tags
    class HamlIncludeTag < IncludeTag
      def initialize(tag_name, file, tokens)
        super
        @file = file.strip
      end
      
      def load_cached_partial(path, context)
        context.registers[:cached_partials] ||= {}
        cached_partial = context.registers[:cached_partials]

        if cached_partial.key?(path)
          cached_partial[path]
        else
          html = ::Haml::Engine.new(File.read(path)).render.delete("\n")          
          unparsed_file = context.registers[:site]
            .liquid_renderer
            .file(path)
          begin
            cached_partial[path] = unparsed_file.parse(html)
          rescue => e
            e.template_name = path
            e.markup_context = "haml " if e.markup_context.nil?
            raise e
          end
        end
      end

      def render(context)
        if @file !~ /^[a-zA-Z0-9_\/\.-]+$/ || @file =~ /\.\// || @file =~ /\/\./
          return "Include file '#{@file}' contains invalid characters or sequences"
        end
        return "File must have \".haml\" extension" if @file !~ /\.haml$/
        
        site = context.registers[:site]
        path = locate_include_file(context, @file, site.safe)
        return unless path
        add_include_to_dependency(site, path, context)
        
        partial = load_cached_partial(path, context)

        context.stack do
          begin
            partial.render!(context)
          rescue Liquid::Error => e
            e.template_name = path
            e.markup_context = "included " if e.markup_context.nil?
            raise e
          end
        end
      end

    end # HamlIncludeTag
  end # Tags
end # Jekyll
Liquid::Template.register_tag('haml', Jekyll::Tags::HamlIncludeTag)
