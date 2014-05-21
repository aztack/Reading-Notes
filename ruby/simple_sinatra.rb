#encoding:utf-8
require 'sinatra'
require 'json'
require 'pp'
#
# Start up Sinatra
#
set :port, 80
set :allow_origin, :any
set :protection, false

def json(file)
	File.read("#{file}.json",:encoding => 'utf-8')
end

def ok(*extra)
	resp = {errno:0, errmsg:''}
	resp.merge! extra.last unless extra.empty?
	resp.to_json
end

def error(errno,msg,*extra)
	resp = {errno:errno,errmsg:msg}
	resp.merge! extra.last unless extra.empty?
	resp.to_json
end

before do
	content_type :json
	headers 'Access-Control-Allow-Origin' => '*',
		'Access-Control-Allow-Methods' => ['OPTIONS','GET', 'POST']

	if request.request_method == "POST"
		params.merge!(JSON.parse(request.body.read))
	end
	pp params
end

options '/*' do
	response["Access-Control-Allow-Headers"] = "origin, x-requested-with, content-type"
end

get '/table' do
	ok :list => JSON.parse(File.read('MOCK_DATA.csv'))
end

