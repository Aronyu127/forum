 namespace :dev do

 	 task :fake=> :environment do
     puts "create fake data"
     10.times do |i|
     	 e=Topic.create(:name=>Faker::App.name,:content=>Faker::Lorem.paragraph,:user_id=>1)
     end
   end
 end    