module Parliaments
  module Houses
    class MembersController < ApplicationController
      before_action :data_check, :build_request

      ROUTE_MAP = {
        index:   proc { |params| Parliament::Utils::Helpers::ParliamentHelper.parliament_request.parliament_house_members.set_url_params({ parliament_id: params[:parliament_id], house_id: params[:house_id] }) },
        a_to_z:   proc { |params| Parliament::Utils::Helpers::ParliamentHelper.parliament_request.parliament_house_members.set_url_params({ parliament_id: params[:parliament_id], house_id: params[:house_id] }) },
        letters: proc { |params| Parliament::Utils::Helpers::ParliamentHelper.parliament_request.parliament_house_members_by_initial.set_url_params({ parliament_id: params[:parliament_id], house_id: params[:house_id], initial: params[:letter] }) }

        # Currently, a_to_z renders the same data as index, so this is reflected in the api request
        # But there is a route available in the Data API
        # a_to_z:  proc { |params| ParliamentHelper.parliament_request.parliament_house_members_a_to_z.set_url_params({ parliament_id: params[:parliament_id], house_id: params[:house_id] }) },
      }.freeze

      def index
        @parliament, @house, @people, @letters = Parliament::Utils::Helpers::FilterHelper.filter_letters(@request, 'ParliamentPeriod', 'House', 'Person')
        @parliament = @parliament.first
        @house      = @house.first
        @people     = @people.sort_by(:sort_name)
        @letters    = @letters.map(&:value)
      end

      def a_to_z
        @parliament, @house, @letters = Parliament::Utils::Helpers::FilterHelper.filter_letters(@request, 'ParliamentPeriod', 'House')
        @parliament = @parliament.first
        @house      = @house.first
        @letters    = @letters.map(&:value)
        @all_path = :parliament_house_members_path
      end

      def letters
        @parliament, @house, @people, @letters = Parliament::Utils::Helpers::FilterHelper.filter_letters(@request, 'ParliamentPeriod', 'House', 'Person')
        @parliament = @parliament.first
        @house      = @house.first
        @people     = @people.sort_by(:sort_name)
        @letters    = @letters.map(&:value)
        @all_path = :parliament_house_members_path
      end
    end
  end
end
