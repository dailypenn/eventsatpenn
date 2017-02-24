function attemptLogin(newAccount) {
  FB.login(function(response){
    if (response.status === "connected") {
      if (newAccount) {
        createNewAccount()
      } else {
        console.info('Logged in.')
        $('#loginModal').modal('toggle');
      }
    }
  });
}

function createNewAccount() {
  FB.api('/me', { locale: 'en_US', fields: 'first_name, last_name, email' }, function(userData) {
    $.post("/user", userData, function(res){
      console.log(res);
      if (res.status === "success") {
        $('.fb-connect-info').text("Welcome " + userData.first_name + " to Events@Penn! (User ID: " + userData.id + ", email: " + userData.email + ")");
        $('#loginModal').modal('toggle');
      } else {
        alert("ACCOUNT CREATION FAILED")
      }
    });
  });
}
