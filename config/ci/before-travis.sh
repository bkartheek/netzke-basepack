# Start xvfb in preparation for cucumber
sh -e /etc/init.d/xvfb start

# fetch extjs
wget http://extjs.cachefly.net/ext-4.0.2a-gpl.zip
unzip -q -d spec/rails_app/public/ -n ext-4.0.2a-gpl.zip
mv spec/rails_app/public/ext-4.0.2a spec/rails_app/public/extjs

# cp db configuration
cp spec/rails_app/config/database.yml.travis  spec/rails_app/config/database.yml

# create mysql database
mysql -e 'create database nbt_test;'

# clone netzke-core and netzke-persistence gems into test project
mkdir -p spec/rails_app/vendor/gems
cd spec/rails_app/vendor/gems
git clone git://github.com/skozlov/netzke-core.git
cd netzke-core
git checkout tags/v0.7.4
cd ..
git clone git://github.com/skozlov/netzke-persistence.git
cd netzke-persistence
git checkout tags/v0.1.0
cd ../../..
bundle install
bundle exec rake db:migrate RAILS_ENV=test
cd ../..
