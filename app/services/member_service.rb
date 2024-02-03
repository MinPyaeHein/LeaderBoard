# app/services/member_service.rb


    class MemberService
      def initialize(params)
        puts "Initializing!!"
        @params = params
      end
  
      def create_member
        puts "Arrive create member!!"

        username, domain = @params[:email].split("@")
        member = ::Member.create(name: username, address: @params[:address], desc: @params[:desc])
        return member unless member.persisted?
        # password = SecureRandom.hex(8)
        # user =  ::User.create(email: @params[:email], password: password,member_id: member.id)
        # SendPasswordEmailJob.perform_later(@params[:email], password, username) if user.persisted?
        member
      
      end
      def destroy_member(member_id)
        member = ::Member.find_by(id: member_id)
  
        if member.present?
          member.update(active: false)
          member.users.update_all(active: false)
          { message: 'Member and associated users deactivated successfully', status: :ok }
        else
          { message: 'Member not found', status: :not_found }
        end
      end

      private

      def send_password_email(member, password, user)
        MemberMailer.welcome_email(member, user, password).deliver_now
      end
    end

  