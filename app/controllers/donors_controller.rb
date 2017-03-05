class DonorsController < ApplicationController
  before_action :require_login, except: [:create]
  before_action :require_correct_user, only: [:show, :donation]

#create new donor in db
  def create
    @donor = Donor.new(donor_params)
    #if invalid, initialize respective flash errors, push specific errors into errors array to be displayed on page, redirect to root route
    valid_email_regex = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]+)\z/i
    flash[:errors_count] = 0

    if !@donor.valid?
      initialize_donorRegErrors_flash

      if (@donor.first_name == "")
        flash[:donor_reg_errors] << "Enter your first name"
        flash[:errors_count] += 1
      end

      if (@donor.last_name == "")
        flash[:donor_reg_errors] << "Enter your last name"
        flash[:errors_count] += 1
      end

      # checks if email entered matches regex pattern. If there is not a complete match, returns nil. if there is a match, returns the index of the first match
      if ((@donor.email =~ valid_email_regex) == nil)
        flash[:donor_reg_errors] << "Enter a valid email address"
        flash[:errors_count] += 1
      end

      if(Donor.find_by_email(@donor.email))
        flash[:donor_reg_errors] << "Email already exists"
        flash[:errors_count] += 1
      end

      if(@donor.password == nil)
        flash[:donor_reg_errors] << "Enter your password"
        flash[:errors_count] += 1
      end

      if(@donor.money_available == nil || @donor.money_available == 0)
        flash[:donor_reg_errors] << "Enter donation amount ($25-$10,000)"
        flash[:errors_count] += 1
      end

      redirect_to "/"

    #if user input for all fields in donor registration form are valid, save in db, redirect to user's page via routes
    else
      @donor.save
      session[:donor_id] = @donor.id
      redirect_to "/donor/#{@donor.id}"
    end
  end

  #query db for various info needed to display on page
  def show
    #renders views/donors/show.html.erb automatically
    @charityReps = CharityRep.all
    @donor = current_user
    @displaydonations = Donor.find(current_user.id).donations
  end

# when donor user clicks donate on form, find the charityRep's user id in db
#create entry in donation model with charityRep_id, donor_id and $amount IF amount is less than donor's account balance
#if amount is greater than donor's acct balance, flash error message and do not save in db
  def donation
    @charityRep = CharityRep.find(params[:charityRep_id])
    amount = params[:money_raised].to_i

    if amount <= current_user.money_available
      donation = Donation.create(donor: current_user, charity_rep:@charityRep, amount: amount)

      if @charityRep.money_raised == nil
        # if charityRep's money_raised = nil, update amt of money_raised in db with amt the donor donates, update amt of money_requested
        updated_money_raised_amt = amount
        updated_money_amt = @charityRep.money_requested - amount
        @charityRep.update(money_raised: updated_money_raised_amt, money_requested: updated_money_amt)
      else
        # if charityRep has already raised money, update amt of money_raised, update amt of money_requested
        updated_money_raised_amt = @charityRep.money_raised + amount
        updated_money_amt = @charityRep.money_requested - amount
        @charityRep.update(money_raised: updated_money_raised_amt, money_requested: updated_money_amt)
      end

      #update donor's account balance
      updated_acctbal = current_user.money_available - amount
      current_user.update(money_available: updated_acctbal)

    elsif current_user.money_available == 0
      initialize_donationErrors_flash
      flash[:donation_errors] << "you can no longer donate since your account balance is 0!"
    else
      initialize_donationErrors_flash
      flash[:donation_errors] << "Not enough money in your account. Please select a lower amount"
    end
    redirect_to "/donor/#{current_user.id}"
  end

  private
  def donor_params
    params.require(:donor).permit(:first_name, :last_name, :email, :password, :money_available)
  end
end
