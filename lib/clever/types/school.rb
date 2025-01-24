# frozen_string_literal: true

module Clever
  module Types
    class School
      attr_reader :uid, :name, :number

      def initialize(attributes = {}, *)
        @uid      = attributes['id']
        @name     = attributes['name']
        @number   = attributes['school_number']
        @provider = 'clever'
      end
    end
  end
end
