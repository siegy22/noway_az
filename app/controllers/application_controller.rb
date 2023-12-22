class ApplicationController < ActionController::Base
  def default_meta_tags
    {
      title: 'Das große A-Z Projekt',
      reverse: true,
      separator: '|',
      keywords: 'noway, noway4u, noway4u_sir, lol, league of legends, challenge',
      canonical: request.original_url,
      noindex: !Rails.env.production?,
      og: {
        title: 'Das große A-Z Projekt',
        type: 'website',
        url: request.original_url,
      }
    }
  end
  helper_method :default_meta_tags
end
