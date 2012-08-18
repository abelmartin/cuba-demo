$ ->
  window.HT = Handlebars.compile($('#htItem').html())

  $("#ProcessSearch").submit (e) ->

    e.preventDefault()
    $("#SearchResponseLoading img").show()
    form_data =
      Instrument: $('#InstrumentName').val()
      MinPrice: $('#MinPrice').val()
      MaxPrice: $('#MaxPrice').val()

    $.ajax(
      type:"POST"
      data: form_data
      dataType: "json"
      url:"/search"
      success: (resp) ->
        window.RSP = resp
        $("#SearchResponseLoading img").fadeOut()
        $("#SearchResponse").html( HT(resp) )
      error: (resp) ->
        $("#SearchResponseLoading img").fadeOut()
        $("#SearchResponse").html("Something Blew The Hell Up!"))
    null
