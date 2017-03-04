class SessionsController < ApplicationController
  def index
    #renders views/sessions/index.html.erb automatically
  end

  def create
    #search Donor and CharityRep models for email entered by user
    donor = Donor.find_by_email(params[:email])
    charityRep = CharityRep.find_by_email(params[:email])
    flash[:errors_count] = 0

    #login errors (fields left blank)
    if(params[:email] == "")
      initialize_loginErrors_flash
      flash[:login_errors] << "Enter a valid email address"
      flash[:errors_count] += 1
      if (params[:password] == "")
        flash[:login_errors] << "Enter your password"
        flash[:errors_count] += 1
        redirect_to "/login"
      else
        redirect_to "/login"
      end
    elsif(params[:password] == "")
      initialize_loginErrors_flash
      flash[:login_errors] << "Enter your password"
      flash[:errors_count] += 1
      redirect_to "/login"
    else
      #if email and password match what is in db, store user in a session variable
      if donor && donor.authenticate(params[:password])
        session[:donor_id] = donor.id
        redirect_to "/donor/#{donor.id}"
      elsif charityRep && charityRep.authenticate(params[:password])
        session[:charityRep_id] = charityRep.id
        redirect_to "/charityRep/#{charityRep.id}"
      #if email and password don't match what is in db, redirect to login page
      else
        initialize_loginErrors_flash
        flash[:login_errors] << "Invalid email and password combination"
        flash[:errors_count] += 1
        redirect_to "/login"
      end
    end
  end

#if user clicks on log out button, set session variable to nil to log out the user
  def destroy
    if session[:donor_id]
      session[:donor_id] = nil
      redirect_to "/"
    else
      session[:charityRep_id] = nil
      redirect_to "/"
    end
  end
end
