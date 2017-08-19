require 'haml'
require 'pp'

module Jekyll

  class HamlPartialTag < Liquid::Tag
    def initialize(tag_name, file, tokens)
      super
      @file = file.strip
    end

    def render(context)
      includes_dirs = context.registers[:site].includes_load_paths.map{ |f| File.join(f) }

      if @file !~ /^[a-zA-Z0-9_\/\.-]+$/ || @file =~ /\.\// || @file =~ /\/\./
        return "Include file '#{@file}' contains invalid characters or sequences"
      end

      return "File must have \".haml\" extension" if @file !~ /\.haml$/

      haml_file = nil
      includes_dirs.each do |dir|

        if File.symlink?(dir)
          return "Includes directory '#{dir}' cannot be a symlink"
        end

        if Dir.exists?(dir)
          Dir.chdir(dir) do
            choices = Dir['**/*'].reject { |x| File.symlink?(x) }
            if choices.include?(@file)
              # Set haml_file to first match,
              # includes_load_paths returns project's _includes first, then gem's _includes,
              # so user can override the gem's file.
              haml_file = File.read(@file)
            end
          end
        end

        break if haml_file

      end

      if haml_file
        conversion = ::Haml::Engine.new(haml_file).render
        partial    = Liquid::Template.parse(conversion)

        begin
          return partial.render!(context)
        rescue => e
          puts "Liquid Exception: #{e.message} in #{self.data["layout"]}"
          e.backtrace.each do |backtrace|
            puts backtrace
          end
          abort("Build Failed")
        end

        context.stack do
          return partial.render(context)
        end
      else
        "Included file '#{@file}' not found in _includes directories"
      end
    end
  end

end

Liquid::Template.register_tag('haml', Jekyll::HamlPartialTag)
