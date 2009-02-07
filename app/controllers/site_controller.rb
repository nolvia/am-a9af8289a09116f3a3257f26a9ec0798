class SiteController < ApplicationController
  
  # Force reload if in development mode
  I18n.backend        = nil if Rails.env == 'development'
  I18n.default_locale = 'it-IT'
  
  before_filter :set_language
  caches_page :index, :about, :services, :portfolio, :contacts
  
  def expire_all
    [:index, :about, :services, :portfolio, :contacts].each do |action|
      expire_page "/index"
      expire_page "/it"
      expire_page "/en"
      expire_page "/it/#{action}"
      expire_page "/en/#{action}"
    end
    render :nothing => true
  end
  
  def services
    @services = [
      ['video_production', [:organization, :permissions, :recording]                      ],
      ['post_production',  [:editing, :copywriting, :dubbing, :music, :down_mix, :master] ],
      ['footages',         [:library, :research, :actual]                                 ],
      ['videoclip',        [:idea, :storyboard, :recording, :editing]                     ],
      ['finished_product', [:finished, :new]                                              ],
      ['events',           [:organization, :location, :slide, :set, :direction, :shoots]  ]
    ]
    # render
    # cache_page # nil, "/#{language.split('-').first}/#{action_name}.html"
  end
  
  def portfolio
    @works_per_client = eval(File.read(Rails.root / 'locales' / 'portfolio' / 'portfolio.structure.rb'))
  end
  
  private
    def set_language
      I18n.locale = language
    end
    
    def language; {'it' => 'it-IT', 'en' => 'en-US'}[ params[:language] || 'it' ] end
    hide_action :language
end
