# Re-open Layout class to convert our HAML Layout content.
# This solution risks Jekyll API updates, and potential
# interference from other included plugins.

module Jekyll
  class Layout
    def initialize(site, base, name)
      @site = site
      @base = base
      @name = name

      self.data = {}

      self.process(name)
      self.read_yaml(base, name)
      self.transform
    end
  end
end
