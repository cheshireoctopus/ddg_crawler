require 'sinatra'
require 'sinatra/reloader'
require 'mechanize'
require 'json'

get '/:query' do
  agent = Mechanize.new
  page = agent.get('http://duckduckgo.com')
  form = page.form('x')

  form.q = params[:query].to_s
  page = agent.submit(form)

  results = {}
  page.search('.links_main').each do |link|
    results.store(link.at("a").inner_html.to_s.gsub("<b>","").gsub("</b>",""), link.at("a")[:href]).to_json
  end

  puts results
end



