module LocalsHelper

  def gravatar_for(local)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag(gravatar_url, alt: local.name, class: "gravatar")
  end
end
