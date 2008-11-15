class SiteController < ApplicationController
  
  # Force reload if in development mode
  I18n.backend        = nil if Rails.env == 'development'
  I18n.default_locale = 'it-IT'
  
  before_filter do |controller|
    I18n.locale = controller.language
  end
  
  def language; {'it' => 'it-IT', 'en' => 'en-US'}[ params[:language] || 'it' ] end
  hide_action :language
  
  
  def services
     @services = [
      ['video_production', [:organization, :permissions, :recording]                      ],
      ['post_production',  [:editing, :copywriting, :dubbing, :music, :down_mix, :master] ],
      ['footages',         [:library, :research, :actual]                                 ],
      ['videoclip',        [:idea, :storyboard, :recording, :editing]                     ],
      ['finished_product', [:finished, :new]                                              ],
      ['events',           [:organization, :location, :slide, :set, :direction, :shoots]  ]
    ]
  end
  
  def portfolio
    # @works = 
  end
  
end
