# To download production data instead of these seeds, run
# rake db:restore_production_dump

channels = [
  { name: 'command-line', twitter_hashtag: 'commandline', development: true },
  { name: 'computer-science', twitter_hashtag: 'computerscience', development: true },
  { name: 'devops', twitter_hashtag: 'devops', development: true },
  { name: 'elixir', twitter_hashtag: 'elixir', development: true },
  { name: 'emberjs', twitter_hashtag: 'emberjs', development: true },
  { name: 'git', twitter_hashtag: 'git', development: true },
  { name: 'html-css', twitter_hashtag: 'htmlcss', development: true },
  { name: 'javascript', twitter_hashtag: 'javascript', development: true },
  { name: 'mobile', twitter_hashtag: 'mobile', design: true },
  { name: 'rails', twitter_hashtag: 'rails', development: true },
  { name: 'react', twitter_hashtag: 'react', development: true },
  { name: 'ruby', twitter_hashtag: 'ruby', development: true },
  { name: 'sketch', twitter_hashtag: 'sketch', icon: 'sketch-icon.png', design: true },
  { name: 'sql', twitter_hashtag: 'sql', development: true },
  { name: 'testing', twitter_hashtag: 'testing', development: true },
  { name: 'vim', twitter_hashtag: 'vim', development: true },
  { name: 'workflow', twitter_hashtag: 'workflow', development: true },
]

puts "Creating #{channels.length} channels"
channels.each do |row|
  Channel.find_or_create_by!(name: row[:name]) do |channel|
    channel.twitter_hashtag = row[:twitter_hashtag]

    if row[:icon].present?
      Rails.root.join('spec/factories/files', row[:icon]).open do |f|
        channel.icon = f
      end
    end
  end
end
puts " ...done."

developers = [
  { username: 'andrew', email: 'andrew@headway.io', avatar: 'andrew-verboncouer.png' , first_name: 'Andrew', last_name: 'Verboncouer', title: 'Partner & Design Lead' },
  { username: 'jon', email: 'jon@headway.io', avatar: 'jon-kinney.png', first_name: 'Jon', last_name: 'Kinney', title: 'Partner & Development Lead' },
  { username: 'eric', email: 'eric@headway.io', avatar: 'eric-verboncouer.png', first_name: 'Eric', last_name: 'Verboncouer', title: 'Partner & Developer' },
  { username: 'tommy', email: 'tommy@headway.io', avatar: 'tommy-byrne.png', first_name: 'Tommy', last_name: 'Byrne', title: 'Developer' },
  { username: 'noah', email: 'noah@headway.io', avatar: 'noah-settersten.png', first_name: 'Noah', last_name: 'Setterston', title: 'Developer' },
  { username: 'tim', email: 'tim@headway.io', avatar: 'tim-gremore.png', first_name: 'Tim', last_name: 'Gremore', title: 'Developer' }
]

puts 'Creating developers'
developers.each do |row|
  Developer.find_or_create_by!(username: row[:username]) do |developer|
    developer.first_name = row[:first_name]
    developer.last_name  = row[:last_name]
    developer.email      = row[:email]
    developer.title      = row[:title]

    Rails.root.join('spec/factories/files', row[:avatar]).open do |f|
      developer.avatar = f
    end
  end
end
puts " ...done."

content = <<str
#{Phil.words(100).capitalize}

```ruby
'Let’s make Headway!'.split(/\\s+/).join(tag(:br))
```

#{Phil.words(50).capitalize}
str

posts = [
  {
    title: 'Breakup Lines with SplitJoin',
    developer: Developer.find_by(username: 'eric'),
    body: content,
    likes: rand(1..20),
    created_at: rand(30).days.ago,
    published_at: rand(30).days.ago
  },
  {
    title: 'Components in Components',
    developer: Developer.find_by(username: 'noah'),
    body: Phil.words(100).capitalize,
    likes: rand(1..20),
    created_at: rand(30).days.ago,
    published_at: rand(30).days.ago
  },
  {
    title: 'Importing accurate data through JSON',
    developer: Developer.find_by(username: 'andrew'),
    body: Phil.words(100).capitalize,
    likes: rand(1..20),
    created_at: rand(30).days.ago,
    published_at: rand(30).days.ago
  },
  {
    title: 'Remapping key shortcuts',
    developer: Developer.find_by(username: 'jon'),
    body: Phil.words(100).capitalize,
    likes: rand(1..20),
    created_at: rand(30).days.ago,
    published_at: rand(30).days.ago
  },
  {
    title: 'Inheriting link hrefs in javascript',
    developer: Developer.find_by(username: 'eric'),
    body: Phil.words(100).capitalize,
    likes: rand(1..20),
    created_at: rand(30).days.ago,
    published_at: rand(30).days.ago
  },
  {
    title: 'Request consolidation',
    developer: Developer.find_by(username: 'tommy'),
    body: Phil.words(100).capitalize,
    likes: rand(1..20),
    created_at: rand(30).days.ago,
    published_at: rand(30).days.ago
  },
  {
    title: 'An Elixir to soothe your pain',
    developer: Developer.find_by(username: 'tim'),
    body: Phil.words(100).capitalize,
    likes: rand(1..20),
    created_at: rand(30).days.ago,
    published_at: rand(30).days.ago
  }
]

puts "Creating posts"
posts.each do |post|
  Post.find_or_create_by!(title: post[:title]) do |p|
    p.developer    = post[:developer]
    p.body         = post[:body]
    p.likes        = post[:likes]
    p.created_at   = post[:created_at]
    p.published_at = post[:published_at]
    p.channels     = Channel.all.sample(rand(3).ceil)
  end
end
puts " ...done."
