module UsersHelper

  # Return the Gravatar (http://gravatar.com) for a given user
  # gli ID dei Gravatar sono basati sulla codifica hash MD5 dell’indirizzo mail dell’utente

  def gravatar_for(user,options = { size: 50 })
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    size = options[:size]
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag(gravatar_url, alt: user.name, class: "gravatar")
  end
end
