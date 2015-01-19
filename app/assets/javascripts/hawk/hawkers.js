// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
//= require hawk/hawk_xpath

$( document ).ready(function() {
  $('#select').click( function(){
    var selection = document.getSelection();
    if(selection) {
      var e = selection.anchorNode.parentNode,
        x_path = Hawk.getElementXPath(e),
        id = $("#hawker_id").val();
      saveXpath(x_path, id);
    }
  });
});

var saveXpath = function(x_path, id){
  $.ajax({
    url: '/hawk/hawkers/'+id+'/save_xpath',
    data: {xpath: x_path},
    success: function(data) {
      $('#notice').text(data.text).show('slow');
      setTimeout(function(){$('#notice').hide('slow')}, 5000);
    }
  });
}
