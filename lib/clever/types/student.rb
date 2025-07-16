# frozen_string_literal: true

module Clever
  module Types
    class Student < Base
      attr_reader :uid,
                  :first_name,
                  :last_name,
                  :provider

      def initialize(attributes = {}, client: nil)
        @district_username = attributes.dig('roles', 'student', 'credentials', 'district_username')
        @email             = attributes['email']
        @first_name        = attributes['name']['first']
        @last_name         = attributes['name']['last']
        @provider          = 'clever'
        @sis_id            = attributes.dig('roles', 'student', 'sis_id')
        @uid               = attributes['id']
        @username          = username(client)
      end

      def username(client = nil)
        return @username if defined?(@username)

        username_source = client&.username_source
        username = presence(username_from(username_source)) || default_username

        if client&.student_username_search_for
          username = username&.gsub(client.student_username_search_for, client.student_username_replace_with || '')
        end

        @username = username
      end

      def to_h
        {
          uid: @uid,
          first_name: @first_name,
          last_name: @last_name,
          username: @username,
          provider: @provider
        }
      end

      private

      def username_from(username_source)
        return if blank?(username_source)

        presence(instance_variable_get("@#{username_source}"))
      end

      def default_username
        presence(@district_username) || presence(@email) || @sis_id
      end
    end
  end
end
