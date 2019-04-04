# frozen_string_literal: true

module Clever
  module Types
    class Section < Base
      attr_reader :uid,
                  :name,
                  :period,
                  :course,
                  :grades,
                  :students,
                  :teachers,
                  :provider

      def initialize(attributes = {})
        data      = attributes['data']
        @uid      = data['id']
        @name     = data['name']
        @period   = data['period']
        @course   = data['course']
        @grades   = data['grade']
        @students = data['students']
        @teachers = data['teachers']
        @provider = 'clever'
      end
    end
  end
end
