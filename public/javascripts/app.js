$(function(){

  window.HT = Handlebars.compile($('#htItem').html());

  $("#ProcessFeed").submit(function(e){

    e.preventDefault();
    $("#RSSResponseLoading img").show();

    $.ajax({
      type:"POST",
      data:{RSSLink:$("#RSSLink").val()},
      dataType: "json",
      url:"/process_rss",

      success: function(resp){
        window.RSP = resp

        $("#RSSResponseLoading img").fadeOut();
        $("#RSSResponse").html( HT(resp) );
      },

      error: function(resp){
        $("#RSSResponseLoading img").fadeOut();
        $("#RSSResponse").html("Something Blew The Hell Up!");
      }
    });
  });

});