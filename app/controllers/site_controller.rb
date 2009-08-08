class SiteController < ApplicationController
  
  PAGES = %w[index about services portfolio contacts]
  LOCALES = %w[it en es de fr]
  caches_page *PAGES unless Rails.env == 'production'
  
  
  # Force reload if in development mode
  I18n.backend        = nil if Rails.env == 'development'
  I18n.default_locale = 'it'
  
  before_filter :set_locale
  
  
  # def index
  #   require 'path'
  # end
  
  def clean
    expired_pages = []
    PAGES.each do |action|
      LOCALES.each do |page_locale|
        paths_for_action(action, page_locale).each do |path|
          path = '/'+path
          self.class.expire_page path
          expired_pages << self.class.send( :page_cache_path, path) #path
        end
      end
    end
    expired_pages += expire_static_assets!
    
    render :text => "ok, expired pages:<br/>#{expired_pages.join('<br/>')}"
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
  end
  
  def products
    @products = YAML.load_file(Rails.root / 'lib' / "products.#{locale}.yml")
  end
  
  def portfolio
    @works_per_client = eval(File.read(Rails.root / 'locales' / 'portfolio' / 'portfolio.structure.rb'))
  end
  
  private
    def set_locale
      I18n.locale = params[:locale].try(:to_sym) || :it
    end
    
    def locale
      I18n.locale
    end
    
    helper_method :locale
    
    
    
    def paths_for_action action, page_locale
      [ [page_locale, action+'.html'].join('/'),
        [page_locale, action, 'index.html' ].join('/'),
        action+'.html',
        action+'/index.html' ]
    end

    def expire_static_assets!
      expired_pages = []
      %w[/javascripts/all.js /stylesheets/all.css].each do |path|
        self.class.expire_page path
        expired_pages << self.class.send( :page_cache_path, path) #path
      end
      expired_pages
    end
end
