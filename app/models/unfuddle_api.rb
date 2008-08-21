require 'net/https'
require 'yaml'
require 'pp'

class UnfuddleAPI
	CONFIG = YAML.load(File.read(File.join(Merb.root, 'config', 'config.yml')))
	API_HOST = "#{CONFIG["unfuddle"]["subdomain"]}.unfuddle.com"
	#API_HOST = "127.0.0.1"

	def initialize(repository, username = CONFIG["unfuddle"]["username"], password = CONFIG["unfuddle"]["password"])
		@username, @password, @repository = username, password, repository
	end

	def submit_changesets(commits)
		commits.each do |commit|
			xml =  build_changeset_xml(commit)

			post_to_unfuddle("/api/v1/repositories/#{repository_id}/changesets?process_message_actions=true", xml, Net::HTTP::Post)
		end
	end

	def build_changeset_xml(commit)
	%(
			<changeset>
				<author-id type="integer">#{author_id(commit)}</author-id>
				<message>
					#{commit["message"]}

					#{commit["url"]}
				</message>
				<revision>#{commit["id"]}</revision>
				<created-at type="datetime">#{commit["timestamp"]}</created-at>
			</changeset>
		)
	end

	def post_to_unfuddle(path, xml, method = Net::HTTP::Put)
		http = Net::HTTP.new(API_HOST, CONFIG["unfuddle"]["use_ssl"] ? 443 : 80)

		# if using ssl, then set it up
		if CONFIG["unfuddle"]["use_ssl"]
			#http.use_ssl = true
			#http.verify_mode = OpenSSL::SSL::VERIFY_NONE
		end

		begin
			request = method.new(path, {'Content-type' => 'application/xml'})
			request.basic_auth @username, @password
			request.body = xml if xml

			response = http.request(request)
			response.body
		rescue => e
			raise
			return false
		end
	end

	def project_id
		CONFIG["repositories"][@repository["name"]]["unfuddle_project_id"]
	end

	def author_id(commit)
		CONFIG["unfuddle"]["people"][commit["author"]["email"]]
	end
	
	def repository_id
		CONFIG["repositories"][@repository["name"]]["repository_id"]
	end
end
