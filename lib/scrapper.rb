require 'rubygems'
require 'nokogiri'
require 'open-uri'
def scrapper_depart
  doc2=Nokogiri::HTML(open("http://www.annuaire-des-mairies.com"))
  adresse2 = doc2.css(".lien.txt")
def scrapper(url) #capture url des villes du 95
  #url = "http://www.annuaire-des-mairies.com/val-d-oise.html"
  doc2 = Nokogiri::HTML(open(url))
  adresse2 = doc2.css('.lientxt')
  noms = []
  villes = []
  emails = []
  adresse2.each do |link|
    p="http://www.annuaire-des-mairies.com"	
    p+=link['href'][1..-1]
    noms << p
    q=link['href'][1..-1]
    r=q.split('/')
    s=r[2]
    t=s.split('.')		
    ville=t[0]
    villes << ville	
  end
  noms.each do |adresse|
    doc3 = Nokogiri::HTML(open(adresse))
    adresse3 = doc3.css(".txt-primary")[3].text.split(" ")[2]
    if ['@'].include?(adresse3) == true
      emails << adresse3.to_s
    else
      emails << nil
    end
	
  end

#Hash[villes.zip(emails)].each do |ville,email|
#	puts ville+" => "+email
#my_hash=Hash[villes.zip(emails)]
#return my_hash(ville_entree)
end

def prenom
  gets.chomp
end

def send_email(scrapper(url))
  require 'net/smtp'
  scrapper(url).each do |ville, email|
    opts[:server]      ||= 'localhost'
    opts[:from]        ||= 'wyffemmuppo-6864@yopmail.com'
    opts[:from_alias]  ||= 'Exampler Exampler'
    opts[:subject]     ||= "You need to see this"
    opts[:recipient]   ||= email
    opts[:body]        ||= """Bonjour,
  Je m'appelle #{prenom}e et je permets de contacter la mairie de #{city_name} 
  à propos du remarquable travail que font Les Restos du Coeur. Cette association répand le bien dans la France et aide les plus démunis à s'en tirer.


  Avez-vous pensé à travailler avec eux ? Soutenir Les Restos du Coeur, c'est important pour notre cohésion sociale : rejoignez le mouvement !

Merci à vous"""

msg = <<END_OF_MESSAGE
From: #{opts[:from_alias]} <#{opts[:from]}>
To: <#{opts[:recipient]}>
Subject: #{opts[:subject]}

#{opts[:body]}
END_OF_MESSAGE

    Net::SMTP.start(opts[:server]) do |smtp|
      smtp.send_message msg, opts[:from], to
    end
  end
end
