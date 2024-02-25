require 'open-uri'
require 'csv'
require 'pry'

COUNTRY_CODE_DIRECTORY = "public/country_codes.csv"
COUNTRY_CODE_URL = "https://datahub.io/core/country-list/r/data.csv"

namespace :seed_flags do
    desc "This task downloads country code data"
    task :download_file do
        open(COUNTRY_CODE_DIRECTORY, "wb") do |file|
            file << URI.open(COUNTRY_CODE_URL).read
        end
    end

    task :seed_database_table => :environment do
        Flag.delete_all
        flags_in_memory = []
        CSV.foreach(COUNTRY_CODE_DIRECTORY, headers: true) do |row|
            flags_in_memory << row
        end

        time = Time.now.getutc

        Flag.copy_from_client [:code, :created_at, :updated_at] do |copy|
            flags_in_memory.each do |f|
                copy << [f["Code"], time, time]
            end
        end
    end

    task :cleanup do
        File.delete(COUNTRY_CODE_DIRECTORY) if File.exist?(COUNTRY_CODE_DIRECTORY)
    end
end
