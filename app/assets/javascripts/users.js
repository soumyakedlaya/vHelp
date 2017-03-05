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
      $('#charityRep_reg_errors').hide();
    }
    // if($('#donor_reg_errors').length >0 || '#charityRep_reg_errors'.length >0){
    //   $('#donor_reg_errors').hide();
    //   $('#charityRep_reg_errors').hide();
    // }

    $('#donor').toggle(effect, options, duration);
    gRegFormOpen = true;
  });

  if($('#donor_reg_errors').length >0){
    $('#donor_reg_errors').show();
    $('#donor').show();
    gRegFormOpen = true;
  }



  // $('#reg_as_donor').click(function(){
  //   console.log("In reg_as_donor click function")
  //   if ('#donor_reg_errors'.length > 0){
  //     console.log("Length of donor_reg_errors: " + '#donor_reg_errors.length')
  //     $('#reg_as_donor').show();
  //     $('#donor_reg_errors').show();
  //   }
  // });

  // when user clicks sign up your charity, check if a registration form is open. If yes --> hide form. Check if errors box is open. If yes --> hide. Toggle slide charityRep registration form and set gRegFormOpen to true
  $('#charityRep_signup').click(function(){
    if (gRegFormOpen == true){
      $('#donor').hide();
      $('#donor_reg_errors').hide();
    }
    // if('#charityRep_reg_errors'.length >0 || '#donor_reg_errors'.length >0){
    //   $('#charityRep_reg_errors').hide();
    //   $('#donor_reg_errors').hide();
    // }
    $('#charityRep').toggle(effect, options, duration);
    gRegFormOpen = true;
  });

  if($('#charityRep_reg_errors').length >0){
    $('#charityRep_reg_errors').show();
    $('#charityRep').show();
    gRegFormOpen = true;
  }
});
