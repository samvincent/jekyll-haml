# Re-open Layout class to convert our HAML Layout content.
# This solution redeclares the Layout class in a way that 
# don't risks Jekyll API updates anymore.

module Jekyll
  class << Layout
    alias old_initialize initialize
    def initialize(*args)
      old_initialize(*args)
      self.content = self.transform
    end
  end
end
