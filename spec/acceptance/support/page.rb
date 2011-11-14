module CivicCommonsDriver
  module Pages
    module Page
      include Capybara::DSL
      def self.included(base)
        base.extend(Page)
        CivicCommonsDriver.available_pages[base::SHORT_NAME] = base
      end

      def goto
        visit self.class::LOCATION 
      end

      def add_wysiwyg_editor_field(field, locator)
        define_method "fill_in_#{field}_with" do | value |
          begin
            page.execute_script("tinyMCE.get('#{locator}').setContent('#{value}')")
          rescue Capybara::NotSupportedByDriverError
            fill_in locator, :with=>value
          end
        end
      end

      def add_field(field, locator)
        define_method "fill_in_#{field}_with" do | value |
          fill_in locator, :with=> value
        end
      end

      def add_link_for(name, locator, resulting_page)
        define_method "follow_#{name}_link_for" do | item |
          within item.container do
            click_link locator
          end
          set_current_page_to resulting_page
        end
      end

      def add_link(name, locator, resulting_page)
        define_method "follow_#{name}_link" do
          click_link locator
          set_current_page_to resulting_page
        end
      end

      def add_button(name, locator, resulting_page=:current)
        define_method "click_#{name}_button" do
          click_button "#{locator}"
          set_current_page_to resulting_page
        end
      end

      def accept_alert
        page.driver.browser.switch_to.alert.accept
      end

      def set_current_page_to page
        CivicCommonsDriver.set_current_page_to page
      end

      def attachments_path
        File.expand_path(File.dirname(__FILE__) + '/attachments')
      end
    end
  end
end