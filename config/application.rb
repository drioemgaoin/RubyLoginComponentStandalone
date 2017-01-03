require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module RubyMvcBoilerplate
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}')]
    #config.i18n.default_locale = :fr

    # Do not swallow errors in after_commit/after_rollback callbacks.
    config.active_record.raise_in_transactional_callbacks = true

    config.action_view.field_error_proc = Proc.new { |html_tag, instance|
      unless html_tag =~ /^<label/
        %{
          <div class="has-error">
            #{html_tag}
            <span class="form-control-feedback"></span>
            <div class="help-block">#{instance.object.class.human_attribute_name(instance.send(:tag_id))} #{instance.error_message.first}</div>
          </div>
        }.html_safe
      else
        %{#{html_tag}}.html_safe
      end
    }
  end
end
