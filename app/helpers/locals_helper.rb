module LocalsHelper

  def gravatar_for(local,options = { size: 50 })
    size = options[:size]
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag(gravatar_url, alt: local.name, class: "gravatar")
  end
end
