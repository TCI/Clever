# frozen_string_literal: true

module Clever
  module Types
    class Section < Base
      attr_reader :uid,
                  :name,
                  :period,
                  :course,
                  :grades,
                  :subjects,
                  :students,
                  :teachers,
                  :term_id,
                  :provider,
                  :school_uid,
                  :primary_teacher_uid

      def initialize(attributes = {}, *)
        @uid                 = attributes['id']
        @name                = attributes['name']
        @period              = attributes['period']
        @course              = attributes['course']
        @grades              = [presence(attributes['grade'])].compact
        @subjects            = [presence(attributes['subject'])].compact
        @students            = attributes['students']
        @teachers            = attributes['teachers']
        @term_id             = attributes['term_id']
        @primary_teacher_uid = attributes['teacher']
        @school_uid          = attributes['school']
        @provider            = 'clever'
      end
    end
  end
end
