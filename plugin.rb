# name: plugin-thumb-override
# about:  Override thumbnail generation of Discourse
# version: 0.0.1
# authors: Terrapop

enabled_site_setting :plugin_thumb_override_enabled

after_initialize do
    require_dependency 'cooked_post_processor'
    CookedPostProcessor.class_eval do

      def extract_images_for_post
        # all images with a src attribute
        @doc.css("img[src]") -
        # minus emojis
        @doc.css("img.emoji") -
        # minus images inside quotes
        @doc.css(".quote img") -
        # minus onebox site icons
        @doc.css("img.site-icon") -
        # minus onebox avatars
        @doc.css("img.onebox-avatar") #Broader criteria than Discourse Core
      end

    end
end