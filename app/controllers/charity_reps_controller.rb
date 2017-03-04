class CharityRepsController < ApplicationController
  before_action :require_login, only: [:show]
  before_action :require_correct_user, only: [:show]

  #create new donor in db
  def create
    @charityRep = CharityRep.new(charityRep_params)
    #if invalid, initialize flash errors, push specific errors into errors array to be displayed on page, redirect to root route
    valid_email_regex = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]+)\z/i
    flash[:errors_count] = 0
    if !@charityRep.valid?
      initialize_charityRepRegErrors_flash

      if (@charityRep.first_name == "")
        flash[:charityRep_reg_errors] << "Enter your first name"
        flash[:errors_count] += 1
      end

      if (@charityRep.last_name == "")
        flash[:charityRep_reg_errors] << "Enter your last name"
        flash[:errors_count] += 1
      end

      if ((@charityRep.email =~ valid_email_regex) == nil)
        flash[:charityRep_reg_errors] << "Enter a valid email address"
        flash[:errors_count] += 1
      end

      if(CharityRep.find_by_email(@charityRep.email))
        flash[:charityRep_reg_errors] << "Email already exists"
        flash[:errors_count] += 1
      end

      if(@charityRep.password == nil)
        flash[:charityRep_reg_errors] << "Enter your password"
        flash[:errors_count] += 1
      end

      if(@charityRep.charity_name == "")
        flash[:charityRep_reg_errors] << "Enter the name of your charity"
        flash[:errors_count] += 1
      end

      if(@charityRep.charitable_cause == "")
        flash[:charityRep_reg_errors] << "Enter your charity's cause"
        flash[:errors_count] += 1
      end

      if(@charityRep.money_requested == nil || @charityRep.money_requested == 0)
        flash[:charityRep_reg_errors] << "Enter requesting donation amount"
        flash[:errors_count] += 1
      end

      redirect_to "/"

    #if user input for all fields in charityRep registration form are valid, save in db, redirect to user's page via routes
    else
      @charityRep.save
      session[:charityRep_id] = @charityRep.id
      # binding.pry
      redirect_to "/charityRep/#{@charityRep.id}"
    end
  end

  #query db for various info needed to display on page
  def show
    #renders views/charity_reps/show.html.erb automatically
    @charityRep = CharityRep.find(params[:id])
  end

  private
  def charityRep_params
    params.require(:charityRep).permit(:first_name, :last_name, :email, :password, :charity_name, :charitable_cause, :money_requested)
  end
end
