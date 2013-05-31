module StyleGuide
  class Config
    APPLICATION_CSS = 'application'
    DEFAULT_CSS_PATHS = [APPLICATION_CSS]

    attr_reader :paths
    attr_accessor :css_urls

    def self.bootstrap_glob
      StyleGuide::Engine.root.join("app", "views", "bootstrap", "*")
    end

    def initialize(options = {})
      @paths = options[:paths] || [self.class.bootstrap_glob]
      @css_urls = options.fetch(:css_urls, DEFAULT_CSS_PATHS)
    end

    def paths=(paths)
      if paths.is_a?(Array)
        @paths = paths
      else
        @paths = [paths]
      end
    end

    def sections
      StyleGuide::Section.from_paths(expanded_paths)
    end

    private

    def expanded_paths
      globbed_paths.flatten.uniq.select(&:directory?)
    end

    def globbed_paths
      paths.map { |path| Pathname.glob(path) }
    end
  end
end
