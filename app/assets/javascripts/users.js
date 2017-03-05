// jQuery for sliding registration forms and errors box

var gRegFormOpen = false; //no registration forms are open
$(document).ready(function(){
  var effect = "slide";
  var options = { direction: "right"};
  var duration = "slow";

  //when user clicks sign up as donor, check if a registration form is open. If a form is already open, hide the form. Toggle slide donor registration form and set gRegFormOpen to true
  $('#donor_signup').click(function(){
    if(gRegFormOpen == true){
      $('#charityRep').hide();
      $('#charityRep_reg_errors').hide();
    }

    $('#donor').toggle(effect, options, duration);
    gRegFormOpen = true;
  });

//check if the donor registration errors box exists. If it does, show the errors and show the donor registration form. Set gRegFormOpen to true
  if($('#donor_reg_errors').length >0){
    $('#donor_reg_errors').show();
    $('#donor').show();
    gRegFormOpen = true;
  }

  // when user clicks sign up your charity, check if a registration form is open. If a form is alraedy open, hide the form. Toggle slide charityRep registration form and set gRegFormOpen to true
  $('#charityRep_signup').click(function(){
    if (gRegFormOpen == true){
      $('#donor').hide();
      $('#donor_reg_errors').hide();
    }

    $('#charityRep').toggle(effect, options, duration);
    gRegFormOpen = true;
  });

//check if the charityrep registration errors box exists. If it does, show the errors and show the charityRep registration form. Set gRegFormOpen to true
  if($('#charityRep_reg_errors').length >0){
    $('#charityRep_reg_errors').show();
    $('#charityRep').show();
    gRegFormOpen = true;
  }
});
