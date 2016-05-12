$('document').ready(function(){
  $('#add-dose').on('click', function(event){
    event.preventDefault();
    $('#new-dose-form').removeClass('hidden');
  });
});
