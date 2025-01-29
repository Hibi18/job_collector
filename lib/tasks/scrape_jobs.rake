require 'nokogiri'
require 'open-uri'

namespace :jobs do
  desc "Scrape job listings from example.com"
  task scrape: :environment do
    url = 'https://example.com/jobs' # 仮のURL
    doc = Nokogiri::HTML(URI.open(url))

    doc.css('.job-card').each do |job|
      title = job.css('.job-title').text.strip
      location = job.css('.job-location').text.strip
      salary = job.css('.job-salary').text.strip
      company = job.css('.job-company').text.strip

      # Jobモデルにデータを保存
      Job.create(title: title, location: location, salary: salary, company: company)
    end

    puts "Jobs scraped and saved successfully!"
  end
end
