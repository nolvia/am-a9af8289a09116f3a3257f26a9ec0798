class Picture
  attr_reader :id, :path
  
  DATA = {
      :orchestra_polydor_parigi => {
        :description => 
          "Negli studi di registrazione della Polydor di Parigi Aldo Maietti
          dirige la sua orchestra di 18 elementi avvalendosi 
          di valenti musicisti di diverse nazionalità con il celebre 
          cantante argentino Ernesto Rondò.",
        :place => "Studi Polydor, Parigi",
        :date => "1959",
        :position => 9
      },
      :maietti_dirige => {
        :description => 
          "Presso il Teatro Astral di Buenos Aires, gremito di pubblico, 
          al 25˚ anniversario della scomparsa del più celebre cantante 
          argentino di Tanghi: Carlos Gardel; il maestro Francisco Canaro, 
          notissimo compositore di tanghi e direttore d'orchestra, cede la 
          direzione della sua orchestra al maestro Maietti in segno di stima,
          ammirazione ed ospitalità.
          Il Maestro Maietti accompagna il cantante argentino Ernesto Rondò 
          nel tango «Mano a Mano» dello stesso Gardel, sotto scroscianti 
          applausi.", 
        :place => "Teatro Astral, Buenos Aires",
        :date => "24 Giugno 1961",
        :position => 10
      },
      
      :canaro_invita_maietti => {
        # :description => 
        #   "",
        :date => "24 Giugno 1961",
        :place => "Buenos Aires",
        :position => 13
      },
      
      :rondo_maietti_canaro => {
        :description => 
          "Nella foto: Ernesto Rondò (cantante argentino), Aldo Maietti e 
          Francisco Canaro che è stato il più noto compositore di tanghi e 
          direttore d'orchestra",
        :date => "24 Giugno 1961",
        :place => "Buenos Aires",
        :position => 13
      },
      
      :radio_elmundo => {
        :description => 
          "A radio «El Mundo», da sinistra: Aldo Maietti, Edmundo Rivero 
          (il più celebre dei cantanti di tanghi argentini degli anni '60),
          Govi (violinista e direttore d'orchestra), lo speaker ed il 
          segretario della radio.",
        :date => "1964",
        :place => "Buenos Aires",
        :position => 15
        
      } 
    
  }
  
  def self.all
    Dir[Rails.public_path / 'images' / 'pictures' / '*'].map do |path|
      new(path)
    end.sort_by(&:position)
  end
  
  def initialize path
    @path = path.to_path
  end
  
  def data
    DATA[path.basename(".*").to_s.to_sym] || {}
  end
  
  def title;        data[:title      ] end
  def date;         data[:date       ] end
  def place;        data[:place      ] end
  
  def position;     data[:position   ] || 1000            end
  def description;  data[:description].try :gsub,/\s+/," " end
  
  
  
end

