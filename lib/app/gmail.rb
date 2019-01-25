class Gmail


	def initialize

			get_email
			send_email
		
	end	

	def get_email(email, city, state)
		email = benoit.arthur.pro@gmail.com
		city = Nice
		state = PACA
	end


	def send_email

				# Initialisation de l'API
		service = Google::Apis::GmailV1::GmailService.new
		service.client_options.application_name = APPLICATION_NAME
		service.authorization = authorize

		# Création du contenu du message
		msg = Mail.new #msg est une instance de la classe « Mail ». On va définir ses variables d’instance
		msg.date = Time.now
		msg.subject = 'ceci est un test'
		msg.body = Text.new('coucou!', 'plain', 'charset' => 'us-ascii')
		msg.from = {'agencecoupdepouce@gmail.com' => 'Coucou Man'}
		msg.to   = {
		    get_email.email => nil,
		}

		# Création de la requête, insertion du contenu dans la propriété `raw`
		#(https://developers.google.com/gmail/api/v1/reference/users/messages/send)
		message = Google::Apis::GmailV1::Message.new(raw: msg.to_s)

		service.send_user_message('me', message)

		puts "le message a été envoyé"
		
	end


end