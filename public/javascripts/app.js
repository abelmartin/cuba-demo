$(function(){
  $("#ProcessFeed").submit(function(e){
    e.preventDefault();
    $("#RSSResponseLoading img").show();
    $.ajax({
      type:"POST",
      data:{RSSLink:$("#RSSLink").val()},
      dataType: "json",
      url:"/process_rss",
      success: function(resp){
        // debugger
        console.log(resp);
        window.RSP = resp;
        $("#RSSResponseLoading img").fadeOut();
        $("#RSSResponse").html(resp.length + " entries");
      },
      error: function(resp){
        alert("Something Blew The Hell Up!");
      }
    });
  });

});