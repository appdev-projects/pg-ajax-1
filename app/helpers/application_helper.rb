module ApplicationHelper
  def only_host_and_path(input_url)
    if input_url.present?
      url = URI(input_url)

      link_to url.host + url.path, input_url
    else
      nil
    end
  end
end
