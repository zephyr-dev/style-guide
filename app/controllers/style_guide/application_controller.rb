module StyleGuide
  class ApplicationController < ActionController::Base
    def load_sections
      @sections = StyleGuide::Engine.config.style_guide.sections
    end

    def load_config
      @config = Rails.application.config.style_guide
    end
  end
end
