require 'path_operator'

class Album
  
  TANGO_ARGENTINO = [
    "Preludio Romantico", 
    "Nostalgia De Paris", 
    "Olè Compañeros", 
    "Carillon Tango", 
    "Sol Otoñal", 
    "Romance", 
    "Sinceridad", 
    "Passion", 
    "Tangolandia", 
    "No Puedo Olvidar", 
    "Ciao Buenos Aires", 
    "Sentimental Tango", 
    "Tangomania", 
    "Amor De Gringo", 
    "Melodico Tango", 
    "Granero", 
    "Estrellas De Agua", 
    "Adios Amigos", 
    "Tiempos Pasados", 
    "Milonguero", 
    "Alma Porteña", 
    "Viento Peruano", 
    "Fischia Il Gaucho", 
    "Suspiros Al Viento", 
    "Inferno E Paradiso", 
    "Juramentos De Mujer", 
    "El Gringo", 
    "Corazon Desierto"]
  APPUNTAMENTO_CON_IL_TANGO = [
     "Revival Tango",
     "Toreador",
     "Dolor",
     "Si Tal Vez",
     "Parana",
     "Domingo Porteño",
     "Impressioni Argentine",
     "Stella Del Sud",
     "Dulce Plegaria",
     "Amico Tango",
     "Tristeza En La Pampa",
     "Canaria",
     "El Tornado",
     "Una Flor",
     "Passione Argentina",
     "Dulce Mate",
     "Sublime Tango",
     "Capriccio",
     "Classico Tango",
     "Tango Story"]
  INVITO_AL_BALLO =   [
     "Il Folletto",
     "Volteggiando",
     "Campi Elisi",
     "Dita Veloci",
     "Pensieri Del Crepuscolo",
     "Modello Parigino",
     "Trionfo",
     "Storielle Parigine",
     "Eco Di Valzer",
     "Valzer Campagnolo",
     "Sprazzi Di Sole",
     "Furore",
     "La Gazzella",
     "La Bisbetica",
     "Mazurka Gaia",
     "Come La Doccia",
     "Dolcezza",
     "Tanghissimo",
     "Tango Della Fisarmonica",
     "Tango Dello Spaccone",
     "Organ Tango",
     "Rudero Tango",
     "Notturno Tango",
     "Strip Tango",
     "Un Po' Di Brio",
     "La Fenice",
     "Allegria",
     "Polka Capricciosa",
     "in Funivia",
     "a Gonfie Vele",
     "Quattro Salti",
     "Manuel",
     "Don Diego El Toreador",
     "Gli Spagnoli",
     "Adios España",
     "Arenales De Rio",
     "Rio Bianco"]
  
    
  def song_names
    case name
    when /tango argentino/i
      TANGO_ARGENTINO
    when /appuntamento/i
      APPUNTAMENTO_CON_IL_TANGO
    when /invito/i
      INVITO_AL_BALLO
    end
  end
  
  # INITIALIZATION
  
  def initialize path
    @path = Pathname.new(path)
  end
  
  def self.all
    albums = Dir[ Rails.public_path/'albums/*' ].map do |path|
      new( path.to_path )
    end.sort_by(&:position)
  end
  
  def position
    case name
    when /tango argentino/i
      1
    when /appuntamento/i
      2
    when /invito/i
      3
    end
  end
  
  # ASSOCIATIONS
  
  def songs
    @songs ||= Song.all(self)
  end
  
  
  # ATTRIBUTES
  
  attr_reader :path
  
  def id
    path.basename.underscore
  end
  
  def name
    path.basename.to_s.humanize
  end
  
  def art
    from_public(path / 'album.jpg')
  end
  
  def midi_bundle_path
    path / 'midi.zip'
  end
  
  def midi_bundle
    midi_bundle_path.exist? ? from_public( midi_bundle_path ).to_s : nil
  end
  
  
  # HELPERS
  
  PUBLIC = Rails.public_path.to_path
  
  def from_public path
    path.to_path.from(PUBLIC).absolute
  end
  
end