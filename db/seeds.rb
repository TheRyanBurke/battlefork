# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)
User.create([
	{:username => 'a_ryan', :password => 'test', :password_confirmation => 'test'},
	{:username => 'a_bryan', :password => 'test', :password_confirmation => 'test'},
	{:username => 'a_lion', :password => 'test', :password_confirmation => 'test'},
	{:username => 'a_cryin', :password => 'test', :password_confirmation => 'test'},
	{:username => 'b_lisa', :password => 'test', :password_confirmation => 'test'},
	{:username => 'b_bisa', :password => 'test', :password_confirmation => 'test'},
	{:username => 'b_pizza', :password => 'test', :password_confirmation => 'test'},
	{:username => 'b_visa', :password => 'test', :password_confirmation => 'test'}
])
