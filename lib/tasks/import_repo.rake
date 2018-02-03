namespace :repo do
  task import: :environment do
    dir = ENV["REPO_DIR"]
    repo_name = ENV["REPO_NAME"]
    puts "Import #{dir}/#{repo_name}"
    ImportArticleRepoService.new(dir, repo_name).execute
    puts "Import Success"
  end
end