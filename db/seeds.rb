positions = [{name: "leader", abbr: "LD"}, 
  {name: "programmer", abbr: "PG"}, 
  {name: "chief executive officer", abbr: "CEO"}]
Position.create(positions)  


User.create(name: "Admin", email: "admin@example.com", password: "abc123", 
  password_confirmation: "abc123", admin: 1, position_id: 1, birthday: "1/1/2000")
users = []
(1..40).each do |i| 
  users << {name: "User#{i}", email: "user#{i}@example.com", password: "abc123", password_confirmation: "abc123",
    position_id: i%2+2, birthday: "2/2/2002", team_id: i%3+1}
end
User.create(users)


skills = [{name: "Ruby"}, {name: "SQL"}, {name: "PHP"}, {name: "Git"}]
Skill.create(skills)


user_skills = []
(1..40).each do |i|
  user_skills << {user_id: 2+Random.rand(39), skill_id: 1+Random.rand(4), 
    used_year_number: Random.rand(10), level: (1+Random.rand(6)).to_s}
end
UserSkill.create(user_skills)

teams = [
  {name: "Training", desc: "train new members", leader_id: 2},
  {name: "Rails", desc: "web development with Rails", leader_id: 3},
  {name: "Smartphone", desc: "smartphone development", leader_id: 4}
]
Team.create(teams)

projects = [
  {name: "Framgia Test System", desc: "framgia test system",
    abbr: "FTS", team_id: 1, leader_id: 2, start_date: Time.now.to_date,
    end_date: Time.now.to_date + 1},
  {name: "Framgia Game", desc: "framgia smartphone game",
    abbr: "FG", team_id: 3, leader_id: 4, start_date: Time.now.to_date,
    end_date: Time.now.to_date + 1}
]
Project.create(projects)