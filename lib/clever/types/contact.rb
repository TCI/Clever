# frozen_string_literal: true

module Clever
  module Types
    class Contact < Base
      attr_reader :uid, :sis_id, :name, :students, :school, :district,
        :phone_type, :phone, :email

      def initialize(attributes = {}, *)
        @uid = attributes['id']
        @sis_id = dig_contact_role(attributes, "sis_id")
        @name = attributes.dig('name', 'last')
        @students = dig_contact_role(attributes, "student_relationships")
        @school = attributes['school']
        @district = attributes['district']
        @phone_type = dig_contact_role(attributes, "phone_type")
        @phone = dig_contact_role(attributes, "phone")
        @email = attributes['email']
      end

      private

      def dig_contact_role(attributes, key)
        attributes.dig('roles', 'contact', key)
      end
    end
  end
end
