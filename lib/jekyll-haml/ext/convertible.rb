# Re-open Layout class to convert our HAML Layout content.
# This solution don't risks Jekyll API updates anymore.

module Jekyll
  class << Layout # Redeclare a copy of the Layout class
    alias old_initialize initialize
    def initialize(*args)
      old_initialize(*args)
      self.content = self.transform
    end
  end
end
