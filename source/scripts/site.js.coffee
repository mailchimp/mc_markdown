

$form = $('#form')
$input = $('#form #text')
$target = $('#target')

$input.on "keyup", (e) ->

  val = $input.val()

  $.ajax(
    type: "POST"
    url: $form.attr("action")
    data: "markdown=" + val
    success: ( data, textStatus, jqXHR ) ->
      change_target( data )
  )

change_target = ( text ) ->
  $target.html( text )