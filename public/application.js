$(document).ready(function() {
  $("form#create_event").submit(function(event) {
    event.preventDefault();
    var data =  {
      name: this.name.value,
      location: this.location.value,
      starts_at: this.starts_at.value,
      ends_at: this.ends_at.value,
      user_id: this.user_id.value 
    }
    console.log(data);

     $.post('/create_event', data, function(response) {
      console.log(response);
      $("#my_events").append(response);
     })
  });

  $("#log_in").click(function(e) {
    e.preventDefault;
    $("#login_form").slideToggle();
  })

});
