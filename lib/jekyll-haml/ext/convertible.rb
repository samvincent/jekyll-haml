# Re-open Layout class to convert our HAML Layout content.
# This solution risks Jekyll API updates, and potential
# interference from other included plugins.

module Jekyll
  class Layout
    def content
      if ext == '.haml' && @converted != true
        @content   = ::Haml::Engine.new(@content).render
        @converted = true
      else
        @content
      end
    end
  end
end
