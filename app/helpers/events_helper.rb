module EventsHelper
  def gravatar_for(event)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag(gravatar_url, alt: event.name, class: "gravatar")
  end
end
