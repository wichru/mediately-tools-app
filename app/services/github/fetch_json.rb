# frozen_string_literal: true

module Github
  class FetchJson
    def initialize(tool_name, language)
      @tool_name = tool_name
      @language = language
    end

    def call
      master_response == false ? subset_content : master_content
    end

    attr_reader :tool_name, :language

    private

    def master_content
      return false if master_response == false

      plain_content(master_response)
    end

    def subset_content
      return false if subset_response == false

      plain_content(subset_response)
    end

    def plain_content(response)
      JSON.parse(Base64.decode64(response.content))
    end

    def master_response
      @master_response ||= ::Github::Api.fetch_file(path: "#{tool_name}.#{language}.master.json")
    end

    def subset_response
      @subset_response ||= ::Github::Api.fetch_file(path: "#{tool_name}.#{language}.json")
    end
  end
end
