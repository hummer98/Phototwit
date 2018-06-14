project_name = "TweetKouga"

desc "Initial setup"
task :setup do
  sh "brew install rbenv ruby-build rbenv-binstubs swiftlint mono0926/license-plist/license-plist node jq"
  sh "npm install"
  sh "echo 'if ! [[ $PATH =~ \"shims\" ]]; then eval \"$(rbenv init -)\" && source ~/.bash_profile; fi' >> ~/.bash_profile"
  sh "rbenv install `cat .ruby-version`" do |is_success, status|
    p "WARN: ignore error." unless is_success
  end
  sh "gem install bundler"
  Rake::Task["update"].invoke
end

desc "Open workspace"
task :open do
  sh "open #{project_name}.xcworkspace"
end

desc "library update"
task :update do
  sh "bundle install"
  sh "pod repo update"
  sh "pod install"
# sh "carthage checkout"
# sh "carthage build --platform iOS"
end

desc "run synx"
task :synx do |t|
  sh "synx #{project_name}.xcodeproj/"
end

desc "cocoapods付きplayground起動"
task :playground do |t|
  p "起動したらimport HydraAsyncをHydraに書き換えて, ⌘+Bで一度ビルドすること"
  # 使いたいライブラリがあったら,で複数並べる
  sh "cd Playgrounds; pod playgrounds HydraAsync,ObjectMapper"
end
