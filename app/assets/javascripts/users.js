// jQuery for sliding registration forms and errors box

var gRegFormOpen = false; //no registration forms are open
$(document).ready(function(){
  var effect = "slide";
  var options = { direction: "right"};
  var duration = "slow";

  //when user clicks sign up as donor, check if a registration form is open. If yes --> hide form. Check if errors box is open. If yes --> hide. Toggle slide donor registration form and set gRegFormOpen to true
  $('#donor_signup').click(function(){
    if(gRegFormOpen == true){
      $('#charityRep').hide();
    }
    if('#donor_reg_errors'.length >0 || '#charityRep_reg_errors'.length >0){
      $('#donor_reg_errors').hide();
      $('#charityRep_reg_errors').hide();
    }

    $('#donor').toggle(effect, options, duration);
    gRegFormOpen = true;
  });

  //when user clicks sign up your charity, check if a registration form is open. If yes --> hide form. Check if errors box is open. If yes --> hide. Toggle slide charityRep registration form and set gRegFormOpen to true
  $('#charityRep_signup').click(function(){
    if (gRegFormOpen == true){
      $('#donor').hide();
    }
    if('#charityRep_reg_errors'.length >0 || '#donor_reg_errors'.length >0){
      $('#charityRep_reg_errors').hide();
      $('#donor_reg_errors').hide();
    }
    $('#charityRep').toggle(effect, options, duration);
    gRegFormOpen = true;
  });
});
