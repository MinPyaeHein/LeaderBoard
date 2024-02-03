# app/controllers/api/v1/members_controller.rb

module Api
    module V1
      class MembersController < ApplicationController
        before_action :set_service, only: [:create, :destroy]
        def index
          render json: Member.all
          # active_members = Member.includes(:users).where(active: true)
          # render json: active_members, include: :users
        end

        def destroy
      
          result =@service.destroy_member(params[:id])
          render json: result
        end
        def create
          member=@service.create_member
          if member
            render json: member, status: :created
          else
            render json: { errors: @service.create_member.errors.full_messages }, status: :unprocessable_entity
          end
        end

        private
        def member_params
          params.require(:member).permit(:email)
        end
        def set_service
          @service = MemberService.new(member_params)
        end

      end
    end
  end
  