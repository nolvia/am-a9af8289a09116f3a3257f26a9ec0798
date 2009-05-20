T = {
  :'it' => {
    :cinevideoservices => 'Cinevideoservizi', 
    
    :slogan     => 'in un certo senso la tv &egrave; il nostro sesto senso', 
    :production => 'produzione',
    :tax_code   => 'Partita&nbsp;Iva:&nbsp;{{tax_code}}',
    
    :sections => {
      :about      => "Chi siamo", 
      :services   => 'Servizi', 
      :portfolio  => 'Portfolio', 
      :contacts   => 'Contatti',
    }.stringify_keys!,
    
    :locale => {
      :name => 'ITALIANO',
      :short => 'it',
      :version => 'Vai all versione in {{link}}'
    }.stringify_keys!,
    
    :index => {
      :what       => 'MACOK è una casa di {{production}}.',
        :production => 'produzione video',
      :many       => 'Ci occupiamo anche di numerosi {{services}}',
        :services   => 'altri servizi',
      :where      => 'Siamo a Carugate, {{distance}}.', 
        :distance   => 'a pochi kilometri da Milano'
    }.stringify_keys!,
    
    :about => {
      :story => 'MACOK è un azienda nata nel 1992 dall\'esperienza e dalla passione di un team esperto. <br />
                Da allora continuiamo ad {{services}} di altissima qualità ai nostri clienti.',
        :services => 'offrire servizi',
      
      :philosophy => 'La filosofia che abbiamo è quella di fornire al cliente 
                      un servizio che soddisfi ogni sua necessit&agrave;, e 
                      che sia completamente personalizzato, per questo le vostre 
                      esigenze sono per noi una cosa importante.'
    }.stringify_keys!, 
    
    :services => {
      
    }.stringify_keys!, 
    
    :portfolio => {
      :our_clients => 'Tra i nostri clienti ci sono',
    }.stringify_keys!, 
    
    :contacts => {
      :contact_us   => 'Come Contattarci',
      :email        => 'E-mail',
      :phone        => 'Telefono', 
      :phone_number => '02 92 151 964', 
      :fax          => 'Fax', 
      :fax_number   => '02 92 502 183', 
      :address      => 'Indirizzo', 
      :open_map     => 'Apri la mappa in una nuova finestra'
    }.stringify_keys!
    
  }.stringify_keys!,
  
  
  ############################################################################
  ################################ en #####################################
  ############################################################################
  
  
  :'en' => {
    :cinevideoservices => 'Cinevideoservices', 
    
    :slogan     => 'in a certain sense the television is our sixth sense', 
    :production => 'produzione',
    :tax_code   => 'Permit&nbsp;No.:&nbsp;{{tax_code}}', 
    
    :sections => {
      :about      => "About us", 
      :services   => 'Services', 
      :portfolio  => 'Portfolio', 
      :contacts   => 'Contact us',
    }.stringify_keys!,
    
    :locale => {
      :name       => 'ENGLISH',
      :short      => 'en',
      :version    => 'See this page in {{link}}'
    }.stringify_keys!,
    
    :footer => {
      
    }.stringify_keys!, 
    
    :index => {
      :what         => 'MACOK is a {{production}} house.',
        :production => 'video production',
      :many         => 'We also offer many {{services}}.',
        :services   => 'other services',
      :where        => 'Located in Carugate, {{distance}}.', 
        :distance   => 'just a few kilometers away from Milano'
    }.stringify_keys!,
    
    :about => {
      :story => 'MACOK  is a production company founded in 1992  of experienced, 
                passion group of expert. Since then, Macok continue {{services}} 
                to our costumers.',
        :services => 'offering quality services',
      
      :philosophy => 'Our basic goal is to supply the needs of our clients the 
                      services with satisfaction and to completely personalized 
                      the exact requirements of our costumers, because for us 
                      it was the most important.'
    }.stringify_keys!, 
    
    :services => {
      
    }.stringify_keys!, 
    
    :portfolio => {
      :our_clients => 'Our Clients',
    }.stringify_keys!, 
    
    :contacts => {
      :contact_us   => 'Contact us',
      :email        => 'E-mail',
      :phone        => 'Phone', 
      :phone_number => '+ 39 (0) 2 92 151 964', 
      :fax          => 'Fax', 
      :fax_number   => '+ 39 (0) 2 92 502 183', 
      :address      => 'Address', 
      :open_map     => 'Open the map in a new window' 
    }.stringify_keys!
  }.stringify_keys!
}.stringify_keys!

