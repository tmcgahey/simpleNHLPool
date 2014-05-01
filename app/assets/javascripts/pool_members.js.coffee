# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  availableSkaters = $('#skaters').data('url');

  if($('#skaterSearch'))
    $('#skaterSearch').autocomplete({
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
    }).data('ui-autocomplete')._renderItem = (ul, item) ->
      return $('<li>').append('<a>' + item.label + ' - ' + item.team + '</a>').appendTo(ul);
