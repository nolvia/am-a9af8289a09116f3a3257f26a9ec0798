class Song
  
  def flat_name
    name.underscore.gsub(/\W+/,'_').gsub(/n[^_a-z\d\.]+/,"n").gsub(/è|é/i,'e').gsub(/ñ/i,'n')
  end
  
  def pdf
    extension = ".#{extension}" if extension.kind_of?(Symbol)
    album_path / 'pdf' / "#{position.to_s.rjust(2,'0')}_#{@name}.pdf"
  end
  
  def mp3
    album_path / 'mp3' / "#{position.to_s.rjust(2,'0')}_#{@name}.mp3"
  end
  
  def mp3_base
    album_path / 'mp3' / "#{position.to_s.rjust(2,'0')}_#{@name}.base.mp3"
  end
  
  
  
  
  # INITIALIZATION
  
  attr_reader :track_number, :name, :album_path, :album
  
  def initialize album, pdf
    pdf = pdf.to_path
    @album = album
    @album_path, @pdf_path = album.path, pdf
    # raise pdf.to_s
    @track_number = pdf.basename.to_s.scan(/^(\d+).*$/).flatten.first.to_i
    @name = pdf.basename.to_s.scan(/^\d+_(.*)\.pdf$/).flatten.first
    # raise self.inspect
  end
  
  alias position track_number
  
  def name
    album.song_names[@track_number - 1] || @name.humanize
  end
  
  
  class << self
    
    def all album
      Dir[album.path / 'pdf' / '*.pdf'].map do |pdf_path|
        Song.new( album, pdf_path )
      end.sort_by(&:track_number)
    end
  end
  
  
  # HELPERS
  
  PUBLIC = Rails.public_path.to_path
  
  def from_public path
    path.to_path.from(PUBLIC).absolute
  end
  
end