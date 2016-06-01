# Re-open Layout class to convert our HAML Layout content.
module Jekyll
  class Layout
    alias old_initialize initialize

    def initialize(*args)
      old_initialize(*args)
      self.content = self.transform
    end
  end
end
