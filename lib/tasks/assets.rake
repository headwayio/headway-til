Rake::Task["assets:precompile"].clear
namespace :assets do
  task 'precompile' do
    # Monkeypatch asset precompilation so Heroku skips it. Instead, we need to
    # run `webpack -p` to compile our assets and store them in public/. We also
    # need to commit these assets before deploying. This needs to be improved
    # (probably with a Heroku buildpack).
    # See http://pixelatedworks.com/articles/replacing-the-rails-asset-pipeline-with-webpack-and-yarn
    puts "#----- Skip asset precompilation -----#"
  end
end
