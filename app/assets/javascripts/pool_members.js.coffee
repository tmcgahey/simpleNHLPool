# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->

  if($('#skaterSearch'))
    availableSkaters = $('#skaters').data('url');
    ac = $('#skaterSearch').autocomplete({
      minLength: 0,
      source: availableSkaters,
      focus: (event, ui) ->
        $('#skaterSearch').val(ui.item.label);
        return false
      ,
      select: (event, ui) ->
        $('#skaterSearch').val(ui.item.label);
        $('#nhlId').val(ui.item.value);
        return false;
    })

    if(ac)
      if(ac.data('ui-autocomplete'))
        ac.data('ui-autocomplete')._renderItem = (ul, item) ->
          return $('<li>').append('<a>' + item.label + ' - ' + item.team + '</a>').appendTo(ul);
