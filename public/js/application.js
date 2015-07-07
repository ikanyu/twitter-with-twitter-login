$(document).ready(function() {
	$('#submit_tweet').submit(function(event){
		var tweet = $("#submit_tweet").serialize();
		event.preventDefault();
		$('#loader').show();
		$('#submitbutton').attr('disabled','disabled');
		$.ajax({
				type: "POST",
				url: "/",
				data: tweet,
				success: function(response){
					alert("submitted");
					$('#tweets').html(response);
				},
				error: function(){
					alert("Error Tweeting!");
				},
				complete: function(){
					$('#loader').hide();
					$('#submitbutton').attr('disabled',false);
				}
		});
	});
});
