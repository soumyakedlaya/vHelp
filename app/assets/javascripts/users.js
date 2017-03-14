// jQuery for sliding registration forms and errors box

var gRegFormOpen = false; //no registration forms are open
var gNumButtonClicked = 0; //sign up buttons haven't been clicked
$(document).ready(function(){
  // console.log("Page reloaded")
  var effect = "slide";
  var options = { direction: "right"};
  var duration = "slow";

  //when user clicks sign up as donor: gNumButtonClicked is incremented by 1
  $('#donor_signup').click(function(){
    gNumButtonClicked += 1;

    //Checks if any registration form is open from a previous button click. Hides any forms, error windows which are shown.
    if(gRegFormOpen == true){
      $('#charityRep').hide();
      $('#charityRep_reg_errors').hide();
    }

    //When sign up as donor button is clicked, toggle open the donor registration form and set gRegFormOpen to true
    $('#donor').toggle(effect, options, duration);
    gRegFormOpen = true;

    //When there are registration errors, it is a new GET request to the home page, so all variables re-initialize.
    //If there are donor registration errors open, hide the errors when the sign up as donor button is clicked AGAIN (toggle close the donor registration form)
    if (gNumButtonClicked%2 == 1){
      $('#donor_reg_errors').hide();
    }
  });

  //check if the donor registration errors box exists. If it does, show the errors and show the donor registration form. Set gRegFormOpen to true
  if($('#donor_reg_errors').length >0){
    $('#donor_reg_errors').show();
    $('#donor').show();
    gRegFormOpen = true;
  }

  //when user clicks sign up your charity: gNumButtonClicked is incremented by 1
  $('#charityRep_signup').click(function(){
    gNumButtonClicked += 1;

    //Checks if any registration form is open from a previous button click. Hides any forms, error windows which are shown.
    if (gRegFormOpen == true){
      $('#donor').hide();
      $('#donor_reg_errors').hide();
    }

    //When sign up your charity button is clicked, toggle open the charity registration form and set gRegFormOpen to true
    $('#charityRep').toggle(effect, options, duration);
    gRegFormOpen = true;

    //When there are registration errors, it is a new GET request to the home page, so all variables re-initialize.
    //If there are charity registration errors open, hide the errors when the sign up your charity button is clicked AGAIN (toggle close the charity registration form)
    if (gNumButtonClicked%2 == 1){
      $('#charityRep_reg_errors').hide();
    }
  });

  //check if the charityrep registration errors box exists. If it does, show the errors and show the charityRep registration form. Set gRegFormOpen to true
  if($('#charityRep_reg_errors').length >0){
    $('#charityRep_reg_errors').show();
    $('#charityRep').show();
    gRegFormOpen = true;
  }
});
