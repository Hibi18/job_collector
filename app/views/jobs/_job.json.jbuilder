json.extract! job, :id, :title, :location, :salary, :company, :created_at, :updated_at
json.url job_url(job, format: :json)
