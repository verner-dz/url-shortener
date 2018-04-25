$(document).ready(function () {
  startUp();
});


$(document).ready(function () {
  $("#shorten").on("click", function() {

    var url = $("#shorten_url").val();

    $.ajax({
      type: "POST",
      url: "/create",
      data: url
    })

  });

});


  $(".js-invite-friends").on("click", function() {
    $(".js-invite-friends-span").hide();
    $(".js-loading-invites").show();
    var emails_arr = $(".js-email-text-area").val().split(",");
    $.ajax({
      type: "POST",
      url: "/send_referral_emails",
      data: {emails: emails_arr},
      success: function(){
        $("#js-success-email-modal").show();
        $(".js-email-modal").hide();
        setTimeout(function() {
          $("#js-success-email-modal").fadeOut();
        }, 2000);
      },
      error: function() {
        setTimeout(function() {
          $(".js-email-modal").fadeOut();
        }, 2000);
      }
    });
  });
