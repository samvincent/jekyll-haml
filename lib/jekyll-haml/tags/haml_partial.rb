require 'haml'

module Jekyll

  class HamlPartialTag < Liquid::Tag
    def initialize(tag_name, user_string, tokens)
      super
      @user_string = user_string
    end

    def render(context)
      @user_string = Liquid::Template.parse(@user_string)
                                     .render(context)
                                     .gsub(%r{\"|\'},'')
                                     .strip

      file, arg = @user_string.split(' ')
      relative  = arg.nil? ? false : !!(arg =~ /true/)

      includes_dir = File.join(context.registers[:site].source, '_includes')

      if File.symlink?(includes_dir)
        return "Includes directory '#{includes_dir}' cannot be a symlink"
      end

      if file !~ /^[a-zA-Z0-9_\/\.-]+$/ || file =~ /\.\// || file =~ /\/\./
        return "Include file '#{file}' contains invalid characters or sequences"
      end

      return "File must have \".haml\" extension" if file !~ /\.haml$/

      if relative
        include_file(file, context)
      else
        Dir.chdir(includes_dir) do
          choices = Dir['**/*'].reject { |x| File.symlink?(x) }
          if choices.include?(file)
            include_file(file, context)
          else
            "Included file '#{file}' not found in _includes directory"
          end
        end
      end
    end

    private

    def include_file(file, context)
      source     = File.read(file)
      conversion = ::Haml::Engine.new(source).render.delete("\n")
      partial    = Liquid::Template.parse(conversion)
      begin
        return partial.render!(context)
      rescue => e
        print "Liquid Exception: #{e.message}"
        print "in #{self.data["layout"]}"
        e.backtrace.each do |backtrace|
          puts backtrace
        end
        abort("Build Failed")
      end

      context.stack do
        return partial.render(context)
      end
    end
  end
end

Liquid::Template.register_tag('haml', Jekyll::HamlPartialTag)
