# To download production data instead of these seeds, run
# rake db:restore_production_dump

channels = [
  { name: 'command-line', twitter_hashtag: 'commandline' },
  { name: 'computer-science', twitter_hashtag: 'computerscience' },
  { name: 'design', twitter_hashtag: 'design' },
  { name: 'devops', twitter_hashtag: 'devops' },
  { name: 'elixir', twitter_hashtag: 'elixir' },
  { name: 'emberjs', twitter_hashtag: 'emberjs' },
  { name: 'git', twitter_hashtag: 'git' },
  { name: 'html-css', twitter_hashtag: 'htmlcss' },
  { name: 'javascript', twitter_hashtag: 'javascript' },
  { name: 'mobile', twitter_hashtag: 'mobile' },
  { name: 'rails', twitter_hashtag: 'rails' },
  { name: 'react', twitter_hashtag: 'react' },
  { name: 'ruby', twitter_hashtag: 'ruby' },
  { name: 'sketch', twitter_hashtag: 'sketch', icon: 'sketch-icon.png' },
  { name: 'sql', twitter_hashtag: 'sql' },
  { name: 'testing', twitter_hashtag: 'testing' },
  { name: 'vim', twitter_hashtag: 'vim' },
  { name: 'workflow', twitter_hashtag: 'workflow' },
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
  { username: 'andrew', email: 'andrew@headway.io', avatar: 'andrew-verboncouer.png' },
  { username: 'jon', email: 'jon@headway.io', avatar: 'jon-kinney.png' },
  { username: 'eric', email: 'eric@headway.io', avatar: 'eric-verboncouer.png' },
  { username: 'tommy', email: 'tommy@headway.io', avatar: 'tommy-byrne.png' },
  { username: 'noah', email: 'noah@headway.io', avatar: 'noah-settersten.png' },
  { username: 'tim', email: 'tim@headway.io', avatar: 'tim-gremore.png' }
]

puts 'Creating developers'
developers.each do |row|
  Developer.find_or_create_by!(username: row[:username]) do |developer|
    developer.email = row[:email]

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
    developer: Developer.find_by(username: 'tim'),
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
    developer: Developer.find_by(username: 'noah'),
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
    p.channels     = Channel.all.sample(rand(3))
  end
end
puts " ...done."
