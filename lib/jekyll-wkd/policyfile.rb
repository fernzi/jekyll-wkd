# frozen_string_literal: true

module JekyllWKD
  class PolicyFile < ::Jekyll::Page
    def read_yaml(*)
      @data ||= {}
    end
  end
end
