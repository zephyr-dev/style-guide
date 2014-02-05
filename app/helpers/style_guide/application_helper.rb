module StyleGuide
  module ApplicationHelper
    include FontAwesome::Rails::IconHelper

    def escape_for_display(content)
      content.gsub(/\</, "&lt;").gsub(/\>/, "&gt;").html_safe
    end

    def protect_against_forgery?
      false
    end

  end
end
