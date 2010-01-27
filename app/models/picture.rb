class Picture
  include PictureTranslations
  
  attr_reader :id, :path
  attr_accessor :locale
  
  def self.all
    Dir[Rails.public_path / 'images' / 'pictures' / '*'].map do |path|
      new(path)
    end.sort_by(&:position)
  end
  
  def initialize path
    @path = path.to_path
  end
  
  def data
    @data ||= DATA[locale || :it][path.basename(".*").to_s.to_sym] || {}
  end
  
  def title;        data[:title      ] end
  def date;         data[:date       ] end
  def place;        data[:place      ] end
  
  def position;     data[:position   ] || 1000            end
  def description;  data[:description].try :gsub,/\s+/," " end
  
end
