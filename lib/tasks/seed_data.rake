require 'open-uri'
require 'csv'
require 'set'

COUNTRY_CODE_DIRECTORY = "public/country_codes.csv"
COUNTRY_CODE_URL = "https://r2.datahub.io/clt98ab600006l708tkbrtzel/master/raw/data.csv"

DEV_LIST_DIRECTORY = "public/lists/sample_upload.csv"
PROD_LIST_DIRECTORY = "public/lists/destinations_list.csv"


namespace :seed_flags do
    desc "This task downloads country code data"
    task :download_file do
        open(COUNTRY_CODE_DIRECTORY, "wb") do |file|
            file << URI.open(COUNTRY_CODE_URL).read
        end
    end

    task :seed_database_table => :environment do
        begin
            Flag.delete_all
        rescue ActiveRecord::InvalidForeignKey
            Rails.logger.error 'Replace of flags table violates foreign key constraints.'
            Rails.logger.error 'Run `rake seed_destinations:seed_dependencies` first.'
            raise
        end
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


namespace :seed_destinations do
    desc "This task uploads destination possible attributes"
    task :seed_dependencies => :environment do
        Destination.delete_all
        Region.delete_all
        Language.delete_all
        regions_in_memory = Set[]
        languages_in_memory = Set[]
        CSV.foreach(PROD_LIST_DIRECTORY, headers: true) do |row|
            languages_in_memory.add(row["Language"])
            if row["Language"].present?
                languages_in_memory.add(row["Language"])
            end
            regions_in_memory.add(row["Macroregion"])
        end
        regions_in_memory.each do |region|
            Region.find_or_create_by(name: region)
        end
        languages_in_memory.each do |language|
            Language.find_or_create_by(name: language)
        end
    end

    task :generate_destinations, [:use_partial_list] => :environment do |t, args|
        options = {}
        opts = OptionParser.new
        opts.banner = "Usage: rake seed_destinations:generate_destinations [options]"
        opts.on("-d", "--[no-]dev") { |dev| options[:dev_flag] = dev}
        args = opts.order!(ARGV) {}
        opts.parse!(args)

        Destination.delete_all
        if options[:dev_flag]
            directory = DEV_LIST_DIRECTORY
        else
            directory = PROD_LIST_DIRECTORY
        end
        CSV.foreach(directory, headers: true) do |row|
            Destination.create!(
                name: row["Region"],
                city: row["Major City"],
                language_primary: Language.find_by(name: row["Language"]),
                language_secondary: Language.find_by(name: row["Language2"]),
                flag_primary: Flag.find_by(code: row["Country Code"]),
                flag_secondary: Flag.find_by(code: row["Secondary Code"]),
                region: Region.find_by(name: row["Macroregion"]),
                divisions: row["Divisions"]
            )
        end
    end
end