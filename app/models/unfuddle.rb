class Unfuddle
	def initialize(payload)
		@payload = payload
	end

	def unfuddle!
		puts unfuddle_changesets!
	end

	def unfuddle_changesets!
		api = UnfuddleAPI.new(@payload["repository"])
		api.submit_changesets(self.commits)
	end

	protected

	def commits
		@commits ||= @payload["commits"]
	end
end
