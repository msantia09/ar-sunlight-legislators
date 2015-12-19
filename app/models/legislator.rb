require_relative '../../db/config'

class Legislator < ActiveRecord::Base
# implement your Student model here

	# validates :email, :format => { :with => /[a-z]*@[a-z]*.[a-z]{2,}/}
	# validates :email, :uniqueness => true
	# validates :age, :numericality => { :greater_than => 5}
	# validates :phone, :format => {:with => /\D\d{3}\D{2}\d{3}\D\d{4}\D{2}\d{4}/}
	def self.quest1(state)
		all_legislators = self.where(state: state, title: "Rep")
		all_legislators.each do |l|
			puts l.firstname + " " + l.lastname
		end
	end

	def self.quest2(state)
		all_legislators = self.where(state: state, title: "Sen").order(:firstname).limit(2)
		all_legislators.each do |l|
			puts l.firstname + " " + l.lastname
		end
	end

	def self.quest3(party)
		all_legislators = self.where(party: party, title: "Sen").order(:firstname)
		all_legislators.each do |l|
			puts " #{l.title}. #{l.firstname} #{l.lastname} | #{l.party} |"
		end
	end

	def self.quest4(party)
		all_legislators = self.where(party: party, title: "Rep").order(:firstname)
		all_legislators.each do |l|
			puts " #{l.title}. #{l.firstname} #{l.lastname} | #{l.party} |"
		end
	end

	def self.quest5(title, name)
		all_legislators = self.where(title: title, firstname: name)
		all_legislators.each do |l|
			puts "Name: #{title}. #{l.name_suffix} #{l.firstname} #{l.middlename} #{l.lastname}"
			puts "Phone: #{l.phone}"
			puts "Fax: #{l.fax}"
			puts "Website: #{l.website}"
			puts "Webform: #{l.webform}"
			puts "Party affiliation: #{l.party}"
			puts "Gender: #{l.gender}"
			puts "Birthdate: #{l.birthdate}"
			puts "Twitter id: #{l.twitter_id}"
		end
	end

	def self.quest6(title, name)
		all_legislators = self.where(title: title, firstname: name)
		all_legislators.each do |l|
			if l.in_office == 1
				puts "#{l.title}. #{l.firstname} #{l.lastname} is currently in office."
			else
				puts "#{l.title}. #{l.firstname} #{l.lastname} is currently NOT in office."
			end
		end
	end

	def self.ar_quest1(state)
		all_sens = self.where(state: state, title: "Sen").order(:lastname)
		all_sens.each do |l|
			puts "#{l.lastname} #{l.firstname} \(#{l.party}\)"
		end

		all_reps = self.where(state: state, title: "Rep")
		all_reps.each do |l|
			puts "#{l.lastname} #{l.firstname} \(#{l.party}\)"
		end
	end

	def self.ar_quest2(gender)
		num_of_sens = self.where(title: "Sen", in_office: "1").count
		num_of_gender_sens = self.where(title: "Sen", gender: gender, in_office: "1").count
		num_of_reps = self.where(title: "Rep", in_office: "1").count
		num_of_gender_reps = self.where(title: "Rep", gender: gender, in_office: "1").count
		perc_of_gender_sens = ((num_of_gender_sens.to_f/num_of_sens.to_f)*100).to_i
		perc_of_gender_reps = ((num_of_gender_reps.to_f/num_of_reps.to_f)*100).to_i
		puts "#{gender} Senators: #{num_of_gender_sens} \(#{perc_of_gender_sens}\%\)"
		puts "#{gender} Representatives: #{num_of_gender_reps} \(#{perc_of_gender_reps}\%\)"
	end

	def self.ar_quest3
		all_act_legislators = self.where(in_office: "1")
		state_arr = all_act_legislators.uniq.pluck(:state)
		by_state_legislators = []

		state_arr.each do |e_state|
			num_of_sens = all_act_legislators.where(state: e_state, title: "Sen").count
			num_of_reps = all_act_legislators.where(state: e_state, title: "Rep").count
			by_state_legislators << [e_state, num_of_sens, num_of_reps]
		end

		# puts "...... before sort......"
		# by_state_legislators.each do |line|
		# 	p line
		# end

		sorted_by_state_legislators = by_state_legislators.sort{|a,b| (b[2]+b[1]) <=> (a[2]+a[1])}

		sorted_by_state_legislators.each do |line|
			if line[1] > 0 and line[2] > 0
				puts "#{line[0]}: #{line[1]} Senators, #{line[2]} Representative(s)"
			end
		end
	end		

	def self.ar_quest4
		total_sens = self.where(title: "Sen").count
		total_reps = self.where(title: "Rep").count
		puts "Senators: #{total_sens}"
		puts "Representatives: #{total_reps}"
	end

	def self.ar_quest5
		total_inactive = self.where(in_office: 0).count
		total_congress_before = self.all.count
		puts "Total congress members \(before\): #{total_congress_before}"
		self.destroy_all(in_office: "0")
		total_congress_after = self.all.count
		puts "Total congress members \(after\): #{total_congress_after}"

		self.ar_quest4
	end

end
